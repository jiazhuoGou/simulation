%% 熵权法求权重
function [Weight] = Entropy_Weight(matrix)
    % 如果只有一行会出问题，要算必须先判断

    % 计算第j个指标下第i个样本所占的比重，得到的就是熵权法用到的概率
    [rows, cols] = size(matrix);
    p = zeros(rows, cols);
    for j = 1 : cols
        p(:, j) = matrix(:, j) ./ sum(matrix(:, j));
    end
    e = zeros(1, cols);
    for j = 1 : cols
        array = p(p(:, j) ~= 0, j);
        e(j) =  -1  *  (sum( array .* log(array) ) \ log(rows))  ;
    end
    d = 1 - (e);
    weight_entryopy = d ./ sum(d); 
    

    %ahp主观在更改一下
    matrix = [1, 2, 4, 1;
            0.5, 1, 2, 0.5;
            0.25, 0.5, 1, 0.25;
            1, 2, 0.25, 1]; % 判决矩阵    检验过
    [eig_vector, eig_value] = eig(matrix); % 特征值和特征向量，特征值是对角线
    eig_value_max = max(max(eig_value)); % 最大特征值
    eig_vector_max = eig_vector( :,  diag(eig_value) == eig_value_max ); % 最大特征值对应的特征向量
    weight_ahp = eig_vector_max ./ sum(eig_vector_max);
    
    Weight = 0.7 .* weight_entryopy + 0.3 * weight_ahp;

end



