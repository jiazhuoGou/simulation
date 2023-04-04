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
    tic;
    candiate_net = CalcCanNet_GRA(uav); % 因为灰色关联也是那些
    target_net = GRA_select(candiate_net);

end % 整个大的for循环






end




function [CanNet] = CalcCanNet_GRA(uav)
    % 首先还是计算候选网络
    BS1 = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
    DATA1 = readmatrix('D:\simulation\data\InfoData.xlsx','Sheet','InfoDataSheet');

    BS_NUM = size(BS1, 1);
    DATA_NUM = size(DATA1, 1);
    CanNet_Temp = [];

    % 先把能够连接的基站找出来




end

function [TargetNet] = GRA_select(CanNet)

end

