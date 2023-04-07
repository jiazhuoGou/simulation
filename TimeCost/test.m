%{
matrix = [1, 2, 4, 1;
            0.5, 1, 2, 0.5;
            0.25, 0.5, 1, 0.25;
            1, 2, 0.25, 1]; % 判决矩阵    
    [eig_vector, eig_value] = eig(matrix); % 特征值和特征向量，特征值是对角线
    eig_value_max = max(max(eig_value)); % 最大特征值
    eig_vector_max = eig_vector( :,  diag(eig_value) == eig_value_max ); % 最大特征值对应的特征向量
    n = 4;
     CI = (eig_value_max - n) / (n - 1);     
     RI_list = [0, 0, 0.52, 0.89, 1.12, 1.26, 1.36, 1.41, 1.46, 1.49, 1.52, 1.54, 1.56, 1.58, 1.59];
     CR_value = CI / (RI_list(n));
    if CR_value < 0.1 % 因为这里n=4
        score = 1;
    else
        score = 0;
    end
tic;
%cluster = ConstructCluster(UAV(6,:));
candiate = CalcCanNet(UAV(6,:));
candiate2 = CalcCanNet_SimpleAdditiveWeighting_test(UAV(6,:));
toc;
elapsed_time = toc;
%}

% [A,B] = QoS();
% new_vec = [min(A(:,1:3)) max(A(:,4))];

% InfoBs;
% InfoUAV;
% InfoUAV;

clc,clear
data = [75.2 3.5 38.2 370.1 101.5 10.0
    76.1 3.3 36.7 369.6 101.0 10.3
    80.4 2.7 30.5 309.7 84.8 10.0
    77.8 2.7 36.3 370.1 101.4 10.2
    75.9 2.3 38.9 369.4 101.2 9.61
    74.3 2.4 36.7 335.3 91.9 9.2
    74.6 2.2 37.5 356.2 97.6 9.3
    72.1 1.8 40.3 401.7 101.1 10.0
    72.8 1.9 37.1 372.8 102.1 10.0
    72.1 1.5 33.2 358.1 97.8 10.4
    ];%待评价指标
weight = [0.093 0.418 0.132 0.100 0.098 0.159];%各指标的权重
data(:,[2,6]) = -data(:,[2,6]);%数据预处理，将成本型指标转换为效益性

ra = tiedrank(data)%编秩，即对每个指标各自进行排序
[row,col] = size(data);% 获取数据的维度信息
RSR = mean(ra, 2)/row;% 计算秩合比
W = repmat(weight, [row,1]);
WRSR = sum(ra.*W, 2)/row;%计算加权秩和比
%[sWRSR, ind] = sort(WRSR);%对加权秩合比排序

p = [1:row] / row; %计算累计频率
p(end) = 1 - 1 / (4 * row) %修正最后一个累计频率，最后一个累计频率按1-1/（4n）估计
probit = norminv(p,0,1) + 5 % 计算标准正太分布的p分位数+5


x = [ones(row,1),probit'];% 构造一元线性回归分析的数据矩阵
[ab, abint, r, rint, stats] = regress(WRSR,x)
WRSRfit = ab(1) + ab(2) * probit; % 计算WRSR的估计值
% WRSRfit'
% y = [1983:1992];
% y(ind)'


