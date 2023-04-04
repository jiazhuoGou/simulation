addpath(genpath('.\Utilize'));
addpath(genpath('.\Info'));

%        clear;
%        InfoBs;
%        InfoUAV;
%        InfoData;

%% 无人机到基站，基站的接收信号强度，信噪比，路径损耗，速率测试
%{
dis = CalcDis(UAV(10,:), BS(23,:));
avg = CalcPLAvgU2B(UAV(10,:), BS(23,:));
recv = CalcRecvPowerU2B(UAV(10,:), BS(23,:));
snr = CalcSNRU2B(UAV(10,:), BS(23,:));
rate = CalcRate(UAV(10,:), BS(23,:), snr(2));
per = CalcPer(snr(1));
quality = CalcLinkQuality(UAV(10,:), BS(23,:), snr(1), rate);
%}


%% 无人机到无人机 过程不好说，但是结果还可以

%  dis2 = CalcDis(UAV(4,:), UAV(19,:));
%  snr2 = CalcSNRU2U(UAV(20,:), BS(25,:));
%  rate2 = CalcRate(UAV(20,:), BS(25,:), snr2(2));
%  per2 = CalcPer(snr2(1));
%  quality2 = CalcLinkQuality(snr2(1), rate2);


%score = U2BComResDec(UAV(15, :));

clear;
InfoUAV;
InfoBs;
InfoData;


tic;



% % 运行程序
% %cluster = ConstructCluster(UAV(10, :));% 第8列是无人机编号
 UAV_CanNet = CalcCanNet(UAV(10,:));
 target = TOPSIS(UAV_CanNet);
toc;

b = [1;3;5;7;9;11;13;15;17];
rowrank = randperm(size(b,2));  % size获得b的列数，randperm打乱各列的顺序
b1 = b(:,rowrank);              % 按照rowrank重新排列各列，注意rowrank的位置






