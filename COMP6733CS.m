close all; clear; clc;
N = 256;            % the length of the whole signal
M = 64;            % the sampling data length
T = 1:N;
rng(10);
org_sig = 3 * cos(2*pi*T/100)' + randn(N, 1) * 0.1;
% org_sig = randn(N, 1) * 100 + 20;

% figure setting:
total_fig = 4;
col_fig = 1;

figure(1);
% plot orignal signal
subplot(total_fig, col_fig, 1);
plot(T, org_sig);
title('Original Signal');

% plot signal after DCT.
subplot(total_fig, col_fig, 2);
plot(T, dct(org_sig));
title('Original Signal after DCT');

s_T = randperm(N, M);

samp_mat = eye(N);
show_sam_max = zeros(1, N);
show_sam_max(s_T) = 1;
show_SMat = diag(show_sam_max);

Phi = samp_mat(s_T, :);

y = Phi * org_sig;

subplot(total_fig, col_fig, 3);
stem(T, show_SMat * org_sig);
title('Sampling Signal');

Psi = dct(eye(N));

A = Phi * Psi;  % sensing matrix

theta = BP_linprog(y, A);
recovery = Psi * theta;  % x = Psi * theta

%% plot
subplot(total_fig, col_fig, 4);
plot(recovery,'k.-'); % recovery signal
hold on;
plot(org_sig,'r'); % original signal
title('Original Signal vs Recovery');
hold off;
legend('Recovery','Original');
fprintf('\n the error of recovery:');
norm((recovery - org_sig)) % output error