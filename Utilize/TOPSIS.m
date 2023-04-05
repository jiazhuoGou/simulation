function [ TargetNet ] = TOPSIS( CanNet )
%TOPSIS ����һ����ѡ�������n��5�У���һ���ǽ������
%   ���һ���ź���ľ�����ô�ʹ���ѡ����� n��6��
    
    [UAV_CanNet_Rows, UAV_CanNet_Cols] = size(CanNet);
    %% ��������,���ﲻ�ã�ֻ��Ҫ�ѵ�һ��id���ų�
    UAV_CanNet_Positive = CanNet(:,2:UAV_CanNet_Cols);
    UAV_CanNet_Normal = Normalizing_Paramter(UAV_CanNet_Positive);

    Weight = Entropy_Weight(UAV_CanNet_Normal); % ���͹�һ��


    TargetNet = zeros(UAV_CanNet_Rows, UAV_CanNet_Cols - 1);
    TargetNet(:,1) = CanNet(:,1); % ����id

    % ���i�������������Сֵ�ľ���
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
    
    
    % �Ľ������������ ������Ǿ������ֵ��С��������Сֵ���ĵ�
    best = [min(TargetNet(:,2)), max(TargetNet(:,3))];
    for i = 1 : UAV_CanNet_Rows
        TargetNet(i, 4) = sqrt( power( TargetNet(i, 2) - best(1) , 2) + power( TargetNet(i, 3) - best(2) , 2) );
    end
    
    
%     for i = 1 : UAV_CanNet_Rows
%         UAV_TargetNet(i, 4) = UAV_TargetNet(i,3) / (UAV_TargetNet(i, 2) + UAV_TargetNet(i, 3));
%     end
    
    % ���а��յ�4���������У�����ԽС˵���������Խ������һ��������õ�
    TargetNet = [CanNet, TargetNet(:,4)];
    %[~, idx] = max(TargetNet(:, 6));
    %TargetNet([1, idx], :) = TargetNet([idx, 1], :);
    TargetNet = sortrows(TargetNet, 6, 'ascend');


    if UAV_CanNet_Rows >= 2 && TargetNet(1,1) > 100 && TargetNet(2, 1) < 100 && TargetNet(2,4) - 0.05 <= TargetNet(1, 4)
        % ��಻����Ҫѡ��վ
        TargetNet([1 2], :) = TargetNet([2 1], :); 
    end
end

%% ��������
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


%% ���ݱ�׼��
function [normal_matrix] = Normalizing_Paramter(matrix)
    if min(matrix(:)) < 0
        for j = 1:size(matrix, 2) % ��1���ǽ�����ţ���Ҫ��
            matrix(:,j) = (matrix(:,j) - min(matrix(:,j))) ./ (max(matrix(:,j)) - min(matrix(:,j)));
        end
    else
        for j = 1:size(matrix, 2)
            matrix(:,j) = matrix(:,j) ./ sqrt(sum(matrix(:,j).^2));
        end
    end
    normal_matrix = matrix;
end




