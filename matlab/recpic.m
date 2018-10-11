%  本程序实现图像LENA的压缩传感
%  程序作者：沙威，香港大学电气电子工程学系，wsha@eee.hku.hk
%  算法采用正交匹配法，参考文献 Joel A. Tropp and Anna C. Gilbert 
%  Signal Recovery From Random Measurements Via Orthogonal Matching
%  Pursuit，IEEE TRANSACTIONS ON INFORMATION THEORY, VOL. 53, NO. 12,
%  DECEMBER 2007.
%  该程序没有经过任何优化
clc;clear

%  读文件
X=imread('./image/back.jpg');
X = rgb2gray(X);
X=im2double(X);
[a,b]=size(X);

%  小波变换矩阵生成
ww=dctmtx(a);

%  小波变换让图像稀疏化（注意该步骤会耗费时间，但是会增大稀疏度）
X1=ww*X*ww';
% X1=X;
% X1=full(X1);

%  随机矩阵生成
M=190;
R=randn(M,a);
% R=mapminmax(R,0,255);
% R=round(R);

% s_T = randperm(N, M);
% samp_mat = eye(N);
% R = samp_mat(s_T, :);

%  测量值
Y=R*X1;

%  OMP算法
%  恢复矩阵
X2=zeros(a,b); 
%  按列循环
for i=1:b 
    %  通过OMP，返回每一列信号对应的恢复值（小波域）
    rec=omp(Y(:,i),R,a);
    %  恢复值矩阵，用于反变换
    X2(:,i)=rec;
end


%  原始图像
figure(1);
imshow(X);
title('原始图像');

%  变换图像
figure(2);
imshow(X1);
title('小波变换后的图像');

%  压缩传感恢复的图像
figure(3);
%  小波反变换
X3=ww'*X2*ww; 
% X3=X2;
X3=full(X3);
imshow(X3);
title('恢复的图像');

%  误差(PSNR)
%  MSE误差
errorx=sum(sum(abs(X3-X).^2));        
%  PSNR
psnr=10*log10(255*255/(errorx/a/b))   
