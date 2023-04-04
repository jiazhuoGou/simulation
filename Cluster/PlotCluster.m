addpath(genpath('../Utilize'));
addpath(genpath('../Info'));

clear;
InfoBs;
InfoUAV
InfoData;

UAV = readmatrix('D:\simulation\data\InfoUAV.xlsx','Sheet','InfoUAVSheet');
BS = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
DATA = readmatrix('D:\simulation\data\InfoData.xlsx','Sheet','InfoDataSheet');

%% 随机选择两个无人机请求组网，基站只显示关联的，无人机全部显示
selected_id = randi([101,120], 1, 2);
selected_uav =  zeros(2, 9);
k = 1;
for i = 101 : 120
    uav = UAV(i-100,:);
    if ismember(uav(8), selected_id)
        selected_uav(k,:) = uav;
        k = k + 1;
    end
end

%uav1 = selected_uav(1,:);
uav1 = UAV(15,:);

Cannet1 = CalcCanNet(uav1, UAV, BS, DATA);
Cluster1 = [];
Bs1 = [];

%% 首先画第一个无人机
% 提取基站和基站
for i = 1 : size(Cannet1, 1)
    net = Cannet1(i, :);
    if net(1) <= 101
        Bs1 = [Bs1; net];
    else
        Cluster1 = [Cluster1; net]; 
    end
end

target = TOPSIS(Cannet1);
target = sortrows(target, 4, 'descend');
best = target(1);
if best(1) > 100
    best = UAV(best(1) - 100, :);
else
    best = BS(best(1), :);
end

%% 先画该无人机与自组网无人机的连线 连线本质上是两个点
S = 50;
x_center = 0;
y_center = 0;
z_center = 0;
scatter3(uav1(1), uav1(2), uav1(3), S, 'o',  'blue', 'filled');hold on;  % 蓝点，需要回传的无人机，红点自组网
for i = 1 : size(Cluster1, 1)
    for j = 1 : 20
        if Cluster1(i, 1) == UAV(j, 8)
            scatter3(UAV(j,1), UAV(j,2), UAV(j,3), S, 'o',  'red', 'filled');hold on; 
            x_center = x_center + UAV(j, 1);
            y_center = y_center + UAV(j, 2);
            z_center = z_center + UAV(j, 3); 
        end
    end
end


%% 先画该无人机与基站的连线
for i = 1 : size(Bs1)
    for j = 1 : 42
        if Bs1(i, 1) == BS(j, 8)
            scatter3(BS(j,1), BS(j,2), BS(j,3), S, 'o',  'black', 'filled');hold on; 
        end
    end
end

% 无人机与最佳节点的连线
quiver3(uav1(1), uav1(2), uav1(3), best(1)-uav1(1), best(2)-uav1(2), best(3)-uav1(3), ...
    'Color', 'black', 'LineStyle', '--', 'MaxHeadSize', 0.5, 'LineWidth', 1.5);
hold on;








 axis([0 2000 0 2000 0 120]);
 
 title('无人机与基站分布图');  % 添加标题
 xlabel('X coordinate (m)');  % 添加横坐标标签
 ylabel('Y coordinate (m)');  % 添加纵坐标标签
 zlabel('Z coordinate (m)');  % 添加高度坐标标签








