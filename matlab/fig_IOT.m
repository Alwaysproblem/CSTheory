% 利用�?��理论进行图像重建测试
clear; clc;close all;

im = imread('./image/back.jpg');  % 读入图像
figure(),
subplot(141),
imshow(im);
title('the original image');

% imgray = im;

imgray = rgb2gray(im);              % 转为灰度图像
subplot(142),
imshow(imgray);
title('the original gray image');

% bsize = 8;
% imcols = im2col(im2double(imgrey), [bsize, bsize], 'distinct');

imdouble = im2double(imgray);
% subplot(143);
% imshow(imdouble);
% title('the original gray image');

[m, n] = size(imdouble);

org_sig = reshape(imdouble, [n * m, 1]);

N = m * n;
S_rate = 30;
M = round(S_rate / 100 * N);

s_T = randperm(N, M);

samp_mat = eye(N);
show_sam_max = zeros(1, N);
show_sam_max(s_T) = 1;
show_SMat = diag(show_sam_max);

Phi = samp_mat(s_T, :);

y = Phi * org_sig;

imsample = reshape(show_SMat * org_sig, [m, n]);
subplot(143);
imshow(imsample);
title('sampling from the original image');

Psi = dctmtx(N)';                   % DCT字典矩阵
% Psi = idct(eye(N));

A = Phi * Psi;

% theta = BP_linprog(y, A);
% theta = GraDeS_Basic(y, A, 150);
theta = omp(y, A, N)';
recovery_vector = Psi * theta;

re_img = reshape(recovery_vector, [m, n]);
subplot(144);
imshow(re_img);
title('the recovery image');
