function [ LinkQuality ] = CalcLinkQuality(  snr_db, rate )
%CALCLINKQUALITY 返回一个速率和误包率的向量
%   计算i到j的链路质量

    %% 首先判断j是无人机还是基站
    per = CalcPer(snr_db);  % 转化为极大型，转化为个位数
    per = 10 * (1 -per);
    
    matrix = [1, 2;
            0.5, 1;
            ]; % 判决矩阵 n = 2不用判决
    [eig_vector, eig_value] = eig(matrix); % 特征值和特征向量，特征值是对角线
    eig_value_max = max(max(eig_value)); % 最大特征值
    eig_vector_max = eig_vector( :,  diag(eig_value) == eig_value_max ); % 最大特征值对应的特征向量

    weight = eig_vector_max ./ sum(eig_vector_max);

    LinkQuality = weight(1) * rate + weight(2) * per;


end

