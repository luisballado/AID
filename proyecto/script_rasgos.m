% ------------------------------------------------------------------------
% PROYECTO ANALISIS DE IMAGENES DIGITALES
% @autor LUIS BALLADO
% REFERENCIA: 
% https://www.mathworks.com/matlabcentral/answers/437494-how-to-loop-through-all-files-in-subfolders-in-a-main-folder
% ------------------------------------------------------------------------

clearvars; close all; clc;

% MOMENTOS DE HU,
%SE AGREGAN IMPLEMENTACIONES PARA LAS GEOMETRIAS BASICAS PARA ASI COMPARAR
%SUS RENDIMIENTOS Y COMPLEJIDADES.

D = '/MATLAB Drive/proyecto/data_aumentation/'; % 

% https://la.mathworks.com/help/matlab/ref/questdlg.html
%respuesta = questdlg('¿Que rasgos quieres optener?','Rasgos', ...
%    'Geometricos','Momentos Hue','Cerco Convexo','Esqueleto');

listaOpciones = { 'geometricos','hue','convexo','esqueleto'}; 
[idx, tf] = listdlg('ListString', listaOpciones,...
    'SelectionMode', 'Single', 'PromptString', 'Select item', 'Initialvalue', 1,'Name', 'Make choice');

if tf
    eleccion = listaOpciones{idx}; 
else
   return;
end

rasgos = idx;

% Handle response

S = dir(fullfile(D,'*'));
N = setdiff({S([S.isdir]).name},{'.','..'}); % list of subfolders of D.
num = 0;

filePattern = sprintf('%s/**/*.jpg', D);
allFileInfo = dir(filePattern);

% Throw out any folders.  We want files only, not folders.
isFolder = [allFileInfo.isdir]; % Logical list of what item is a folder or not.

% Now set those folder entries to null, essentially deleting/removing them from the list.
allFileInfo(isFolder) = [];
listOfFolderNames = unique({allFileInfo.folder});
numberOfFolders = length(listOfFolderNames);
listOfFileNames = {allFileInfo.name};
totalNumberOfFiles = length(listOfFileNames);
fprintf('Numero total de archivos %d .\n', totalNumberOfFiles);

if rasgos == 1
    Xrec = zeros(length(totalNumberOfFiles),5);
elseif rasgos == 2
    Xrec = zeros(length(totalNumberOfFiles),8); %<--- para los 7 momentos
elseif rasgos == 3
    Xrec = zeros(length(totalNumberOfFiles),3);
elseif rasgos == 4
    Xrec = zeros(length(totalNumberOfFiles),6);
end

CLASES = cell(length(N),1); %vector con las clases

index = 0; %indice para agregar valores al arreglo

%PARA TODAS LAS CARPETAS DENTRO DE PROYECTO/DATA_AUMENTATION
for ii = 1:numel(N)

    T = dir(fullfile(D,N{ii},'*')); % improve by specifying the file extension.
    C = {T(~[T.isdir]).name}; % files in subfolder.
    
    fprintf('\n====================================\n');
    fprintf('============ CLASE %s ===============', N{ii});
    fprintf('\n====================================\n');

    CLASES(ii) = {N{ii}};

    % PARA TODOS LOS ARCHIVOS DENTRO DE LA CARPETA
    for jj = 1:numel(C)
        
        fprintf('====================================\n');
        F = fullfile(D,N{ii},C{jj});
        fprintf(1, 'ARCHIVO: %s\n', C{jj}); %<<----- NOMBRE ARCHIVO
        fprintf(1, 'CARPETA: %s\n', N{ii}); %<<----- NOMBRE CARPETA

        % Si comienza asignar uno; de lo contrario sumarle uno
        if index == 0
            index = 1;
        else
            index = index + 1;
        end

        %LEER IMAGEN
        original = imread(F);
        
        %SEGMENTAR IMAGEN
        imagen_segmentada = segmentar(original,1.5);
        
        %ETIQUETAR LA IMAGEN SEGMENTADA
        [L,num]=bwlabel(imagen_segmentada,4);

        %OBTENER RASGOS 

        %nombre_clase = strcat('clase_', num2str(ii));
        
        %momento 1-7, id de clase
        if rasgos == 1
            fprintf(1, 'GEOM: %s\n', area_perimetro(L));
            Xrec(index,:) = [area_perimetro(L),ii];
        elseif rasgos == 2
            %fprintf(1, 'HUE: %s\n', hu_moments(L));
            %Xrec(index,:) = [hu_moments(L),ii];
            
            fprintf(1, 'HUE: %s\n', moments_hu(L));
            Xrec(index,:) = [moments_hu(L),ii];
        elseif rasgos == 3
            fprintf(1, 'Cerco Convexo: %s\n', cerco_convexo(L));
            Xrec(index,:) = [cerco_convexo(L),ii];
        elseif rasgos == 4
            fprintf(1, 'Esqueletos: %s\n', esqueleto(L));
            Xrec(index,:) = [esqueleto(L),ii];
        end

    end
end

% ------------------------------------------------------------------------
if rasgos == 1
    save('rasgos_geom.mat','Xrec'); %guardar rasgos geom
elseif rasgos == 2
    save('rasgos_hue.mat','Xrec');  %guardar rasgos hue
elseif rasgos == 3
    save('rasgos_ccx.mat','Xrec');  %guardar rasgos cerco convexo
elseif rasgos == 4
    save('rasgos_esqueletos.mat','Xrec');  %guardar rasgos cerco convexo
end
% ------------------------------------------------------------------------
save('clases.mat','CLASES'); %guardar clases
% ------------------------------------------------------------------------

f = msgbox("El script termino","OK");
