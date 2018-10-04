
clear; close all;
%% �����ź�
choice_transform = 0;      % ѡ����������1Ϊѡ��DCT�任��0Ϊѡ��FFT�任
choice_Phi = 0;         %ѡ���������1Ϊ���ֹ��������0Ϊ��˹�������
%-----------------------�������Ǻ�������Ƶ���DCT����ɢ�ź�--------------------------
n = 512;
t = [0: n-1];
f = cos(2*pi/256*t) + sin(2*pi/128*t);   % ����Ƶ��ϡ����ź�
%-------------------------------�źŽ�������-----------------------
n = length(f);
a = 0.2;            %    ȡԭ�źŵ� a%
m = double(int32(a*n));

%--------------------------------------���ź�ͼ--------------------------------------
switch choice_transform
    case 1
        ft = dct(f);
        disp('ft = dct(f)')
    case 0
        ft = fft(f);
        disp('ft = fft(f)')
end
 
disp(['�ź�ϡ��ȣ�',num2str(length(find((abs(ft))>0.1)))])
 
figure('name', 'A Tone Time and Frequency Plot');
subplot(3, 1, 1);
plot(f);
xlabel('Time (s)'); 
% ylabel('f(t)');
subplot(3, 1, 2);


switch choice_transform
    case 1
        plot(ft)
        disp('plot(ft)')
    case 0
        plot(abs(ft));
        disp('plot(abs(ft))')
end
xlabel('Frequency (Hz)');

% ylabel('DCT(f(t))');
%% ������֪�����ϡ���ʾ����
%--------------------------���ø�֪�������ɲ���ֵ---------------------
switch choice_Phi
    case 1
        Phi = PartHadamardMtx(m,n);       % ��֪���󣨲�������    ���ֹ��������
    case 0
        Phi = sqrt(1/m) * randn(m,n);     % ��֪���󣨲�������   ��˹�������
end
% Phi =  randn(m,n);    %randn ���ɱ�׼��̬�ֲ���α���������ֵΪ0������Ϊ1��
% Phi = rand(m,n);    % rand ���ɾ��ȷֲ���α��������ֲ��ڣ�0~1��֮��
Phi
f2 = (Phi * f')';                 % ͨ����֪�����ò���ֵ
% plot(f2)
subplot(3, 1, 3);
plot(1:length(f2), f2);

% f2 = f(1:2:n);
switch choice_transform
    case 1
        Psi = dct(eye(n,n));            %��ɢ���ұ任������ �������дΪPsi = dctmtx(n);
        disp('Psi = dct(eye(n,n));')
    case 0
        Psi = inv(fft(eye(n,n)));     % ����Ҷ���任��Ƶ��ϡ����������ϡ���ʾ����
        disp('Psi = inv(fft(eye(n,n)));')
end
A = Phi * Psi;                    % �ָ����� A = Phi * Psi
