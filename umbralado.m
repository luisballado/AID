clc
clear all
close all
warning off
set(0,'defaultTextFontName','Courier')

original = imread('/Users/gianna/Documents/CINVESTAV/AID/images/train/desarmador/des_2_v2.png');
%figure;
%imshow(original);

brightness_factor = 2.0; % Change this value to adjust the brightness. A value > 1 increases brightness, < 1 decreases brightness.
adjusted_image = double(original) * brightness_factor;
adjusted_image = uint8(adjusted_image); % Convert back to uint8 format (8-bit) for displaying and saving.
%imshow(adjusted_image);

x = rgb2gray(adjusted_image);
figure;
imshow(x);

edge_detected = edge(x,'canny');

figure;
imshow(edge_detected);

cerrar = imclose(edge_detected,strel('disk',10));

figure;
imshow(cerrar);

xx = imfill(cerrar,'holes');
figure;
imshow(xx);



%EROSIONAR
w = strel('square',4);
E = imerode(xx,w);
figure;
imshow(E);

%se = strel('square', 1);
% Apply imopen to the binary image
%output_image = imopen(xx, se);
%figure;
%imshow(output_image);
mask_image = bwareaopen(xx,400);

figure;
imshow(mask_image);

m_im = imclose(mask_image,strel('line',4,0));

fill_m_im = imfill(m_im,'holes');

figure;
imshow(fill_m_im);


m_image = bwareaopen(fill_m_im,1000);
figure;
imshow(m_image);

m_image_c = imclose(m_image,strel('line',6,45));
figure;
imshow(m_image_c);

cfill_m_im = imfill(m_image_c,'holes');

figure;
imshow(cfill_m_im);

w = strel('line',2,0);
E = imerode(cfill_m_im,w);
figure;
imshow(E);

E_m_image = bwareaopen(E,1000);
figure;
imshow(E_m_image);

D = imdilate(E_m_image,w);

figure;
imshow(D);
