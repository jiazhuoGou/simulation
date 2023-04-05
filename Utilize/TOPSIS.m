function [ TargetNet ] = TOPSIS( CanNet )
%TOPSIS 输入一个候选网络矩阵，n行5列，第一列是接入点编号
%   输出一个排好序的矩阵，那么就代表选网完成 n行6列
    
    [UAV_CanNet_Rows, UAV_CanNet_Cols] = size(CanNet);
    %% 数据正向化,这里不用，只需要把第一列id列排除
    UAV_CanNet_Positive = CanNet(:,2:UAV_CanNet_Cols);
    UAV_CanNet_Normal = Normalizing_Paramter(UAV_CanNet_Positive);

    Weight = Entropy_Weight(UAV_CanNet_Normal); % 主客观一致


    TargetNet = zeros(UAV_CanNet_Rows, UAV_CanNet_Cols - 1);
    TargetNet(:,1) = CanNet(:,1); % 先填id

    % 求第i个对象与最大，最小值的距离
    for i =1 : UAV_CanNet_Rows
        sum = 0;
        for j = 1 : UAV_CanNet_Cols - 1
            sum = sum + Weight(j) * power( (max(UAV_CanNet_Normal(:,j)) -  UAV_CanNet_Normal(i,j)) ,2);
        end
        TargetNet(i, 2) = sqrt(sum);
    end
    for i = 1 : UAV_CanNet_Rows
        sum = 0;
        for j = 1 : UAV_CanNet_Cols - 1
            sum = sum + Weight(j) * power( (min(UAV_CanNet_Normal(:,j)) -  UAV_CanNet_Normal(i,j)), 2);        
        end
        TargetNet(i, 3) = sqrt(sum);
    end
    
    
    % 改进相对贴近距离 理想点是距离最大值最小，距离最小值最大的点
    best = [min(TargetNet(:,2)), max(TargetNet(:,3))];
    for i = 1 : UAV_CanNet_Rows
        TargetNet(i, 4) = sqrt( power( TargetNet(i, 2) - best(1) , 2) + power( TargetNet(i, 3) - best(2) , 2) );
    end
    
    
%     for i = 1 : UAV_CanNet_Rows
%         UAV_TargetNet(i, 4) = UAV_TargetNet(i,3) / (UAV_TargetNet(i, 2) + UAV_TargetNet(i, 3));
%     end
    
    % 整行按照第4列升序排列，距离越小说明到理想解越近，第一个就是最好的
    TargetNet = [CanNet, TargetNet(:,4)];
    %[~, idx] = max(TargetNet(:, 6));
    %TargetNet([1, idx], :) = TargetNet([idx, 1], :);
    TargetNet = sortrows(TargetNet, 6, 'ascend');


    if UAV_CanNet_Rows >= 2 && TargetNet(1,1) > 100 && TargetNet(2, 1) < 100 && TargetNet(2,4) - 0.05 <= TargetNet(1, 4)
        % 差距不大还是要选基站
        TargetNet([1 2], :) = TargetNet([2 1], :); 
    end
end

%% 数据正向化
function [result] = Small_2_Big(array)
            max_num = max(array);
            result = 1 ./ array;
end

function [result] = middle_to_big(array, best)
            M = max(abs(array - best));
            result = 1 - abs(array - best) ./ M;
end

function result = interval_to_big(array, a, b)
            M = max([a - min(array), max(array) - b]);
            result = array;
            result(result < a) = 1 - (a - result(result < a)) / M;
            result((a < result) & (result < b) | (result == a) | (result == b)) = 1;
            result(result > b) = 1 - (result(result > b) - b) / M;
end


%% 数据标准化
function [normal_matrix] = Normalizing_Paramter(matrix)
    if min(matrix(:)) < 0
        for j = 1:size(matrix, 2) % 第1列是接入点编号，不要动
            matrix(:,j) = (matrix(:,j) - min(matrix(:,j))) ./ (max(matrix(:,j)) - min(matrix(:,j)));
        end
    else
        for j = 1:size(matrix, 2)
            matrix(:,j) = matrix(:,j) ./ sqrt(sum(matrix(:,j).^2));
        end
    end
    normal_matrix = matrix;
end




