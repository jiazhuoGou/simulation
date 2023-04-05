function [ cluster ] = ConstructCluster( uav )
%UNTITLED 此处显示有关此函数的摘要
%   生成簇，如果当前节点并不在自组网里，那么构建一个自组网
%   返回的簇头节点（行向量），
    
    UAV   = xlsread('D:\simulation\data\InfoUAV.xlsx','InfoUAVSheet'); % 绝对路径
    [uav_num,~] = size(UAV); 
    neighbors = []; % 存储邻居节点，每行是一个邻居
    
    
    %% 通过信噪比发现当前uav的邻居节点
    for i =1 : uav_num
        if uav(8) == UAV(i, 8)
            continue;
        end
        % 两个无人机之间信噪比分贝大于10的有机会组网
        db = CalcSNRU2U(uav, UAV(i,:));
        if db(1) > 10
            neighbors  = [neighbors; UAV(i,:)];
        end
    end
    neighbors_num = size(neighbors, 1);
    
    %% 对邻居节点作移动方向检测，进一步筛选邻居节点
    
    
    %% 对邻居节点到基站进行通信资源检测
%     neighbors_com_res = zeros(neighbors_num, 1);    % 暂时存储邻居无人机到基站的分数
%     for i = 1 : neighbors_num
%         neighbors_com_res(i) = U2BComResDec(neighbors(i, :));
%     end
    
    %% 对当前无人机到邻居无人机的链路质量检测
    neighbors_link_dec = zeros(neighbors_num, 1);   % 暂时存储无人机到无人机的分数
    for i = 1 : neighbors_num
        % 计算链路质量
        neighbors_link_dec(i) = U2UComResDec(uav, neighbors(i,:));
    end
    
    %% 对上面两个列向量继续加权评分，得到该无人机与其邻居节点的综合评分
%     w1 = 0.6;
%     w2 = 0.4;
%     neighbor_total_score = zeros(neighbors_num, 1);
%     for i = 1 : neighbors_num
%        neighbor_total_score(i) = w1 * neighbors_com_res(i) + w2 * neighbors_link_dec(i);  
%     end
    
    %% 给邻居节点赋值上自己原本的id
%     neighbor_id = zeros(1, neighbors_num)'; % 邻居编号
%     for i = 1 : neighbors_num
%         neighbor = neighbors(i, :);
%         neighbor_id(i) = neighbor(8); % 第8列是无人机编号
%     end
    
    % 根据链路质量排序，直接选择前三个 
    
    cluster = neighbors;
    %% 直接返回另据节点
    %cluster = horzcat( neighbors, neighbor_total_score);
    %cluster = cluster(:,1:9);    
    
end

