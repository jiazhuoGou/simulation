
InfoBs;
InfoUAV
InfoData;

UAV = readmatrix('D:\simulation\data\InfoUAV.xlsx','Sheet','InfoUAVSheet');
BS = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');


S = 50;
axis ( [0,2000, 0, 2000,  0, 100]);
%% 首先画基站
bs = BS(:,1:3);
scatter3(bs(:,1), bs(:,2), bs(:,3), S, "red", 'o',  "filled");hold on;   % 用正方形表示节点   

%% 所有无人机
Uav= UAV(:,1:3);
scatter3(Uav(:,1), Uav(:,2), Uav(:,3), S, 'o',  'blue', 'filled');hold on; 



axis([0 2000 0 2000 0 120]);

title('无人机与基站分布图');  % 添加标题
xlabel('X coordinate (m)');  % 添加横坐标标签
ylabel('Y coordinate (m)');  % 添加纵坐标标签
zlabel('Z coordinate (m)');  % 添加高度坐标标签




