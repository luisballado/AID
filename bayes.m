% Read an image
image = imread('/Users/gianna/Documents/CINVESTAV/AID/images/train/desarmador/des_3.png');

brightness_factor = 1.5; % Change this value to adjust the brightness. A value > 1 increases brightness, < 1 decreases brightness.
adjusted_image = double(image) * brightness_factor;
adjusted_image = uint8(adjusted_image);

% Convert the image to double precision for processing
image = im2double(adjusted_image);

% Convert the image to grayscale
grayImage = rgb2gray(image);

% Perform Bayesian image segmentation
threshold = graythresh(grayImage);
binaryImage = imbinarize(grayImage, threshold);
filledImage = imfill(~binaryImage, 'holes');
% Display the original image and the segmented image
figure;
subplot(1, 2, 1);
imshow(image);
title('Original Image');
subplot(1, 2, 2);
imshow(filledImage);
title('Segmented Image (Bayesian)');