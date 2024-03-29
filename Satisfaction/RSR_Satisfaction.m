function [satisfaction] = RSR_Satisfaction(selected_numbers)
%RSR_SATISFACTION 输入：被选中的无人机id
%   输出：该区域内全体基站的负载率，剩余资源块除以所有资源块
%   求得是要回传的这些无人机的用户满意度均值


UAV = readmatrix('D:\simulation\data\InfoUAV.xlsx','Sheet','InfoUAVSheet');
BS = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
DATA = readmatrix('D:\simulation\data\InfoData.xlsx','Sheet','InfoDataSheet');


%% 数据
[uav_rows, ~] = size(UAV);
satisfaction = 0;


%% 具体流程
for i = 101 : uav_rows + 100
    uav = UAV(i-100, :); % i是无人机编号
    if ~ismember(selected_numbers, uav(8)) % 如果该无人机不在，那么不用回传
        continue;
    end
    candiate_net = RSR_CalcCanNet(uav);
    target_net = RSR(candiate_net);
    for j = size(target_net,1)
        ap = target_net(j,:);
        ap_id = ap(1);
        if ap_id < 100 % 基站
            if  DATA(i-100, 3) == 1 &&  BS(ap_id, 7) >= 1 % 说明这个基站可以接小数据
                BS(ap_id, 7) = BS(ap_id,7) - 1; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                satisfaction = satisfaction + getSa(1, ap(7));
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && BS(ap_id, 7) >= 3 % 说明可以接大数据
                BS(ap_id, 7) = BS(ap_id,7) - 3; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                satisfaction = satisfaction + getSa(2, ap(7));
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            end
        else % 接入点是无人机
            if DATA(i-100, 3) == 1 && UAV(ap_id - 100, 5) >= 1
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 1;
                best_net = target_net(j,:);
                satisfaction = satisfaction + ap(5); % 第5个是qoe
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && UAV(ap_id - 100, 5) >= 3
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 3;
                best_net = target_net(j,:);
                satisfaction = satisfaction + ap(5); % 第5个是qoe
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            end
        end
    end
    % 如果上面都不满足，选一个rss最好的
    if ~flag
        target_net = sortrows(candiate_net, 3, "descend");
        best_net  = target_net(1);
        if (best_net(1) < 100)
            if  DATA(i-100, 3) == 1
                BS(best_net(1), 7) = BS(best_net(1),7) - 1; % 更新资源快
                satisfaction = satisfaction + getSa(1, best_net(7));
            else
                BS(best_net(1), 7) = BS(best_net(1),7) - 3;
                satisfaction = satisfaction + getSa(2, best_net(7));
            end
        disp(['无人机 ', num2str(i),'  接入点 : ', num2str(best_net(1))]);
        end
    end
end % for循环end
satisfaction = satisfaction / size(selected_numbers, 1);

end



function [sa] = getSa(data_type, rate)
    w1 = 0.8;
    w2 = 0.2;
    error =  0.05 + (0.12-0.07).*rand(1,1);
    beta = 400; % 常量
    seta = 0.8; % 常量
    if data_type == 1
       sa = w1 * seta * (log((beta - rate) / 0.5) - error) + w2 * abs(normrnd(5,sqrt(2)));
    else
        sa = w1 * seta * (log((beta - rate) / 3) - error) + w2 * abs(normrnd(5,sqrt(2)));
    end
end
