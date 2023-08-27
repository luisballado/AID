import cv2
import torch
from super_gradients.training import models
device=torch.device("cuda:0") if torch.cuda.is_available() else torch.device("cpu")
#model=models.get('yolo_nas_s',pretrained_weights="coco").to(device)
model=models.get('yolo_nas_l',pretrained_weights="coco").to(device)
out=model.predict("/home/luis/Documents/cinvestav/FINAL/AID/ejemplo_yolo/todo.png")
out.show()
