close all; clear; clc;

original = imread('./image/avator.jpg');
figure;
imshow(original);

org_f = double(original);

[m, n] = size(org_f);

s_perc = 10;                      % the percentage of sampling data

org_sig = reshape(org_f, [m*n, 1]);
N = n * m;
M = round(s_perc / 100 * N);           % the sampling data length


% % figure setting:
% total_fig = 4;
% col_fig = 1;

% figure(1);
% % plot orignal signal
% subplot(total_fig, col_fig, 1);
% plot(T, org_sig);
% title('Original Signal');

% % plot signal after DCT.
% subplot(total_fig, col_fig, 2);
% plot(T, dct(org_sig));
% title('Original Signal after DCT');

s_T = randperm(N, M);

samp_mat = eye(N);
show_sam_max = zeros(1, N);
show_sam_max(s_T) = 1;
show_SMat = diag(show_sam_max);

Phi = samp_mat(s_T, :);

y_show = show_SMat * org_sig;

figure;
imshow(uint8(reshape(y_show, [m, n])));

y = Phi * org_sig;

% subplot(total_fig, col_fig, 3);
% stem(T, show_SMat * org_sig);
% title('Sampling Signal');

% Psi = dct(eye(N));

% A = Phi * Psi;  % sensing matrix

% theta = BP_linprog(y, A);
% recovery = Psi * theta;  % x = Psi * theta
% figure;
% imshow(uint8(reshape(recovery, [m, n])));


% %% plot
% subplot(total_fig, col_fig, 4);
% plot(recovery,'k.-'); % recovery signal
% hold on;
% plot(org_sig,'r'); % original signal
% title('Original Signal vs Recovery');
% hold off;
% legend('Recovery','Original');
% fprintf('\n the error of recovery:');
% norm((recovery - org_sig)) % output error