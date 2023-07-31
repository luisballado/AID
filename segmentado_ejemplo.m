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
%figure;
%imshow(edge_detected);
%title('Bordes canny');

%cerrar la imagen de bordes
cerrar = imclose(edge_detected,strel('square',4));
%figure;
%imshow(cerrar);
%title('Cerrar imagen1');

%Hacer bwopen
%
mask_image = bwareaopen(cerrar,80);
%figure;
%imshow(mask_image);
%title('after a bwareaopen');

%__
cerrar_h = imfill(mask_image,'holes');
%figure;
%imshow(cerrar_h);
%title('Fill image');
%__


%cerrar la imagen de bordes
cerrar2 = imclose(cerrar_h,strel('line',3,90));
%figure;
%imshow(cerrar2);
%title('Cerrar imagen1');

%__
cerrar22 = imfill(cerrar2,'holes');
%figure;
%imshow(cerrar22);
%title('Fill image');
%__

%
%
%Hacer bwopen
%
mask_image = bwareaopen(cerrar22,1000);
%figure;
%imshow(mask_image);
%title('after a bwareaopen');

%cerrar la imagen de bordes
cerrar = imclose(mask_image,strel('octagon',9));
%figure;
%imshow(cerrar);
%title('Cerrar imagen1');

%__
cerrar2 = imfill(cerrar,'holes');
%figure;
%imshow(cerrar2);
%title('Fill image');
%__


%EROSIONAR
abrir = imerode(cerrar2,strel('line',2,180));
%figure;
%imshow(abrir);
%title('Imerode');

%%%

mask_image = bwareaopen(abrir,10);
figure;
imshow(mask_image);
title('after a bwareaopen');

%mask_image2 = bwareaopen(mask_image,100);
%figure;
%imshow(mask_image2);
%title('after a bwareaopen');

%--END--

%mask_image22 = imclose(mask_image2, strel('rectangle', [1,1]));
%figure;
%imshow(mask_image22);
%title('after a imclose con disco 8');


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
