clearvars; close all; clc;

datos = load("rasgos.mat");

% caracteristicas
X = datos.Xrec(:,1:end-1);

% etiquetas
Y = datos.Xrec(:,end);

k = 4;

clasificador_knn = fitcknn(X,Y,'NumNeighbors',k);

imagen = imread('todas_blanco2.jpg');

%SEGMENTAR IMAGEN
imagen_segmentada = segmentar(imagen,1.5);

%ETIQUETAR LA IMAGEN SEGMENTADA
[L,num]=bwlabel(imagen_segmentada,4);

Xrec = zeros(num,2);

for i = 1:num
    BW = L == i;
    Xrec(i,:) = hu_moments(BW);
end

predictedLabels_knn = predict(clasificador_knn,Xrec);

img = double(imagen_segmentada);

% Get the boundary pixels of the binary image
boundaryImage = bwperim(img);

%create a color image
colorImage = repmat(img, [1, 1, 3]);

% Assign a color to the boundary pixels
%colorImage(boundaryImage) = [255, 0, 0]; % Red color for the contour
imshow(colorImage);


% First make a RGB image for display:
Segout = repmat(img, [1 1 3]);
% Find indices of the boundary pixels
outline_idx = find(boundaryImage);
% Find the indices to fill in the RGB image
Segout_idx = [outline_idx; numel(boundaryImage)+outline_idx;2*numel(boundaryImage)+outline_idx]; 
% Select the color (RGB triplet) for the boundary. I choose red. 
colorValue = [0; 255; 0];
% Prepare a color vector to fill in the RGB image
outline_fill_values = kron(colorValue,ones(size(outline_idx)));
% Fill the RGB image with the color value
Segout(Segout_idx) = outline_fill_values;
% Display the RGB image 
figure, imshow(Segout);
