close all, clear all, clc;
% Time Domain ICA with Natural Gradient Algorithm

a=wavread('normal');
aa=(a./0.001);
n=randn(size(aa));
nn=(n./5);

vv1=0.1*aa+0.9*nn;
vv2=0.9*aa+0.1*nn;

mic_1=vv1';   %Reading file from microphone #1.
mic_2=vv2';   %Reading file from microphone #2.

mic_1=mic_1(1:50000);               %memperkecil dan menyamakan sinyal
mic_2=mic_2(1:50000);

%menyamakan dan memperkecil ukuran byte file
% mic_1=mic_1(1:50000);           
% mic_2=mic_2(1:50000);
% mic_3=mic_3(1:50000);

% Plot sinyal input TDICA
figure(1)
subplot(211); plot(mic_1);
subplot(212); plot(mic_2);


mix=[mic_1;mic_2];             %mencampur file suara


[N,P]=size(mix);               %P=sampled time=50000;N=number of input=3
permute=randperm(N);            %generate a permutation vector
s=mix(permute,:);              %time-scrambled inputs for stationarity

x=s;

mx=mean(mix');
c=cov(mix');
x=x-mx'*ones(1,P);
wz=2*inv(sqrtm(c));
x=wz*x;

% w=eye(N);                         
w=[1 1;1 2];
M=size(w,2);                      
sweep=0; oldw=w; olddelta=ones(1,N*N);
Id=eye(M);

L=0.0001; B=30; for I=1:100, sep; end;          %ITERASI TDICA

% Pemisahan sinyal suara
uu=w*wz*mix;         % make unmixed sources
uu11=uu(1,:);
uu12=uu(2,:);

% Plot sinyal estimasi TDICA/input FDICA
figure(2);
subplot(211); plot(uu11);
subplot(212); plot(uu12);