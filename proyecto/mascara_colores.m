%PORNER MASCARA CON EL OBJETO DE COLORES
function op = mascara_colores(dilatar,original)
red = original(:,:,1).*uint8(dilatar);
green = original(:,:,2).*uint8(dilatar);
blue = original(:,:,3).*uint8(dilatar);
op = cat(3,red,green,blue);