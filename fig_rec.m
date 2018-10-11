% 利用稀疏理论进行图像重建测试
clear; clc;

im = imread('https://upload.wikimedia.org/wikipedia/en/2/24/Lenna.png');  % 读入图像
figure(),
subplot(131),
imshow(im);
title('原始彩色图像');


imgrey = rgb2gray(im);              % 转为灰度图像
subplot(132),
imshow(imgrey);
title('原始灰度图像');

bsize = 8;
imcols = im2col(im2double(imgrey), [bsize, bsize], 'distinct');

codebook = dctmtx(bsize ^ 2);                   % DCT字典矩阵

% 稀疏求解，需要对imcols的行进行遍历
cols = size(imcols, 2);
sparse = zeros(size(imcols));
for i = 1 : cols
    sparse(:, i) = BP_linprog(imcols(:, i), codebook);
end

% 图像重建
imrecons = codebook * sparse;
imrecons = col2im(imrecons, [bsize bsize], size(imgrey), 'distinct');
subplot(133),
imshow(imrecons);
title('稀疏重建图像');