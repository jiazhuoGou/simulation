function [bs_load_degree] = RSR_BSLoadDegree(selected_numbers)
%RSR_BSLOADDEGREE 此处显示有关此函数的摘要
%   输出：该区域内全体基站的负载率，剩余资源块除以所有资源块
%   求得是基站负载率，所以接入无人机簇头节点的不用算在里面，所以我组了网的负载率肯定会更低


UAV = readmatrix('D:\simulation\data\InfoUAV.xlsx','Sheet','InfoUAVSheet');
BS = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
DATA = readmatrix('D:\simulation\data\InfoData.xlsx','Sheet','InfoDataSheet');


%% 数据
[uav_rows, ~] = size(UAV);
bs_load_degree = 0;


for i = 101 : uav_rows + 100
    uav = UAV(i-100, :); % i是无人机编号
    if ~ismember(selected_numbers, uav(8)) % 如果该无人机不在，那么不用回传
        continue;
    end
    candiate_net = RSR_CalcCanNet(uav); % 参数都是一样的，只是计算方法不一样
    target_net = RSR(candiate_net);
    flag = false;
    % 遍历target, 还是要优先  判断接入网络资源是否足够，选择资源够的接入，并且更新资源快
    % 需要接入无人机才接入，在候选网络的时候应该要更改
    for j = 1 : size(target_net, 1)
        ap = target_net(j,:);
        ap_id = ap(1);
        if ap_id <= 100 % 基站
            if DATA(i-100, 3) == 1 &&  BS(ap_id, 7) >= 1 % 说明这个基站可以接小数据
                BS(ap_id, 7) = BS(ap_id,7) - 2; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                disp(['无人机 ', num2str(i),'  接入点 : ',num2str(ap_id)]);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && BS(ap_id, 7) >= 3 % 说明可以接大数据
                BS(ap_id, 7) = BS(ap_id,7) - 3; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            end
        else
            if DATA(i-100, 3) == 1 && UAV(ap_id - 100, 5) >= 1
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 1;
                best_net = target_net(j,:);
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && UAV(ap_id - 100, 5) >= 3
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 3;
                best_net = target_net(j,:);
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
            if  DATA(i-100, 3) == 1
                BS(best_net(1), 7) = BS(best_net(1),7) - 1; % 更新资源快
            else
                BS(best_net(1), 7) = BS(best_net(1),7) - 3;
        end
        disp(['无人机 ', num2str(i),'  接入点 : ',num2str(best_net(1))]);
        end
    end
end % for循环
    % 在这些无人机选完网后，重新统计基站的负载情况
    for i = 1 : size(BS, 1)
        bs_load_degree = bs_load_degree + BS(i, 7) / BS(i, 6);
    end
    bs_load_degree = bs_load_degree / size(BS, 1);


end

