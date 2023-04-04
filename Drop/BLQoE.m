function [drop_rate] = BLQoE(selected_numbers)
%BLQOE 返回掉话率
%   掉话率百分比

UAV = readmatrix('D:\simulation\data\InfoUAV.xlsx','Sheet','InfoUAVSheet');
BS = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
DATA = readmatrix('D:\simulation\data\InfoData.xlsx','Sheet','InfoDataSheet');

%% 数据
[uav_rows, ~] = size(UAV);
time_cost = 0;


%% 具体流程
for i = 101 : uav_rows + 100 
    uav = UAV(i-100, :);
    if ~ismember(selected_numbers, uav(8)) % 如果该无人机不在，那么不用回传
        continue;
    end

    candiate_net = CalcCanNet(uav, UAV, BS, DATA);
    target_net = TOPSIS(candiate_net);

    % 先判断该无人机需要的资源快够不够
    % 候选网络都不够掉话+1，有一个够选哪一个购的

   % 遍历target, 判断接入网络资源是否足够，选择资源够的接入，并且更新资源快
    for j = size(target_net,1)
        ap_id = target_net(1);
        if ap_id < 100 % 基站
            if  DATA(i-100, 2) >= 20 && DATA(i-100, 2) <= 30 &&  BS(ap_id, 7) >= 10 % 说明这个基站可以接小数据
                BS(ap_id, 7) = BS(ap_id,7) - 15; % 更新资源快 
                bestnet = target_net(j); % 第j个就是最优的
                break;
            elseif DATA(i-100, 2) >= 80 && DATA(i-100, 2) <= 120 && BS(ap_id, 7) >= 15 % 说明可以接大数据
                BS(ap_id, 7) = BS(ap_id,7) - 15; % 更新资源快 
                bestnet = target_net(j); % 第j个就是最优的
                break;
            end
        else % 接入点是无人机
            if DATA(i-100, 2) >= 20 && DATA(i-100, 2) <= 30 && UAV(ap_id - 100, 5) >= 10
                UAV(ap_id - 100, 5) = BS(ap_id - 100,5) - 15;
                bestnet = target_net(j);
                break;
            elseif DATA(i-100, 2) >= 80 && DATA(i-100, 2) <= 120 UAV(ap_id - 100, 5) >= 15
                BS(ap_id - 100, 5) = BS(ap_id - 100,5) - 20;
                bestnet = target_net(j);
                break;
            end 
        end
    end


     % 算时间开销
     

     output = [uav(8), best_net];
     disp( output );
end % for循环

end

