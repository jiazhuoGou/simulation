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

uav = UAV(11,:);
candiate = SimpleAdditiveWeighting_CalcCanNet(uav);
disp(candiate);
target = SimpleAdditiveWeighting(candiate);
disp(target);