function [ LinkQuality ] = CalcLinkQuality(  snr_db, rate )
%CALCLINKQUALITY ����һ�����ʺ�����ʵ�����
%   ����i��j����·����

    %% �����ж�j�����˻����ǻ�վ
    per = CalcPer(snr_db);  % ת��Ϊ�����ͣ�ת��Ϊ��λ��
    per = 10 * (1 -per);
    
    matrix = [1, 2;
            0.5, 1;
            ]; % �о����� n = 2�����о�
    [eig_vector, eig_value] = eig(matrix); % ����ֵ����������������ֵ�ǶԽ���
    eig_value_max = max(max(eig_value)); % �������ֵ
    eig_vector_max = eig_vector( :,  diag(eig_value) == eig_value_max ); % �������ֵ��Ӧ����������

    weight = eig_vector_max ./ sum(eig_vector_max);

    LinkQuality = weight(1) * rate + weight(2) * per;


end

