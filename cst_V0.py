import numpy as np
from scipy.optimize import linprog
from PIL import Image, ImageDraw

original = Image.open("./image/eromanga.jpg")
print(np.array(original))
original.show()

