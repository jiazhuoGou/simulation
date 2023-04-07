function [singal_cost] = BLQoE_SingalCost(selected_numbers)
%BLQOE 输入：被选中的无人机id
%   输出：这些id的无人机的回传数据时的总吞吐量，一个数
%    信令开销是接入网络时候产生的

 
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


%% 具体流程
for i = 101 : uav_rows + 100
    uav = UAV(i-100, :); % i是无人机编号
    if ~ismember(selected_numbers, uav(8)) % 如果该无人机不在，那么不用回传
        continue;
    end
    candiate_net = CalcCanNet(uav);
    target_net = TOPSIS(candiate_net);
    for j = size(target_net,1)
        ap = target_net(j,:);
        ap_id = ap(1);
        if ap_id < 100 % 基站
            if  DATA(i-100, 3) == 1 &&  BS(ap_id, 7) >= 1 % 说明这个基站可以接小数据
                BS(ap_id, 7) = BS(ap_id,7) - 1; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                singal_cost  = singal_cost + randi([1,5]) + randi([1,5]) + randi([50,80]); % 信令开销计算
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && BS(ap_id, 7) >= 3 % 说明可以接大数据
                BS(ap_id, 7) = BS(ap_id,7) - 3; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                singal_cost  = singal_cost + randi([1,5]) + randi([1,5]) + randi([50,80]); % 信令开销计算
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            end
        else % 接入点是无人机
            if DATA(i-100, 3) == 1 && UAV(ap_id - 100, 5) >= 1
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 1;
                best_net = target_net(j,:);
                signal_cost = singal_cost +  randi([1,5]) + randi([1,5]) + randi([20,30]) + randi([20,30]) + randi([20,30]) +  randi([60,90]);
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && UAV(ap_id - 100, 5) >= 3
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 3;
                best_net = target_net(j,:);
                signal_cost = singal_cost +  randi([1,5]) + randi([1,5]) + randi([20,30]) + randi([20,30]) + randi([20,30]) +  randi([60,90]);
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            end
        end
    end
    % 如果上面都不满足，选一个qoe最好的
    if ~flag
        target_net = sortrows(candiate_net, 5, "descend");
        best_net  = target_net(1);
        if (best_net(1) < 100)
            singal_cost  = singal_cost + randi([1,5]) + randi([1,5]) + randi([50,80]);        
        else
            signal_cost = singal_cost +  randi([1,5]) + randi([1,5]) + randi([20,30]) + randi([20,30]) + randi([20,30]) +  randi([60,90]);
        end

        disp(['无人机 ', num2str(i),'  接入点 : ', num2str(best_net(1))]);
    end
end % for循环end




end

