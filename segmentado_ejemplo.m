clc
clear all
close all
warning off
set(0,'defaultTextFontName','Courier')

%leer la imagen
original = imread('/Users/gianna/Documents/CINVESTAV/AID/img2/todos_blanco2.png');

%pasar la imagen a espacio de grises
x = rgb2gray(original);

%--------------------------------------------
% detectar bordes
%--------------------------------------------
edge_detected = edge(x,'canny');


%cerrar la imagen de bordes
cerrar = imclose(edge_detected,strel('square',4));


%Hacer bwopen
mask_image = bwareaopen(cerrar,80);

%__
cerrar_h = imfill(mask_image,'holes');


%cerrar la imagen de bordes
cerrar2 = imclose(cerrar_h,strel('line',3,90));

%__
cerrar22 = imfill(cerrar2,'holes');

%
%Hacer bwopen
mask_image = bwareaopen(cerrar22,1000);


%cerrar la imagen de bordes
cerrar = imclose(mask_image,strel('octagon',9));

cerrar2 = imfill(cerrar,'holes');



%EROSIONAR
abrir = imerode(cerrar2,strel('line',2,180));


mask_image = bwareaopen(abrir,10);
figure;
imshow(mask_image);
title('after a bwareaopen');

red = original(:,:,1).*uint8(mask_image);
green = original(:,:,2).*uint8(mask_image);
blue = original(:,:,3).*uint8(mask_image);
op = cat(3,red,green,blue);
figure;
imshow(op);
title('MASK Image');

imshowpair(original,mask_image,'montage');
%imshowpair(original,mask_image,'montage');

[L,num]=bwlabel(mask_image,4);
disp('Numero de objetos')
disp(num)


Iregion = regionprops(mask_image,'centroid');

stats = regionprops(L,'Eccentricity','Area','BoundingBox');
areas = [stats.Area];
eccentricities = [stats.Eccentricity];

idxOfSkittles = find(eccentricities);
statsDefects = stats(idxOfSkittles);

figure, imshow(x);
hold on;

for idx = 1: length(idxOfSkittles)
    h = rectangle('Position', statsDefects(idx).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
end

title(['Hay ',num2str(num), ' objetos']);
hold off;
