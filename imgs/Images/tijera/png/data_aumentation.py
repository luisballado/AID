# python program to demonstrate the horizontal flip of the image with the horizontal_flip = True argument

# we import all our required libraries
from numpy import expand_dims
from tensorflow.keras.utils import load_img
from tensorflow.keras.utils import img_to_array
from tensorflow.keras.utils import save_img
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from matplotlib import pyplot

# we first load the image
image = load_img('t_13.png')

# we converting the image which is in PIL format into the numpy array, so that we can apply deep learning methods
dataImage = img_to_array(image)

# expanding dimension of the load image
imageNew = expand_dims(dataImage, 0)

# now here below we creating the object of the data augmentation class
imageDataGen = ImageDataGenerator(vertical_flip=True)

# because as we alreay load image into the memory, so we are using flow() function, to apply transformation
iterator = imageDataGen.flow(imageNew, batch_size=1)

# below we generate augmented images and plotting for visualization
for i in range(5):
    
    # generating images of each batch
    batch = iterator.next()

    # again we convert back to the unsigned integers value of the image for viewing
    image = batch[0].astype('uint8')

    save_img('v0_t13_'+str(i)+'.png', image)
