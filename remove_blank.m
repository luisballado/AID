folder_path = '/Users/gianna/Documents/CINVESTAV/AID/imgs/Images/taladro/';
cd(folder_path);

myFiles = dir('*.png'); %gets all wav files in struct

for k = 1:length(myFiles)
  old_name = myFiles(k).name;
  new_name = sprintf('taladro_%d.png',k);
  u_out = RemoveWhiteSpace([], 'file', old_name, 'output', new_name);
  % all of your actions for filtering and plotting go here
end
