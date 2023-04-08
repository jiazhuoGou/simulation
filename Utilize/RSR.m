function [TargetNet] = RSR(CanNet)
%RSR 输入：候选网络矩阵 n行7列 id BPM RSS delay jitter packetloss rate
%   输出：目标矩阵 N行8列，后面加一列总的评分，并按照总分降序排序

     % RSS
    M = max(abs(CanNet(:,3) - 0)); % 正向化指标，因为RSS是一个负数
    CanNet(:,3) = 1 - abs(CanNet(:,3)) ./ M;

    %567列分别是时延抖动丢包，正向化
    CanNet(:,5) = max(CanNet(:,5)) - CanNet(:,5);
    CanNet(:,6) = max(CanNet(:,6)) - CanNet(:,6);
    CanNet(:,7) = max(CanNet(:,7)) - CanNet(:,7);

    % 参数预处理标准化，每一列除以这一列的均值 B是有用的矩阵
    CanNet_temp = CanNet(:,2:size(CanNet,2));
    col_mean = mean(CanNet_temp, 1); % 求出每列的均值 ，第一类id不要动
    B = bsxfun(@rdivide, CanNet_temp, col_mean); % B是不带id的有用矩阵


    ra = tiedrank(B);%编秩，即对每个指标各自进行排序

    weight = [0.093, 0.418, 0.132, 0.100, 0.098, 0.159];%各指标的权重
    [row,~] = size(B);% 获取数据的维度信息
    RSR = mean(ra, 2)/row;% 计算秩和比
    W = repmat(weight, [row,1]);
    WRSR = sum(ra.*W, 2)/row;%计算加权秩和比
    %[sWRSR, ind] = sort(WRSR); %对加权秩合比排序 实际不需要

    p = [1:row] / row; %计算累计频率
    p(end) = 1 - 1 / (4 * row); %修正最后一个累计频率，最后一个累计频率按1-1/（4n）估计
    probit = norminv(p,0,1) + 5; % 计算标准正太分布的p分位数+5

    x = [ones(row,1),probit'];% 构造一元线性回归分析的数据矩阵
    [ab, ~, ~, ~, ~] = regress(WRSR,x);
    WRSRfit = ab(1) + ab(2) * probit; % 计算WRSR的估计值 这个就是总的评分，拼接至最后一列
    
    TargetNet = [CanNet, WRSRfit'];
    TargetNet = sortrows(TargetNet, size(TargetNet, 2), 'descend'); %根据最后一列排序

end

