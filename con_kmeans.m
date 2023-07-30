% Read an image
image = imread('/Users/gianna/Documents/CINVESTAV/AID/img2/todo.png');

%image = imread('/Users/gianna/Documents/personal/48279979_024_8fae.jpg');
% Convert the image to double precision for processing
image = im2double(image);

% Reshape the image to a 2D matrix of pixels
pixels = reshape(image, [], 3);

% Perform K-means clustering
numClusters = 2; % Number of clusters
[clusterIndices, clusterCenters] = kmeans(pixels, numClusters);

% Assign each pixel to its corresponding cluster center
segmentedImage = reshape(clusterIndices, size(image, 1), size(image, 2));

% Display the original image
figure;
imshow(image);
title('Original Image');

% Display the segmented image
figure;
imshow(segmentedImage, []);
title('Segmentada');

% Perform imfill to fill the holes in the binary image
filledImage = imfill(segmentedImage, 'holes');

% Display the original binary image and the filled image

figure;
imshow(filledImage,[]);
title('Filled Image');