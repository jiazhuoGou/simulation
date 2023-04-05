function [time_cost] = AHPSAW(selected_numbers)
%AHPSAW % 就是把参数按照权重相乘再相加找一个最好的
%   前面读取数据的操作都是一样的
%   返回值time_cost是5 10 15 20 的总时间开销
%   这个算法的选网参数是资源剩余量，速率，RSS这三样


UAV = readmatrix('D:\simulation\data\InfoUAV.xlsx','Sheet','InfoUAVSheet');
BS = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
DATA = readmatrix('D:\simulation\data\InfoData.xlsx','Sheet','InfoDataSheet');


%% 数据
[uav_rows, ~] = size(UAV);
time_cost = 0;
%% 具体流程
for i = 101 : uav_rows + 100
    uav = UAV(i-100, :); % i是无人机编号
    if ~ismember(selected_numbers, uav(8)) % 如果该无人机不在，那么不用回传
        continue;
    end
    tic; % 开始计时
    candiate_net = SimpleAdditiveWeighting_CalcCanNet(uav); % 参数都是一样的，只是计算方法不一样
    target_net = SimpleAdditiveWeighting(candiate_net);
    flag = false;
    % 遍历target, 还是要优先  判断接入网络资源是否足够，选择资源够的接入，并且更新资源快
    % 需要接入无人机才接入，在候选网络的时候应该要更改
    for j = 1 : size(target_net, 1)
        ap = target_net(j,:);
        ap_id = ap(1);
        if ap_id < 100
            if DATA(i-100, 3) == 1 &&  BS(ap_id, 7) >= 2 % 说明这个基站可以接小数据
                BS(ap_id, 7) = BS(ap_id,7) - 2; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && BS(ap_id, 7) >= 5 % 说明可以接大数据
                BS(ap_id, 7) = BS(ap_id,7) - 5; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                flag = true;
                break;
            end
        else
            if DATA(i-100, 3) == 1 && UAV(ap_id - 100, 5) >= 2
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 2;
                best_net = target_net(j,:);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && UAV(ap_id - 100, 5) >= 5
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 5;
                best_net = target_net(j,:);
                flag = true;
                break;
            end
        end
    end % 候选网络的j循环
     % 都不是选一个qoe最高的
    if ~flag
        target_net = sortrows(candiate_net, size(candiate_net, 2), "descend");
        best_net  = target_net(1);
    end
    elapsed_time = toc;
    time_cost = time_cost + elapsed_time;

end % for循环


end % AHPSAW的循环结束






