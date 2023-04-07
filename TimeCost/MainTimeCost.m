%% 时间开销计算

addpath(genpath('../Utilize'));
addpath(genpath('../Info'));

clear;
InfoBs;
InfoUAV
InfoData;

UAV = readmatrix('D:\simulation\data\InfoUAV.xlsx','Sheet','InfoUAVSheet');
BS = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
DATA = readmatrix('D:\simulation\data\InfoData.xlsx','Sheet','InfoDataSheet');

%% 数据，这些是要传给那些具体的选网函数
[uav_rows, uav_cols] = size(UAV);
[bs_rows, bs_cols] = size(BS);
[data_rows, data_cols] = size(DATA);
algorithm_counts = 4;
% 每行是一个算法的时间开销，每列是各算法在确定号无人机个数的时候平均的开销时间
time_cost_total = zeros(algorithm_counts, 4);

range = 101:120;  % 定义范围
%% 没5 10 15 20 测量一次选网的时间, 所以要先对UAV矩阵随机抽取几个，总共4轮循环
for i = 1 : 4
    % 先从101-120随机抽 i * 5 个编号，代表要回传的无人机
    rand_indices = randperm(length(range), i * 5);  % 从范围内随机抽取i * 5个整数的索引
    selected_numbers = range(rand_indices);  % 根据索引获取对应的整数，即需要回传的无人机

    % 自己的算法
    time_cost_total(1, i) = BLQoE_TimeCost(selected_numbers);
    disp('BlQoeE');
    
    % 对比算法1 ahpsaw
    time_cost_total(2, i) = AHPSAW_TimeCost(selected_numbers);
    disp('AHPSAW');

    % 对比算法2 灰色关联GRA
    time_cost_total(3, i) = GRA_TimeCost(selected_numbers);
    disp('GRA');

    % 对比算法3 RSR
    time_cost_total(4, i) = RSR_TimeCost(selected_numbers);
    

    % 一轮结束，无人机动一下
    UAV = random_fly(UAV, uav_rows);
    DATA = random_datasize_change();
    writematrix(UAV, 'D:\simulation\data\InfoUAV.xlsx','sheet','InfoUAVSheet', 'writemode', 'replacefile');    
    writematrix(DATA, 'D:\simulation\data\InfoData.xlsx', 'sheet', 'InfoDataSheet', 'writemode', 'replacefile'); 

end
writematrix(time_cost_total,'D:\simulation\TimeCost\TimeCost.xlsx','Sheet','Timecost', 'WriteMode','replacefile');




%% 将无人机传输的数据量变一下
function [out] = random_datasize_change()
ID  = (101:1:120)';
DATA_SIZE = zeros(1,20)';
TYPE = zeros(1, 20)';

%先随机5个传小数据
small_id = randi([101,120], 1, 5);
for i = 1 : 5
    DATA_SIZE(small_id(i) - 100) = randi([20, 30], 1, 1);
    TYPE(small_id(i) - 100) = 1;
end

% 剩下的15个传大数据
for i = 101 : 120
    if ~ismember(i, small_id) % 如果id不在要传小数据的里面
        DATA_SIZE(i - 100) = randi([80, 120], 1, 1);
        TYPE(i - 100) = 2;
    end
end
out= horzcat(ID, DATA_SIZE, TYPE);
end


function [out] = random_fly(UAV, rows)
%% 先模拟无人机随机飞一会
for i = 1 : rows
    UAV(i,1) = UAV(i,1) + randi([-30, 30], 1, 1);
    UAV(i, 2) = UAV(i,2) + randi([-30, 30], 1, 1);
    UAV(i, 3) = randi([20, 50], 1, 1);
end
out  = UAV;
end
