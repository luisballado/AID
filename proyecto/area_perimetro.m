%Rasgos imagen
%rasgos_geometricos

function rasgos_geometricos = area_perimetro(I)

stats = regionprops(I, 'Area', 'Perimeter','MajorAxisLength');

% area
area = stats.Area;

%perimetro
perimetro = stats.Perimeter;

%diametro max
diametro_max = stats.MajorAxisLength;

%redondez
redondez = (4*area)./(pi*diametro_max.^2);

%circularidad
circularidad = 2*(sqrt(((area)./(pi*(diametro_max.^2)))));

%compacidad
compacidad = 2*(sqrt(area.*pi))./perimetro;

%factor de forma
factor_forma = (4*area*pi)./(perimetro.^2);

rasgos_geometricos = [redondez,circularidad,compacidad,factor_forma];