% Step 1: Specify the directory containing your .fig files
directory_path = '/Users/gianna/Documents/CINVESTAV/AID/imgs/Images/tijera'; % Replace with the actual path

% Step 2: Get a list of all .fig files in the directory
file_list = dir(fullfile(directory_path, '*.fig'));

% Step 3: Loop through each .fig file and convert to .png
for i = 1:length(file_list)
    % Get the current file name
    fig_file = fullfile(directory_path, file_list(i).name);
    
    % Load the .fig file and get the figure handle
    fig_handle = hgload(fig_file);
    % Set the background color of the figure to transparent
    set(fig_handle, 'color', 'none');
    % Adjust the PaperPositionMode property to remove any white frames
    set(fig_handle, 'PaperPositionMode', 'auto');
    % Get the current figure position
    fig_position = get(fig_handle, 'Position');
    
    % Ensure tight fitting of the figure contents
    set(fig_handle, 'Position', [0, 0, fig_position(3), fig_position(4)]);
    
    % Use the print function to save the figure as a .png image
    png_file = strrep(fig_file, '.fig', '.png');
    print(fig_handle, png_file, '-dpng', '-r300'); % Adjust resolution as needed
    
    % Close the figure
    close(fig_handle);
end