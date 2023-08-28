function cv = cerco_convexo(I)

%I = double(I);

%region convexa que engloba la figura
CH = bwconvhull(I);

%primitivas geometricas de la imagen
stats_O = regionprops(I, 'Area', 'Perimeter','MajorAxisLength');

%primitivas geometricas de la region convexa
stats_H = regionprops(CH, 'Area', 'Perimeter');

%solidez
solidez = stats_O.Area ./ stats_H.Area;

%convexidad
convexidad = stats_H.Perimeter ./ stats_O.Perimeter;

%
stats = regionprops(I, 'Area', 'Perimeter','MajorAxisLength');

% area
area = stats.Area;

%perimetro
perimetro = stats.Perimeter;


cv = [solidez,convexidad];