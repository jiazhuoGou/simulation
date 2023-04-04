function [ PL_AVG_U2B_Los ] = CalcPLAvgU2B( uav, base )
%CALC_PL_AVG_U2B_LOS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% uav����һ�����˻��ڵ�����������UAV���������һ��
% base�����վ������BS���������һ��

% ���ɿռ�·��˥��
f = 2e9;     %1GHz����2ghz Ҫת��ΪMHz
c = 3e8; 
paramter_los = 1.6;
paramter_nlos = 23;
a = 9.21;%12;
b = 0.04;%0.16;
dis = CalcDis(uav, base); % 

% �Ӿ࣬���Ӿ�·�����
Lbf = 20 * log10( (4 * pi * f * dis)  / c); % ��λ��dB
PL_Los = Lbf  + paramter_los;
PL_NLos = Lbf  + paramter_nlos;

% �Ӿ�����Ӿ����
angle = asin( (uav(3) - base(3)) / dis);  % ����
angle = angle * (180 / pi); % Ҫ�õ��Ƕ�

P_Los = 1 / ( 1 + a * exp( (-b) * (angle - a))  ); % �����ʽ����������
P_NLos = 1 - P_Los;

% ƽ��·�����
PL_AVG_U2B_Los = PL_Los * P_Los + PL_NLos * P_NLos; % ��λ��dB


%{ 
�׳���ƪ���ĵ�����,����������һ����
avg = (paramter_los - paramter_nlos) / ( 1 + a * exp( (-b) * (angle - a))) + 10 * log10(dis^2) + 20 * log10(4 * pi * f / c) + paramter_nlos;
PL_AVG_U2B_Los = [PL_AVG_U2B_Los, avg];
%}
end

