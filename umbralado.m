clc
clear all
close all
warning off
set(0,'defaultTextFontName','Courier')

original = imread('/Users/gianna/Documents/CINVESTAV/AID/img2/elec_b.png');


brightness_factor = 1.5; % Change this value to adjust the brightness. A value > 1 increases brightness, < 1 decreases brightness.
adjusted_image = double(original) * brightness_factor;
adjusted_image = uint8(adjusted_image); % Convert back to uint8 format (8-bit) for displaying and saving.
x = rgb2gray(adjusted_image);

edge_detected = edge(x,'canny',0.03);
cerrar = imclose(edge_detected,strel('square',3));

xx = imfill(cerrar,'holes');


se = strel('square', 1);
% Apply imopen to the binary image
output_image = imopen(xx, se);

mask_image = bwareaopen(output_image,400);

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
