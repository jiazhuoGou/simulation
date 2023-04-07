function [TargetNet] = SimpleAdditiveWeighting(CanNet)
% 列 3列要正向化处理 
    % RSS
    M = max(abs(CanNet(:,3) - 0)); % 正向化指标，因为RSS是一个负数
    CanNet(:,3) = 1 - abs(CanNet(:,3)) ./ M;

    %567列分别是时延抖动丢包，
    CanNet(:,5) = max(CanNet(:,5)) - CanNet(:,5);
    CanNet(:,6) = max(CanNet(:,6)) - CanNet(:,6);
    CanNet(:,7) = max(CanNet(:,7)) - CanNet(:,7);

    % 参数预处理，每一列除以这一列的均值
    CanNet_temp = CanNet(:,2:size(CanNet,2));
    col_mean = mean(CanNet_temp, 1); % 求出每列的均值 ，第一类id不要动
    B = bsxfun(@rdivide, CanNet_temp, col_mean); % B是不带id的有用矩阵


score = zeros(size(CanNet, 1), 1);
for i = 1 : size(CanNet, 1)
    score(i) = (1/6) * B(i, 1) + (1/6) * B(i, 2) + (1/6) * B(i, 3) + (1/6) * B(i, 4) + (1/6) * B(i, 5) + (1/6) * B(i,6);
end
TargetNet = [CanNet, score];
TargetNet = sortrows(TargetNet, size(TargetNet,2), "descend"); % 按照总分降序排列

end

