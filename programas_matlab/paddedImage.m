function paddedImage = paddedImage(originalImage, paddingFactor)

    %AGREGAR UN PADDING
    paddingSize = paddingFactor; % Adjust this value according to your requirement

    % Get the size of the binary image
    [height, width] = size(originalImage);

    % Calculate the dimensions of the padded image
    paddedHeight = height + 2 * paddingSize;
    paddedWidth = width + 2 * paddingSize;

    % Create a larger canvas for the padded image
    paddedImage = zeros(paddedHeight, paddedWidth);

    % Calculate the position to paste the binary image on the canvas
    pastePosX = paddingSize + 1;
    pastePosY = paddingSize + 1;

    % Paste the binary image onto the padded canvas
    paddedImage(pastePosY: pastePosY + height - 1, pastePosX: pastePosX + width - 1) = originalImage;

end