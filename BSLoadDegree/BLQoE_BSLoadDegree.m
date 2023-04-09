function [bs_load_degree] = BLQoE_BSLoadDegree(selected_numbers)
%BLQOE_BSLOADDEGREE 输入：被选中的无人机id
%   输出：该区域内全体基站的负载率，剩余资源块除以所有资源块
%   求得是基站负载率，所以接入无人机簇头节点的不用算在里面，所以我组了网的负载率肯定会更低

UAV = readmatrix('D:\simulation\data\InfoUAV.xlsx','Sheet','InfoUAVSheet');
BS = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
DATA = readmatrix('D:\simulation\data\InfoData.xlsx','Sheet','InfoDataSheet');

%% 数据
[uav_rows, ~] = size(UAV);
bs_load_degree = 0;


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
                BS(ap_id, 7) = BS(ap_id,7) - 2; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && BS(ap_id, 7) >= 3 % 说明可以接大数据
                BS(ap_id, 7) = BS(ap_id,7) - 3; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            end
        else % 接入点是无人机
            if DATA(i-100, 3) == 1 && UAV(ap_id - 100, 5) >= 1
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 2;
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
    end
    % 如果上面都不满足，选一个qoe最好的
    if ~flag
        target_net = sortrows(candiate_net, 5, "descend");
        best_net  = target_net(1);
        if (best_net(1) < 100)
            if  DATA(i-100, 3) == 1
                BS(best_net(1), 7) = BS(best_net(1),7) - 2; % 更新资源快
            else
                BS(best_net(1), 7) = BS(best_net(1),7) - 3;
            end
        disp(['无人机 ', num2str(i),'  接入点 : ', num2str(best_net(1))]);
        end
    end
end % for循环end
    % 在这些无人机选完网后，重新统计基站的负载情况
    for i = 1 : size(BS, 1)
        bs_load_degree = bs_load_degree + BS(i, 7) / BS(i, 6);
    end
    bs_load_degree = bs_load_degree / size(BS, 1);

end

