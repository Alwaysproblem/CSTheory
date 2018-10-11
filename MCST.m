original = imread('./image/cute.jpg');
figure('Name', 'Origianl eromanga sensei');
% imshow(original);

gray = rgb2gray(original);
gray_double = double(gray);
figure('Name', 'Gray eromanga sensei');
imshow(gray);

% Sampling from gray picture:
sample_matrix = zeros(size(gray_double));
[m, n] = size(sample_matrix)
% sample = ;