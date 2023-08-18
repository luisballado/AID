clearvars; close all; clc;

% SCRIPT PARA HACER DATA AUMENTATION A PARTIR DE LAS IMAGENES QUE TENGA
% LA CARPETA EN ESE MOMENTO, CADA EJECUCION DOBLARA EL NUMERO DE IMAGENES
%
% TODO: AGREGAR FUNCION PARA BORRAR LA IMAGEN
%
% autor: LUIS BALLADO AGO 2023
%
% EL SCRIPT EFECTUA LOS SIGUIENTES PASOS:
%
% PASO 0, DETERMINAR SI SE QUIERE IDENTIFICAR LAS MALAS IMAGENES O 
%
% -------------------- CREAR NUEVAS IMAGENES --------------------
% CAMBIAR LA OPCION POR --> Opcion = 'aumentar';
%
% PARA CADA ARCHIVO EN LA CARPETA,
% 1.- SEGMENTAR
% 2.- SI EL ARCHIVO CREADO PUDIERA TENER MAS ELEMENTOS EN LA IMAGEN
% SE DESCARTA, DE LO CONTRARIO SE GUARDA LA IMAGEN GENERADA
%
% -------------- BORRAR IMAGENES CON ESPURIOS --------------------
% CAMBIAR LA OPCION POR --> Opcion = 'borrar';
%
% PARA CADA ARCHIVO EN LA CARPETA,
% 1.- SEGMENTAR
% 2.- SI EL ARCHIVO CREADO PUDIERA TENER MAS ELEMENTOS EN LA IMAGEN
% SE DESCARTA, DE LO CONTRARIO SE GUARDA LA IMAGEN GENERADA
%

% SELECCIONAR LA OPCION ADECUADA
%Opcion = 'aumentar';
Opcion = 'borrar';

% ESPECIFICAR EL FOLDER DE LA CLASE
myFolder = '/MATLAB Drive/proyecto/data_aumentation/clase7';

% REFERENCIA: https://matlab.fandom.com/wiki/FAQ#How_can_I_process_a_sequence_of_files.3F
% REVISAR QUE EL FOLDER EXISTA
if ~isfolder(myFolder)
    errorMessage = sprintf('Error: el directorio no existe:\n%s\nPor favor, selecciona uno válido.', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end

% LISTA DE TODOS LOS ARCHIVOS *.jpg
filePattern = fullfile(myFolder, '*.jpg'); % Change to whatever pattern you need.
theFiles = dir(filePattern);

% PARA TODAS LAS IMAGENES EN LA CARPETA
for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    original = imread(fullFileName);

    % REFERENCIA: https://stackoverflow.com/questions/28139202/can-we-rotate-an-image-in-matlab-filled-with-background-color-of-original-image
    % ROTAR LA IMAGEN EN UN RANGO DE 0 A 360
    if contains('aumentar', Opcion)
        angle = 0 + (135-0)*rand();
        T = @(original) imrotate(original,angle,'bilinear','crop');
        %// Apply transformation
        TA = T(original);
        mask = T(ones(size(original)))==1;
        original(mask) = TA(mask);
    end
    
    %%// Show image
    imagen_segmentada = segmentar(original,1.5);
    fprintf(1, 'Now reading %s\n', fullFileName);
    imshow(mascara_colores(imagen_segmentada,original));
    %pause(0.7); % tiempo de pausa
    
    %ETIQUETAR, SI TIENE MAS DE DOS COSAS NO SE GUARDA
    [L,num]=bwlabel(imagen_segmentada,4);

    switch Opcion
        case {'borrar'}
            disp('OPCION::BORRAR');
            if num >= 2
                errorMessage = sprintf('Error: la imagen contiene varios elementos\n.');
                uiwait(warndlg(errorMessage));
                return;
            end
        case {'aumentar'}
            disp('OPCION::AUMENTAR');
            if num <= 1
                fprintf(1, 'Guardando \n');
                nn = datestr(now, 'mm_ss');
                filename = sprintf('img_%s.jpg',nn);
                ImageFolder = myFolder;
                fullFileName = fullfile(ImageFolder,filename);
                imwrite(original,fullFileName);
            end
        otherwise
            disp('no category');
    end

    drawnow; % FORZAR PARA MOSTRAR LA IMAGEN.
end