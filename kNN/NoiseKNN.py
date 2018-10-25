# using the KNN to recovery the incomplete image
from sklearn.neighbors import KNeighborsRegressor as knn
from math import sqrt
import cv2
import numpy as np
import time

# img = cv2.imread('back.jpg', 0)
img = cv2.imread('view.png', 0)
# cv2.imshow('color_image', img)
# cv2.waitKey(2000)

# print(img[9])

m, n = img.shape
sampleRate = 0.3
allsample=[]

for i in range(m):
    for j in range(n):
        allsample.append((i,j))

np.random.seed(1)

sample_cord_index = np.random.choice(range(m*n), round(sampleRate * m * n), replace=False)
# print(sample_cord_index)

# sample_num = round(sampleRate * m * n)

sample_cord = [allsample[sam] for sam in sample_cord_index]
# print(sample_cord)
label = [np.array(img)[c] for c in sample_cord]

# print(label)

# input()
newimg = np.zeros((m, n), np.uint8)

for i in range(len(sample_cord)):
    newimg[sample_cord[i]] = label[i]

# print(newimg[9])
cv2.imwrite(f'sampling_{round(sampleRate * 100)}.png', newimg)

cv2.imshow("dd", newimg)
cv2.waitKey(2000)

# X = [(1, 1), (2, 2), (3, 3), (4, 4)]
# y = [1, 2, 3, 4]

start = time.clock()
neigh = knn(n_neighbors=30, weights="distance")
neigh.fit(sample_cord, label)

end = time.clock()
for row in range(m):
    for col in range(n):
        if (row, col) not in sample_cord:
            newimg[row, col] = neigh.predict([(row, col)])

print(f"the MSE is {np.linalg.norm(newimg - img)/(m * n)}")

print(f"the run time is {end - start}")

cv2.imwrite('result.png', newimg)
cv2.imshow('new', newimg)
cv2.waitKey(0)
