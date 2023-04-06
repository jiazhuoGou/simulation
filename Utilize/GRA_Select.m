function [TargetNet] = GRA_Select(CanNet)
    % 这是一个N行7列的矩阵，后6列才是有用的
    
    % RSS
    M = max(abs(CanNet(:,3) - 0)); % 正向化指标，因为RSS是一个负数
    CanNet(:,3) = 1 - abs(CanNet(:,3)) ./ M;

    %567列分别是时延抖动丢包， 正向化
    CanNet(:,5) = max(CanNet(:,5)) - CanNet(:,5);
    CanNet(:,6) = max(CanNet(:,6)) - CanNet(:,6);
    CanNet(:,7) = max(CanNet(:,7)) - CanNet(:,7);



    % 参数预处理，每一列除以这一列的均值
    CanNet_temp = CanNet(:,2:size(CanNet,2));
    col_mean = mean(CanNet_temp, 1); % 求出每列的均值 ，第一类id不要动
    B = bsxfun(@rdivide, CanNet_temp, col_mean); % B是不带id的有用矩阵
    
    


    % 将每行的最大值抽出来组成一个新的母序列
    y = max(B,[],2);
    n = size(B, 1);
    array = y - B; % 极差矩阵
    a = min(array); % 关联系数
    b = max(array);
    grey_d = mean((a + 0.5 * b) ./ (array + 0.5 * b), 1); %灰色关联度
    weights = grey_d ./ sum(grey_d);

    % 归一化前的得分
    s  = zeros(n, 1);
    for i = 1 : n
        s(i) = weights(1) * B(i,1) + weights(2) * B(i,2) + weights(3) * B(i,3) + weights(4) * B(i, 4) + weights(5) * B(i, 5) + weights(6) * B(i,6);
    end
    s = s ./ sum(s);
    TargetNet = [CanNet(:,1), B, s]; 
    TargetNet = sortrows(TargetNet, size(TargetNet, 2), 'descend'); %第一个就是最好的
end

