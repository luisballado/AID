clc
clear all
close all
warning off

%leer la imagen
original = imread('/Users/gianna/Documents/CINVESTAV/AID/img2/todos_blanco2.png');
x = rgb2gray(original);

%mostrar imagen
figure;
imshow(x);
title('Original Image');

%--------------------------------------------
% detectar bordes
edge_detected = edge(x,'canny');
%figure;
%imshow(edge_detected);

%cerrar la imagen de bordes
cerrar = imclose(edge_detected,strel('line',3,135));
cerrar = imclose(cerrar,strel('line',3,90));
%figure;
%imshow(cerrar);

cerrar2 = imfill(cerrar,'holes');
%figure;
%imshow(x);

abrir = imerode(cerrar2,strel('line',3,90));
figure;
imshow(abrir);

mask_image = bwareaopen(abrir,1000);
figure;
imshow(mask_image);

mask_image = imclose(mask_image, strel('disk', 8));
mask_image = imfill(mask_image,'holes');

% Define the structuring element for the morphological operations
se = strel('disk', 5); % You can experiment with different structuring elements and sizes

% Perform erosion to remove small bumps
erodedImage = imerode(mask_image, se);

% Perform opening to further remove small bumps while preserving object boundaries
openedImage = imopen(mask_image, se);
title('IMG ABIERTA');

imshow(openedImage);
% Define the structuring element for the morphological operations
%se = strel('disk', 8); % You can experiment with different structuring elements and sizes

% Perform erosion to remove small bumps
%erodedImage2 = imerode(openedImage, se);

% Perform opening to further remove small bumps while preserving object boundaries
%openedImage2 = imopen(openedImage, se);

%openedImage2 = bwareaopen(openedImage2,1000);

%----
% Erosionar
%----
%abrir2 = imerode(mask_image,strel('line',10,90));
%figure;
%imshow(abrir2);

%mask_image = bwareaopen(imopen(imfill(imclose(edge(rgb2gray(x),'canny'),strel('line',3,0)),'holes'),strel(ones(3,3))),1500);
%figure;
%imshow(mask_image);
title('MASK Image');
red = original(:,:,1).*uint8(openedImage);
green = original(:,:,2).*uint8(openedImage);
blue = original(:,:,3).*uint8(openedImage);
op = cat(3,red,green,blue);
figure;
imshow(op);
