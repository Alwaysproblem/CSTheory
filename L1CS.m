%压缩感知重构算法测试  
clear all;close all;clc;  
M = 64;%观测值个数  
N = 256;%信号x的长度  
K = 10;%信号x的稀疏度  
Index_K = randperm(N);  
x = zeros(N,1);  
x(Index_K(1:K)) = 5*randn(K,1);%x为K稀疏的，且位置是随机的  
Psi = eye(N);%x本身是稀疏的，定义稀疏矩阵为单位阵x=Psi*theta  
Phi = randn(M,N);%测量矩阵为高斯矩阵  
A = Phi * Psi;%传感矩阵  
y = Phi * x;%得到观测向量y  
%% 恢复重构信号x  
tic  
theta = BP_linprog(y,A);
x_r = Psi * theta;% x=Psi * theta  
toc  
%% 绘图  
figure;  
plot(x_r,'k.-');%绘出x的恢复信号  
hold on;  
plot(x,'r');%绘出原信号x  
hold off;  
legend('Recovery','Original')  
fprintf('\n恢复残差：');  
norm(x_r-x)%恢复残差 


