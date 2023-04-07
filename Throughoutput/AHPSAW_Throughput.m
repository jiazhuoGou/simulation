function [throughput] = AHPSAW_Throughput(selected_numbers)
%AHPSAW 输入：被选中的无人机id
%   输出：这些id的无人机的回传数据时的总吞吐量，一个数
% 吞吐量是单位时间内传输的数据量大小

UAV = readmatrix('D:\simulation\data\InfoUAV.xlsx','Sheet','InfoUAVSheet');
BS = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
DATA = readmatrix('D:\simulation\data\InfoData.xlsx','Sheet','InfoDataSheet');


%% 数据
[uav_rows, ~] = size(UAV);
throughput = 0;

for i = 101 : uav_rows + 100
    uav = UAV(i-100, :); % i是无人机编号
    if ~ismember(selected_numbers, uav(8)) % 如果该无人机不在，那么不用回传
        continue;
    end
    candiate_net = SimpleAdditiveWeighting_CalcCanNet(uav); % 参数都是一样的，只是计算方法不一样
    target_net = SimpleAdditiveWeighting(candiate_net);
    flag = false;
    % 遍历target, 还是要优先  判断接入网络资源是否足够，选择资源够的接入，并且更新资源快
    % 需要接入无人机才接入，在候选网络的时候应该要更改
    for j = 1 : size(target_net, 1)
        ap = target_net(j,:);
        ap_id = ap(1);
        if ap_id <= 100 % 基站
            if DATA(i-100, 3) == 1 &&  BS(ap_id, 7) >= 1 % 说明这个基站可以接小数据
                BS(ap_id, 7) = BS(ap_id,7) - 1; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                throughput = throughput + target_net(j, size(target_net, 2)-1) + 1;
                disp(['无人机 ', num2str(i),'  接入点 : ',num2str(ap_id)]);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && BS(ap_id, 7) >= 3 % 说明可以接大数据
                BS(ap_id, 7) = BS(ap_id,7) - 3; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                throughput = throughput + target_net(j, size(target_net, 2)-1) + 2;
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            end
        else
            if DATA(i-100, 3) == 1 && UAV(ap_id - 100, 5) >= 1
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 1;
                best_net = target_net(j,:);
                throughput = throughput + target_net(j, size(target_net, 2)-1) + 1;
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && UAV(ap_id - 100, 5) >= 3
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 3;
                best_net = target_net(j,:);
                throughput = throughput + target_net(j, size(target_net, 2)-1) + 2;
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
        throughput = throughput + candiate_net(j,3) + 2;
        disp(['无人机 ', num2str(i),'  接入点 : ',num2str(best_net(1))]);
    end
end % for循环

end % ahpsaw循环






