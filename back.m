I = imread('/Users/gianna/Documents/CINVESTAV/AID/imgs/Images/llave/husky_v.png');
I = rgb2gray(I);
imshow(I);

%pout_imadjust = imadjust(I);
pout_histeq = histeq(I);
%pout_adapthisteq = adapthisteq(I);

threshold = graythresh(I);
binaryImage = imbinarize(pout_adapthisteq, threshold);
filledImage = imfill(binaryImage, 'holes');

imshow(filledImage,[]);

%se = strel('disk',5);
%background = imopen(I,se);
%imshow(background);

%I2 = I - background;
%imshow(imadjust(I2));