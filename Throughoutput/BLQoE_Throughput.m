function [throughput] = BLQoE_Throughput(selected_numbers)
%BLQOE 输入：被选中的无人机id
%   输出：这些id的无人机的回传数据时的总吞吐量，一个数
% 吞吐量是单位时间内传输的数据量大小

 UAV = readmatrix('D:\simulation\data\InfoUAV.xlsx','Sheet','InfoUAVSheet');
 BS = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
 DATA = readmatrix('D:\simulation\data\InfoData.xlsx','Sheet','InfoDataSheet');


%% 数据
[uav_rows, ~] = size(UAV);
throughput = 0;


%% 具体流程
for i = 101 : uav_rows + 100
    uav = UAV(i-100, :); % i是无人机编号
    if ~ismember(selected_numbers, uav(8)) % 如果该无人机不在，那么不用回传
        continue;
    end
    candiate_net = CalcCanNet(uav);
    %target_net = TOPSIS(candiate_net);
    target_net = sortrows(candiate_net, 2);
    for j = size(target_net,1)
        ap = target_net(j,:);
        ap_id = ap(1);
        if ap_id < 100 % 基站
            if  DATA(i-100, 3) == 1 &&  BS(ap_id, 7) >= 1 % 说明这个基站可以接小数据
                BS(ap_id, 7) = BS(ap_id,7) - 1; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                throughput = throughput + target_net(j, 2) + 2;
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && BS(ap_id, 7) >= 3 % 说明可以接大数据
                BS(ap_id, 7) = BS(ap_id,7) - 3; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                throughput = throughput + target_net(j, 2);
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            end
        else % 接入点是无人机
            if DATA(i-100, 3) == 1 && UAV(ap_id - 100, 5) >= 1
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 1;
                best_net = target_net(j,:);
                throughput = throughput + target_net(j, 2);
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && UAV(ap_id - 100, 5) >= 3
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 3;
                best_net = target_net(j,:);
                throughput = throughput + target_net(j, 2) + 3;
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            end
        end
    end
    % 如果上面都不满足，选一个速度最好的不是宏基站的
    if ~flag
        target_net = sortrows(candiate_net, 2, "descend");
        for k = 1 : size(target_net, 1)
            if target_net(k, 1)  > 2
                best_net  = target_net(k);
                break;
            end
        end
        throughput = throughput + best_net(2) + 3;
        disp(['无人机 ', num2str(i),'  接入点（macro） : ', num2str(best_net(1))]);
    end
end % for循环end

end

