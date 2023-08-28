% Start with a folder and get a list of all subfolders.  Use with R2016b and later.
% It's done differently with R2016a and earlier, with genpath().
% Finds and prints names of all files in that folder and all of its subfolders.
% Similar to imageSet() function in the Computer Vision System Toolbox: http://www.mathworks.com/help/vision/ref/imageset-class.html

%
% Limpiar todo
%
clearvars; close all; clc;
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;

%
% Definir ruta de la carpeta principal
% SELECCIONAR HASTA data_aumentation
%

start_path = fullfile('/MATLAB Drive/');
if ~exist(start_path, 'dir')
	start_path = matlabroot;
end

%
% Preguntar al usuario que confirme la carpeta
%
uiwait(msgbox('Selecciona la carpeta data_aumentation.'));
topLevelFolder = uigetdir(start_path);

if topLevelFolder == 0
	return;
end

fprintf('La carpeta raiz es "%s".\n', topLevelFolder);

% Specify the file pattern.
% Get ALL files using the pattern *.*
% Note the special file pattern.  It has /**/ in it if you want to get files in subfolders of the top level folder.
% filePattern = sprintf('%s/**/*.m; %s/**/*.xml', topLevelFolder, topLevelFolder);
filePattern = sprintf('%s/**/*.jpg', topLevelFolder);
allFileInfo = dir(filePattern);

% Throw out any folders.  We want files only, not folders.
isFolder = [allFileInfo.isdir]; % Logical list of what item is a folder or not.

% Now set those folder entries to null, essentially deleting/removing them from the list.
allFileInfo(isFolder) = [];

% Get a cell array of strings.  We don't really use it.  I'm just showing you how to get it in case you want it.
listOfFolderNames = unique({allFileInfo.folder});
numberOfFolders = length(listOfFolderNames);
fprintf('El numero total de clases es: %d.\n', numberOfFolders);

% Get a cell array of base filename strings.  We don't really use it.  I'm just showing you how to get it in case you want it.
listOfFileNames = {allFileInfo.name};
totalNumberOfFiles = length(listOfFileNames);
fprintf('El dataset consta de %d clases y un total de %d imagenes.\n', numberOfFolders, totalNumberOfFiles);

% Process all files in those folders.
totalNumberOfFiles = length(allFileInfo);

% Now we have a list of all files, matching the pattern, in the top level folder and its subfolders.
if totalNumberOfFiles >= 1
	for k = 1 : totalNumberOfFiles
		% Go through all those files.
		thisFolder = allFileInfo(k).folder;
		thisBaseFileName = allFileInfo(k).name;
        fprintf('%s\n',thisFolder(length(topLevelFolder)+1:end));
		fullFileName = fullfile(thisFolder, thisBaseFileName);
		%fprintf('     Processing file %d of %d : "%s".\n', k, totalNumberOfFiles, fullFileName);
	end
else
	fprintf('     La clase %s no cuenta con archivos.\n', thisFolder);
end
%fprintf('\nDone looking in all %d folders!\nFound %d files in the %d folders.\n', numberOfFolders, totalNumberOfFiles, numberOfFolders);
