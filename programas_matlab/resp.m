
%cerrar la imagen de bordes
cerrar = imclose(mask_image,strel('disk',3));
figure;
imshow(cerrar);
title('Cerrar imagen1');

%__
cerrar2 = imfill(cerrar,'holes');
figure;
imshow(cerrar2);
title('Fill image');
%__

%
%Hacer bwopen
%
mask_image = bwareaopen(cerrar2,500);
figure;
imshow(mask_image);
title('after a bwareaopen');

%dilatar
mask_image2 = imfill(mask_image,'holes');
figure;
imshow(mask_image2);
title('after a imfill holes');


abrir = imerode(mask_image,strel('line',3,90));
figure;
imshow(abrir);
title('Imerode');

cerrar22 = imclose(abrir,strel('line',3,0));
figure;
imshow(cerrar22);
title('Cerrar imagen2');

cerrar2 = imfill(cerrar22,'holes');
figure;
imshow(cerrar2);
title('Fill image');

%abrir = imerode(cerrar2,strel('line',3,90));
%figure;
%imshow(abrir);
%title('Imerode');

mask_image = bwareaopen(cerrar2,3000);
figure;
imshow(mask_image);
title('after a bwareaopen');

%-----------
% Erosionar
%-----------
erode = imerode(mask_image,strel('line',2,45));
figure;
imshow(erode);
title('Imerode');


%---END CODE --

mask_image2 = imclose(mask_image, strel('disk', 8));
figure;
imshow(mask_image2);
title('after a imclose con disco 8');


mask_image = imfill(mask_image2,'holes');
figure;
imshow(mask_image2);
title('after a imfill holes');

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