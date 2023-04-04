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

    
A =      [1,2,7;
         2,3, 6;  
          3,4,9
]
col_mean = mean(A, 1); % 求出每列的均值
B = bsxfun(@rdivide, A, col_mean); % 每列的数据都除以对应列的均值，得到新的矩阵 B
Y = [max(B(:,1)), max(B(:,2)), max(B(:,3))];
    n = size(B,1);
    array = reshape(y, [n, 1]) - B; % 极差矩阵
    a = min(array); % 关联系数
    b = max(array);
    grey_d = mean((a + 0.5 * b) ./ (array + 0.5 * b), 1); %灰色关联度
    weights = grey_d ./ sum(grey_d);

    % 归一化前的得分
    s = sum(x .* weights', 2); 


    