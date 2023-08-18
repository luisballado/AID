clearvars; close all; clc;

%DATASET
%-CLASE1
%--FOTOS
%-CLASE2
%-CLASEN
%--FOTOS

% MOMENTOS DE HU,
%SE AGREGAN IMPLEMENTACIONES PARA LAS GEOMETRIAS BASICAS PARA ASI COMPARAR
%SUS RENDIMIENTOS Y COMPLEJIDADES.

D = '/MATLAB Drive/proyecto/data_aumentation/'; % A is a struct ... first elements are '.' and '..' used for navigation.

S = dir(fullfile(D,'*'));
N = setdiff({S([S.isdir]).name},{'.','..'}); % list of subfolders of D.
num = 0;

% REFERENCIA: https://www.mathworks.com/matlabcentral/answers/437494-how-to-loop-through-all-files-in-subfolders-in-a-main-folder
filePattern = sprintf('%s/**/*.jpg', D);
allFileInfo = dir(filePattern);

% Throw out any folders.  We want files only, not folders.
isFolder = [allFileInfo.isdir]; % Logical list of what item is a folder or not.

% Now set those folder entries to null, essentially deleting/removing them from the list.
allFileInfo(isFolder) = [];
listOfFolderNames = unique({allFileInfo.folder});
numberOfFolders = length(listOfFolderNames);
listOfFileNames = {allFileInfo.name};
totalNumberOfFiles = length(listOfFileNames);
fprintf('The total number of files %d .\n', totalNumberOfFiles);

Xrec = zeros(length(totalNumberOfFiles),3);

index = 0;
%PARA TODAS LAS CARPETAS DENTRO DE PROYECTO/DATA_AUMENTATION
for ii = 1:numel(N)
    T = dir(fullfile(D,N{ii},'*')); % improve by specifying the file extension.
    C = {T(~[T.isdir]).name}; % files in subfolder.
    
    
    % PARA TODOS LOS ARCHIVOS 
    % DENTRO DE LA CARPETA
    
    fprintf('\n%%%%%%%%%%%% CLASE %d %%%%%%%%%%%%%%', ii);
    fprintf('\n%%%%%%%%%%%% CLASE %d %%%%%%%%%%%%%%', ii);
    fprintf('\n%%%%%%%%%%%% CLASE %d %%%%%%%%%%%%%%\n', ii);
    
    

    for jj = 1:numel(C)
        F = fullfile(D,N{ii},C{jj})
        fprintf(1, 'Now reading %s\n', F);
        
        if index == 0
            index = 1;
        else
            index = index + 1;
        end

        %LEER IMAGEN
        original = imread(F);
        
        %SEGMENTAR IMAGEN
        imagen_segmentada = segmentar(original,1.5);
        
        %ETIQUETAR LA IMAGEN SEGMENTADA
        [L,num]=bwlabel(imagen_segmentada,4);

        %OBTENER RASGOS HUE
        fprintf(1, 'HUE: %s\n', hu_moments(L));
        Xrec(index,:) = [hu_moments(L),ii];
    end
end

save('rasgos.mat','Xrec');