% Read an image
image = imread('/Users/gianna/Documents/CINVESTAV/AID/img2/todo.png');
% Convert the image to double precision for processing
image = im2double(image);
% Convert the image to grayscale
grayImage = rgb2gray(image);
% Perform Bayesian image segmentation
threshold = graythresh(grayImage);
binaryImage = imbinarize(grayImage, threshold);
filledImage = imfill(binaryImage, 'holes');
% Display the original image and the segmented image
figure;
subplot(1, 2, 1);
imshow(image);
title('Original Image');
subplot(1, 2, 2);
imshow(filledImage);
title('Segmented Image (Bayesian)');