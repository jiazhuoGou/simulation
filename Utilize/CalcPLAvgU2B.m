function [ PL_AVG_U2B_Los ] = CalcPLAvgU2B( uav, base )
%CALC_PL_AVG_U2B_LOS 此处显示有关此函数的摘要
%   此处显示详细说明
% uav代表一个无人机节点向量，它是UAV矩阵里面的一行
% base代表基站，它是BS矩阵里面的一行

% 自由空间路径衰落
f = 2e9;     %1GHz或者2ghz 要转化为MHz
c = 3e8; 
paramter_los = 1.6;
paramter_nlos = 23;
a = 9.21;%12;
b = 0.04;%0.16;
dis = CalcDis(uav, base); % 

% 视距，非视距路径损耗
Lbf = 20 * log10( (4 * pi * f * dis)  / c); % 单位是dB
PL_Los = Lbf  + paramter_los;
PL_NLos = Lbf  + paramter_nlos;

% 视距与非视距概率
angle = asin( (uav(3) - base(3)) / dis);  % 弧度
angle = angle * (180 / pi); % 要得到角度

P_Los = 1 / ( 1 + a * exp( (-b) * (angle - a))  ); % 这个公式绝对有问题
P_NLos = 1 - P_Los;

% 平均路径损耗
PL_AVG_U2B_Los = PL_Los * P_Los + PL_NLos * P_NLos; % 单位是dB


%{ 
甲虫那篇论文的做法,算出来结果是一样的
avg = (paramter_los - paramter_nlos) / ( 1 + a * exp( (-b) * (angle - a))) + 10 * log10(dis^2) + 20 * log10(4 * pi * f / c) + paramter_nlos;
PL_AVG_U2B_Los = [PL_AVG_U2B_Los, avg];
%}
end

