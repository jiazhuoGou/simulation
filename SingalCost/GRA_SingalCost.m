function [singal_cost] = GRA_SingalCost(selected_numbers)
%GRA 输入：被选中的无人机id
%   输出：这些id的无人机的回传数据时的总吞吐量，一个数
% 吞吐量是单位时间内传输的数据量大小

%  是否接入自组织网络，如果接入自组织网络，则还需要添加自组织网络的信令开销
%              信令开销为基本的信令开销 + 自组织网络生成和维护的开销。
%                基本的信令开销，分为两个部分：终端请求接入网络、网络同意终端接入
%                正常的数据通信都设置为45；
%             if(tar_net < 100 )
%                 请求连接 + 请求确认 + 切换开销 + 正常数据通信 
%                  signal_cost(i,tar_net)  = randi([1,5]) + randi([1,5]) + randi([60,90]);     
%             else
%                 请求连接 + 请求确认 + hello消息 + request消息 + ack 消息 + 切换开销 + 正常数据通信   
%                  signal_cost(i,tar_net)  =  randi([1,5]) + randi([1,5]) + randi([20,30]) + randi([20,30]) + randi([20,30]) +  randi([60,90]); 
%             end

UAV = readmatrix('D:\simulation\data\InfoUAV.xlsx','Sheet','InfoUAVSheet');
BS = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
DATA = readmatrix('D:\simulation\data\InfoData.xlsx','Sheet','InfoDataSheet');
%% 数据
[uav_rows, ~] = size(UAV);
singal_cost = 0;

for i = 101 : uav_rows + 100
    uav = UAV(i-100, :); % i是无人机编号
    if ~ismember(selected_numbers, uav(8)) % 如果该无人机不在，那么不用回传
        continue;
    end
    candiate_net = GRA_CalcCanNet(uav); % 参数都是一样的，只是计算方法不一样
    target_net = GRA_Select(candiate_net);
    flag = false;
    % 遍历target, 还是要优先  判断接入网络资源是否足够，选择资源够的接入，并且更新资源快
    % 需要接入无人机才接入，在候选网络的时候应该要更改
    for j = 1 : size(target_net, 1)
        ap = target_net(j,:);
        ap_id = ap(1);
        if ap_id < 100
            if DATA(i-100, 3) == 1 &&  BS(ap_id, 7) >= 1 % 说明这个基站可以接小数据
                BS(ap_id, 7) = BS(ap_id,7) - 1; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                singal_cost = singal_cost + randi([1,5]) + randi([1,5]) + randi([40,70]);
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && BS(ap_id, 7) >= 3 % 说明可以接大数据
                BS(ap_id, 7) = BS(ap_id,7) - 3; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                singal_cost = singal_cost + randi([1,5]) + randi([1,5]) + randi([40,70]);
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            end
        else
            if DATA(i-100, 3) == 1 && UAV(ap_id - 100, 5) >= 1
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 1;
                best_net = target_net(j,:);
                singal_cost = singal_cost + randi([1,5]) + randi([1,5]) + randi([20,30]) + randi([20,30]) + randi([20,30]) +  randi([60,90]);
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && UAV(ap_id - 100, 5) >= 3
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 3;
                best_net = target_net(j,:);
                singal_cost = singal_cost + randi([1,5]) + randi([1,5]) + randi([20,30]) + randi([20,30]) + randi([20,30]) +  randi([60,90]);
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            end
        end
    end % 候选网络的j循环
     % 都不是选一个rss最高的
    if ~flag
        target_net = sortrows(candiate_net, 3, "descend");
        best_net  = target_net(1);
        if (best_net(1) < 100)
            singal_cost  = singal_cost + randi([1,5]) + randi([1,5]) + randi([40,70]); 
        else
            signal_cost = singal_cost +  randi([1,5]) + randi([1,5]) + randi([20,30]) + randi([20,30]) + randi([20,30]) +  randi([60,90]);
        end
        disp(['无人机 ', num2str(i),'  接入点 : ', num2str(best_net(1))]);
    end
end % for循环
end

