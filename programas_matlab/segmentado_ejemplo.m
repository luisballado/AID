clc
clear all
close all
warning off
set(0,'defaultTextFontName','Courier')

%leer la imagen
original = imread('/Users/gianna/Documents/CINVESTAV/AID/images/train/desarmador/des_1.png');

%pasar la imagen a espacio de grises
x = rgb2gray(original);

%--------------------------------------------
% detectar bordes
%--------------------------------------------
edge_detected = edge(x,'canny',0.03);
%edge_detected = bwareaopen(edge_detected,20);
figure;
imshow(edge_detected);

%cerrar la imagen de bordes
cerrar = imclose(edge_detected,strel('square',5));

%Hacer bwopen
mask_image = bwareaopen(cerrar,80);

%llenar hoyos
cerrar_h = imfill(mask_image,'holes');

%cerrar la imagen de bordes con
%elemento estructurante linea de 3 a 90 grados
cerrar2 = imclose(cerrar_h,strel('line',3,90));

%llenar hoyos
cerrar22 = imfill(cerrar2,'holes');

%Hacer bwopen con elementos de 1000
mask_image = bwareaopen(cerrar22,1000);

%----MOD
mask_image = imerode(mask_image,strel('disk',2));
mask_image = bwareaopen(mask_image,200);
imshow(mask_image);

%cerrar la imagen de bordes
cerrar = imclose(mask_image,strel('octagon',3));

%----MOD

%cerrar la imagen con elemento estructurante octagono
%cerrar = imclose(mask_image,strel('octagon',9));


%llenar hoyos
cerrar2 = imfill(cerrar,'holes');

%EROSIONAR
abrir = imerode(cerrar2,strel('line',2,180));

%Hacer bwopen con elementos de 10
mask_image = bwareaopen(abrir,500);

%figure;
%imshow(mask_image);
%title('after a bwareaopen');

%Poner mascara con los colores
red = original(:,:,1).*uint8(mask_image);
green = original(:,:,2).*uint8(mask_image);
blue = original(:,:,3).*uint8(mask_image);
op = cat(3,red,green,blue);
figure;
imshow(op);
title('MASK Image');

imshowpair(original,mask_image,'montage');

%obtener el numero de objetos
[L,num]=bwlabel(mask_image,4);
disp('Numero de objetos')
disp(num)

Iregion = regionprops(mask_image,'centroid');

stats = regionprops(L,'Eccentricity','Area','BoundingBox');
areas = [stats.Area];
eccentricities = [stats.Eccentricity];

idxOfSkittles = find(eccentricities);
statsDefects = stats(idxOfSkittles);

%TENER ROI
bbox = statsDefects(idxOfSkittles).BoundingBox;
croppedImage = imcrop(mask_image, bbox);

p_img = paddedImage(croppedImage,10);
% Display the padded image
figure;
imshow(p_img);
title('Padded Binary Image');

Xrec = zeros(1,2);
Xrec(1,:) = hu_moments(p_img);

%%TERMINAR AGREGAR PADDING

figure;
imshow(croppedImage);
%imwrite(croppedImage, "/Users/gianna/Documents/CINVESTAV/AID/img2/recorte.png");



figure, imshow(x);
hold on;

for idx = 1: length(idxOfSkittles)
    bb =  statsDefects(idx).BoundingBox;
    h = rectangle('Position', [bb(1), bb(2), bb(3), bb(4)], 'EdgeColor', 'r', 'LineWidth', 2);
    % Calcular el centroide de la caja
    centroidX = bb(1) + bb(3) / 2;
    centroidY = bb(2) + bb(4) / 2;
    
    % Agregar texto dentro del rectangulo
    defectNumber = sprintf('objeto %d', idx);
    text(centroidX, centroidY, defectNumber, 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
end

title(['Objetos en la imagen ',num2str(num)]);
hold off;
