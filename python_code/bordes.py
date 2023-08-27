import numpy as np
import cv2 as cv
from matplotlib import pyplot as plt

img = cv.imread('todas_blanco2.jpg', cv.IMREAD_GRAYSCALE)

assert img is not None, "file could not be read, check with os.path.exists()"

im_floodfill = cv.Canny(img,100,200)

plt.subplot(121),plt.imshow(img,cmap = 'gray')
plt.title('Original Image'), plt.xticks([]), plt.yticks([])

h, w = im_floodfill.shape[:2]
mask = np.zeros((h+2, w+2), np.uint8)

# Floodfill from point (0, 0)
cv.floodFill(im_floodfill, mask, (0,0), 255);
 
# Invert floodfilled image
im_floodfill_inv = cv.bitwise_not(im_floodfill)

# Combine the two images to get the foreground.
im_out = im_floodfill_inv

plt.subplot(122),plt.imshow(im_out,cmap = 'gray')
plt.title('Edge Image'), plt.xticks([]), plt.yticks([])

plt.show()




