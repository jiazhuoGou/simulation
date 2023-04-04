%% ��Ȩ����Ȩ��
function [Weight] = Entropy_Weight(matrix)
    % ���ֻ��һ�л�����⣬Ҫ��������ж�

    % �����j��ָ���µ�i��������ռ�ı��أ��õ��ľ�����Ȩ���õ��ĸ���
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
    

    %ahp�����ڸ���һ��
    matrix = [1, 2, 4, 1;
            0.5, 1, 2, 0.5;
            0.25, 0.5, 1, 0.25;
            1, 2, 0.25, 1]; % �о�����    �����
    [eig_vector, eig_value] = eig(matrix); % ����ֵ����������������ֵ�ǶԽ���
    eig_value_max = max(max(eig_value)); % �������ֵ
    eig_vector_max = eig_vector( :,  diag(eig_value) == eig_value_max ); % �������ֵ��Ӧ����������
    weight_ahp = eig_vector_max ./ sum(eig_vector_max);
    
    Weight = 0.7 .* weight_entryopy + 0.3 * weight_ahp;

end



