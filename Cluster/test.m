addpath(genpath('../Utilize'));
addpath(genpath('../Info'));


% 节点 A 和 B 的坐标
A = [1 2 3];
B = [4 5 6];

matrix = [1, 2;
          0.5, 1;]; % 判决矩阵
    n = size(matrix, 1); % 行数数
    [eig_value, eig_vector] = eig(matrix); % 特征值和特征向量，特征值是对角线
    eig_value_max = max(eig_value); % 最大特征值
    eig_vector_max = eig_vector( :, find( diag(eig_value) == eig_value_max) ); % 最大特征值对应的特征向量



