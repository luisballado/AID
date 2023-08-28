% BASDO DE
% https://la.mathworks.com/matlabcentral/fileexchange/24747-image-format-conversion-binary-to-rgb
function rgbPic = bw2rgb(bwPic)
bwPicSize = size(bwPic);
rgbPic = zeros(bwPicSize(1),bwPicSize(2),3);
rgbPic(bwPic==1)=255;
rgbPic(:,:,2) = rgbPic(:,:,1);
rgbPic(:,:,3) = rgbPic(:,:,1);
rgbPic = im2uint8(rgbPic);