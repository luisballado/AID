clc;
close all;
% Step 1: Load the image (Replace 'your_image_path' with the actual path to your image)
%image = imread('Imagenes/des_bb.png');
%image = imread('Imagenes/todos_verde.png');
%image = imread('Imagenes/cinta_roja2.png');
image = imread('Imagenes/presion.png');

% Step 2: Convert the image to grayscale (if needed)
if size(image, 3) > 1
    grayImage = rgb2gray(image);
else
    grayImage = image;
end

% Step 3: Calculate the local entropy of the image
entropyImage = entropyfilt(grayImage);

% Step 4: Threshold the image based on local entropy
threshold = graythresh(entropyImage);
binaryImage = entropyImage >= threshold;

% Step 5: Display the segmented image
figure;
%subplot(1, 3, 1);
imshow(grayImage);
title('Original Image');

figure;
%subplot(1, 3, 2);
imshow(entropyImage, []);
title('Local Entropy Image');

figure;
%subplot(1, 3, 3);
imshow(binaryImage);
title('Segmented Image (Entropy)');

edgeImage = edge(grayImage, 'Canny');
figure;
imshow(edgeImage);
title('Edge-Detected Image');

cerrar = imfill(imclose(edgeImage,strel('square',5)),'holes');
figure;
imshow(cerrar);

mask_image = bwareaopen(cerrar,2000);
figure;
imshow(mask_image);

mask_image = imerode(mask_image,strel('disk',2));
mask_image = bwareaopen(mask_image,1000);
figure;
imshow(mask_image);

dilatar = imdilate(mask_image,strel('disk',2));
figure;
imshow(dilatar);


% Optional: Save the segmented image (uncomment if you want to save)
% imwrite(binaryImage, 'segmented_image_entropy.png');
