function eq = esqueleto(I)

stats = regionprops(I, 'Area', 'Perimeter','MajorAxisLength');

% area
area = stats.Area;

%perimetro
perimetro = stats.Perimeter;

I = logical(I);

SkelImage=bwskel(I,'MinBranchLength',10);

mn=bwmorph(SkelImage,'branchpoints');

[row column] = find(mn);

branchPts    = [row column];

cNumBranchPoints = length(branchPts)

endImg    = bwmorph(SkelImage, 'endpoints');

[row column] = find(endImg);

endPts       = [row column];

cNumEndPoints = length(endPts)


numberOfPixels = sum(SkelImage(:))

eq = [cNumBranchPoints,cNumEndPoints,numberOfPixels,area,perimetro];