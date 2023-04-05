function [time_cost] = GRA(selected_numbers)
%GRA 灰色关联选网
%   选择的参数跟自己的参数是一样的

time_cost = 0;

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
    t1 = clock();
    tic;
    candiate_net = GRA_CalcCanNet(uav); % 因为灰色关联也是那些
    target_net = GRA_Select(candiate_net);
    flag = false;
    % 遍历target, 还是要优先  判断接入网络资源是否足够，选择资源够的接入，并且更新资源快
    % 需要接入无人机才接入，在候选网络的时候应该要更改
    for j = 1 : size(target_net, 1)
        ap_id = target_net(1);
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
                UAV(ap_id - 100, 5) = BS(ap_id - 100,5) - 2;
                best_net = target_net(j,:);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && UAV(ap_id - 100, 5) >= 5
                BS(ap_id - 100, 5) = BS(ap_id - 100,5) - 5;
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
    t2 = clock;
    elapsed_time = toc;
    time_cost = time_cost + elapsed_time;
    
end % 整个大的for循环






end




