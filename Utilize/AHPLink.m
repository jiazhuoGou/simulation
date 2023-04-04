function [ score ] = AHPLink( LinkQuality)
%AHP matrx������N��3�У�N��>=1���������˻������Ļ�վ���������˻�
%   ��������˻������˻�����ô��ֻ��һ�У���������˻�����վ��ô�����ж���
%   
    matrix = [1, 2, 2;
            0.5, 1, 2;
            0.5, 0.5, 1]; % �о�����
    [eig_vector, eig_value] = eig(matrix); % ����ֵ����������������ֵ�ǶԽ���
    eig_value_max = max(max(eig_value)); % �������ֵ
    eig_vector_max = eig_vector( :,  diag(eig_value) == eig_value_max ); % �������ֵ��Ӧ����������

%     CI = (eig_value_max - n) / (n - 1);     
%     RI_list = [0, 0, 0.52, 0.89, 1.12, 1.26, 1.36, 1.41, 1.46, 1.49, 1.52, 1.54, 1.56, 1.58, 1.59];
%     CR_value = CI / (RI_list(n));
    %{ 
    �����Ǻϸ��
    if CR_value < 0.1 % ��Ϊ����n=3
        score = 1;
    else
        score = 0;
    end
    %}
    weight = cal_weight_by_eigenvalue_method(eig_vector_max);
    [rows, cols] = size(LinkQuality);
    score = 0;
    for i = 1 : rows
        sum = 0;
        for j = 1 : cols
            sum = sum + LinkQuality(1) * weight(1) + LinkQuality(2) * weight(2) + LinkQuality(3) * weight(3);
        end
        score = score + sum;
    end
    score = score / rows;
   
    
end

function [weight] = cal_weight_by_eigenvalue_method(eig_vector_max)
    weight = eig_vector_max ./ sum(eig_vector_max);
end
    
       
