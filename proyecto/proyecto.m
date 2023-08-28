clearvars; close all; clc;

% ------------------------------------------------------------------------
% PROYECTO ANÁLISIS DE IMÁGENES DIGITALES
% @autor LUIS BALLADO
% ------------------------------------------------------------------------

% Question box con más de tres opciones
% https://la.mathworks.com/matlabcentral/answers/454018-creating-a-question-box-with-more-than-3-options
opciones = {'geometricos','hue','cconvexo','esqueleto'}; 

[idx, tf] = listdlg('ListString', opciones,...
    'SelectionMode', 'Single', 'PromptString', 'Selecciona una caracteristica', 'Initialvalue', 1,'Name', 'Rasgos');

if tf
    respuesta = opciones{idx};
else
    return;
end

switch respuesta
    case 'geometricos'
        rasgos = 1;
         datos = load("rasgos_geom.mat");      % matriz de r. geometricos
    case 'hue'
        rasgos = 2;
        datos = load("rasgos_hue.mat");        % matriz de hue
    case 'cconvexo'
        rasgos = 3;
        datos = load("rasgos_ccx.mat");        % matriz de cerco convexo
    case 'esqueleto'
        rasgos = 4;
        datos = load("rasgos_esqueletos.mat"); % matriz de cerco convexo
end

clases = load("clases.mat");   % matriz de clases

% ------------------------------------------------------------------------
X = datos.Xrec(:,1:end-1);     % caracteristicas
Y = datos.Xrec(:,end);         % etiquetas
% ------------------------------------------------------------------------

rng("default")
cv = cvpartition(Y,"HoldOut",0.2);
trainingInds = training(cv);
testInds = test(cv);

Xtrain = X(trainingInds,:);
Ytrain = Y(trainingInds);
Xtest = X(testInds,:);
Ytest = Y(testInds);


% ---------------------------KNN SEARCH-----------------------------------
K = 3; %vecinos
clasificador_knn = fitcknn(X,Y,'NumNeighbors',K,'NSMethod','exhaustive','Distance','euclidean','Standardize',1);

%kf = crossvalind('KFold',Y,K);

%kn = find(mod(1:9,3));

%ACC = zeros(numel(kn),K);
%for k = 1:K
%    tt = kf==k;
%    tr = ~tt;

%    Xtr = X(tr,:);
%    Ytr = Y(tr);
%    Xtt = X(tt,:);
%    Ytt = Y(tt);

%    mn = mean(Xtr,1);
%    sd = std(Xtr,[],1);
%    Xtr = (Xtr-mn)./sd;

%    Xtt = (Xtt-mn)./sd;

%    for j = 1:numel(kn)
%        Idx = knnsearch(Xtr,Xtt,'K',kn(j));
%        Ypp = mode(Ytr(Idx),2);
%        ACC(j,k) = mean(Ypp==Ytt);
%    end

%end

% ---------------------------KNN SEARCH-----------------------------------


% -----------------------------IMAGEN-------------------------------------

imagen = imread('todas_blanco2.jpg');
%imagen = imread('todo_negro.jpg');
%imagen = imread('todo_claro.jpg');
%imagen = imread('todo_rojo.jpg');
%imagen = imread('todo_azul.jpg');

%figure;
%imshow(imagen);

%imagen = imread('prueba1.png');  %leer imagen
%imagen = imread('verde_todo.png');  %leer imagen
%imagen = imread('new_10_v0.png'); %CINTA
%imagen = imread('h0_0.png');
%imagen = imread('des_1.png'); %DESARMADOR
%imagen = imread('husky_v.png'); %HUSKY
%imagen = imread('husky.png'); %HUSKY <------------ BUENA
%imagen = imread('presion3.png'); %HUSKY <------------ BUENA
%imagen = imread('llave_8_v1_v0.png'); %PERICA
%imagen = imread('p_35_h0.png'); %PINZA PUNTA <------------ BUENA
%imagen = imread('m_4_h0.png'); %MARTILLO
%imagen = imread('p_13.png'); %PINZAS ELECTRICAS 
%imagen = imread('tijera.png'); %TIJERAS
%imagen = imread('vv_tijera.png'); %TIJERAS FONDO VERDE
%imagen = imread('tijeras_b.png'); %TIJERAS
%imagen = imread('presion_vv.png'); %HUSKY FONDO VERDE
% -----------------------------IMAGEN-------------------------------------

% -------------------------SEGMENTACION-----------------------------------
imagen_segmentada = segmentar(imagen,1.5); %segmentar imagen
% -------------------------SEGMENTACION-----------------------------------

% ETIQUETAR LA IMAGEN SEGMENTADA 
% 4 vecindad
[L,num]=bwlabel(imagen_segmentada,4);  

% -----------------------------RASGOS-------------------------------------
% construir arreglo para almacenar 
% caracteristicas de la imagen de entrada

if rasgos == 1
    Xc = zeros(num,4); %GEOM
elseif rasgos == 2
    Xc = zeros(num,7); %HUE
elseif rasgos == 3
    Xc = zeros(num,2); %Cerco Convexo
elseif rasgos == 4
    Xc = zeros(num,5); %Esqueleto con ramas y puntos terminales
end

% PARA CADA ETIQUETA DE LAS ENCONTRADAS EN LA IMAGEN
for i = 1:num

    BW = L == i;

    %usar el rasgo seleccionado
    if rasgos == 1
        Xc(i,:) = area_perimetro(BW);
    elseif rasgos == 2
        Xc(i,:) = moments_hu(BW);
    elseif rasgos == 3
        Xc(i,:) = cerco_convexo(BW);
    elseif rasgos == 4
        Xc(i,:) = esqueleto(BW);
    end

end
% -----------------------------RASGOS-------------------------------------

% ---------------------------CLASIFICAR-----------------------------------
[label,score,cost] = predict(clasificador_knn,Xc); %obtener resultados
% ---------------------------CLASIFICAR-----------------------------------


% ------------------------- DIBUJAR BORDE --------------------------------
% https://la.mathworks.com/help/images/ref/bwboundaries.html
[B,L,N,A] = bwboundaries(imagen_segmentada);
figure;
imshow(mascara_colores(imagen_segmentada,imagen)); hold on;
colors=['b' 'g' 'r' 'c' 'm' 'y' 'w'];
for k=1:length(B)
  boundary = B{k};
  cidx = mod(k,length(colors))+1;
  plot(boundary(:,2), boundary(:,1),colors(cidx),'LineWidth',2);

  %randomize text position for better visibility
  rndRow = ceil(length(boundary)/(mod(rand*k,7)+1));
  col = boundary(rndRow,2); row = boundary(rndRow,1);

  kl = label(k);
  h = text(col+1, row-1, clases.CLASES(kl));
  set(h,'Color',colors(cidx),'FontSize',14,'FontWeight','bold');
end
% ------------------------- DIBUJAR BORDE --------------------------------


testError = loss(clasificador_knn,Xtest,Ytest,LossFun="classiferror");

% Porcentaje de error
testAccuracy = 1 - testError

%rloss = resubLoss(clasificador_knn)

%rng(1)
%Mdl = fitcknn(X,Y,'OptimizeHyperparameters','auto',...
%    'HyperparameterOptimizationOptions',...
%    struct('AcquisitionFunctionName','expected-improvement-plus'))