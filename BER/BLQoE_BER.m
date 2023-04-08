function [ber_average] = BLQoE_BER(selected_numbers)
%BLQOE_BER 此处显示有关此函数的摘要
%   返回要回传数据的无人机平均误码率 误码率需要根据接收信号强度计算 ，所以在计算网络的时候还需要重新计算一次r's'srss


UAV = readmatrix('D:\simulation\data\InfoUAV.xlsx','Sheet','InfoUAVSheet');
BS = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
DATA = readmatrix('D:\simulation\data\InfoData.xlsx','Sheet','InfoDataSheet');

%% 数据
[uav_rows, ~] = size(UAV);
ber_average = 0;


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
                % 计算误码率
                ber_average = ber_average + CalcBer(uav, ap_id, UAV, BS);
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && BS(ap_id, 7) >= 3 % 说明可以接大数据
                BS(ap_id, 7) = BS(ap_id,7) - 3; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                % 计算误码率
                ber_average = ber_average + CalcBer(uav, ap_id, UAV, BS);
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            end
        else % 接入点是无人机
            if DATA(i-100, 3) == 1 && UAV(ap_id - 100, 5) >= 1
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 1;
                best_net = target_net(j,:);
                % 计算误码率
                ber_average = ber_average + CalcBer(uav, ap_id, UAV, BS);
                disp(['无人机 ', num2str(i),'  接入点 : ', num2str(ap_id)]);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && UAV(ap_id - 100, 5) >= 3
                UAV(ap_id - 100, 5) = UAV(ap_id - 100,5) - 3;
                best_net = target_net(j,:);
                % 计算误码率
                ber_average = ber_average + CalcBer(uav, ap_id, UAV, BS);
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
        ap_id = best_net(1);
        if (best_net(1) < 100)
            if  DATA(i-100, 3) == 1
                BS(best_net(1), 7) = BS(best_net(1),7) - 1; % 更新资源快
                % 计算误码率
                ber_average = ber_average + CalcBer(uav, ap_id, UAV, BS);
            else
                BS(best_net(1), 7) = BS(best_net(1),7) - 3;
                % 计算误码率
                ber_average = ber_average + CalcBer(uav, ap_id, UAV, BS);
            end
        disp(['无人机 ', num2str(i),'  接入点 : ', num2str(best_net(1))]);
        end
    end
end % for循环end
ber_average = ber_average / size(selected_numbers,1);
end



