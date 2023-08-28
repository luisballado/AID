function P = segmentar(I,f)

%AJUSTAR BRILLO DE LA IMAGEN

%PASAR IMAGEN A DOUBLE
original_gris = double(I);

%AJUSTAR BRILLO
%valores > 1 aumentan el brillo, < 1 decrementan el brillo.
factor_brillo = f;
img_ajustada = original_gris * factor_brillo;

% Convertir a formato uint8 (8-bit).
img_ajustada = uint8(img_ajustada); 

%IMAGEN ESCALA GRISES
% CONVERTIR IMAGEN A ESCALA DE GRISES
if size(img_ajustada, 3) > 1
    imgGris = rgb2gray(img_ajustada);
else
    imgGris = img_ajustada;
end

imgBordes = edge(imgGris, 'Canny');

%CERRAR CON ELEMENTO ESTRUCTURANTE SQUARE 5
cerrar_imagen = imclose(imgBordes,strel('square',5));

%LLENAR HUECOS
rellenar_imagen = imfill(cerrar_imagen,'holes');

%QUITAR ELEMENTOS MENORES A 2000px
imagen_segmentada = bwareaopen(rellenar_imagen,2000);

%EROSIONAR PARA LIMPIAR MAS LA IMAGEN
erode_image = imerode(imagen_segmentada,strel('disk',4));

%QUITAR ELEMENTOS MENORES A 2000px
mascara = bwareaopen(erode_image,2000);

PP = imdilate(mascara,strel('disk',2));

P = bwareaopen(PP,2000);