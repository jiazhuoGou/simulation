function [ cluster ] = ConstructCluster( uav )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   ���ɴأ������ǰ�ڵ㲢�������������ô����һ��������
%   ���صĴ�ͷ�ڵ㣨����������
    
    UAV   = xlsread('D:\simulation\data\InfoUAV.xlsx','InfoUAVSheet'); % ����·��
    [uav_num,~] = size(UAV); 
    neighbors = []; % �洢�ھӽڵ㣬ÿ����һ���ھ�
    
    
    %% ͨ������ȷ��ֵ�ǰuav���ھӽڵ�
    for i =1 : uav_num
        if uav(8) == UAV(i, 8)
            continue;
        end
        % �������˻�֮������ȷֱ�����10���л�������
        db = CalcSNRU2U(uav, UAV(i,:));
        if db(1) > 10
            neighbors  = [neighbors; UAV(i,:)];
        end
    end
    neighbors_num = size(neighbors, 1);
    
    %% ���ھӽڵ����ƶ������⣬��һ��ɸѡ�ھӽڵ�
    
    
    %% ���ھӽڵ㵽��վ����ͨ����Դ���
%     neighbors_com_res = zeros(neighbors_num, 1);    % ��ʱ�洢�ھ����˻�����վ�ķ���
%     for i = 1 : neighbors_num
%         neighbors_com_res(i) = U2BComResDec(neighbors(i, :));
%     end
    
    %% �Ե�ǰ���˻����ھ����˻�����·�������
    neighbors_link_dec = zeros(neighbors_num, 1);   % ��ʱ�洢���˻������˻��ķ���
    for i = 1 : neighbors_num
        % ������·����
        neighbors_link_dec(i) = U2UComResDec(uav, neighbors(i,:));
    end
    
    %% ����������������������Ȩ���֣��õ������˻������ھӽڵ���ۺ�����
%     w1 = 0.6;
%     w2 = 0.4;
%     neighbor_total_score = zeros(neighbors_num, 1);
%     for i = 1 : neighbors_num
%        neighbor_total_score(i) = w1 * neighbors_com_res(i) + w2 * neighbors_link_dec(i);  
%     end
    
    %% ���ھӽڵ㸳ֵ���Լ�ԭ����id
%     neighbor_id = zeros(1, neighbors_num)'; % �ھӱ��
%     for i = 1 : neighbors_num
%         neighbor = neighbors(i, :);
%         neighbor_id(i) = neighbor(8); % ��8�������˻����
%     end
    
    % ������·��������ֱ��ѡ��ǰ���� 
    
    cluster = neighbors;
    %% ֱ�ӷ�����ݽڵ�
    %cluster = horzcat( neighbors, neighbor_total_score);
    %cluster = cluster(:,1:9);    
    
end

