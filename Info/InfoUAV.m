%% ================================无人机信息=========================================

%% ================================无人机信息=========================================
%  无人机初始位置呈井字形随机分布，高度一致
%  无人机配置参数如下：
%  无人机数量：   (个) 
%  发射功率：      dB          第4列 
%  资源快剩余量，总量为50，每个资源快带宽2k,所以接入一个无人机少20个：         (m/s)        第5列
%  带宽：          MHZ         第6列
%  编号：                      第8列
%  是否组网：                  第7列  >1接入的簇头，0簇成员，-1未组网， 初始都为0
%  方向：                      第9列 

UAV_NUM = 20;   
UAV_PU = 23;
UAV_B = 2;  
UAV_AVALIABLE = 40; 

%% 无人机坐标
UAV_X = [];
UAV_Y = [];
UAV_Z = [];
UAV = [];

%最下面一排的无人机6个
x = linspace(50,1950,6);
y = unifrnd(500,750,6,1)';
UAV_X = [UAV_X, x];
UAV_Y = [UAV_Y, y];

%最上面一排的无人机6个
x = linspace(50,1950,6);
y = unifrnd(1250,1500,6,1)';
UAV_X = [UAV_X, x];
UAV_Y = [UAV_Y, y];

% 左边一列的无人机4个
x = unifrnd(750,900,4,1)';
y = linspace(50,1950,4);
UAV_X = [UAV_X, x];
UAV_Y = [UAV_Y, y];

% 右边一列的无人机4个
x = unifrnd(1200,1350,4,1)';
y = linspace(50,1950,4);
UAV_X = [UAV_X, x];
UAV_Y = [UAV_Y, y];

UAV = horzcat(UAV_X', UAV_Y');

% 生成Z轴
UAV_Z = unifrnd(50,100,20,1);
UAV = horzcat(UAV, UAV_Z);

%% 无人机发射功率 4
PU_UAVs = repelem(UAV_PU,UAV_NUM)'; %加个单引号转置
UAV = horzcat(UAV, PU_UAVs);

%% 无人机资源 5
SPEED_UAVs = repelem(UAV_AVALIABLE, UAV_NUM)';
UAV = horzcat(UAV, SPEED_UAVs);

%% 无人机带宽 6
B_UAVs = repelem(UAV_B, UAV_NUM)';
UAV = horzcat(UAV, B_UAVs);

%% 组网标志 7
Cluster_UAVs = linspace(0, 0, 20)';
UAV = horzcat(UAV, Cluster_UAVs);

%% 无人机编号 8
%ID_UAVs = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]';
ID_UAVs  = (101:1:120)';
UAV = horzcat(UAV, ID_UAVs);

%% 无人机移动方向,待定
Deriction_UAVs = randi([0,3],UAV_NUM,1); % 方向就4个前后左右(0-3)
UAV = horzcat(UAV, Deriction_UAVs);


writematrix(UAV, 'D:\simulation\data\InfoUAV.xlsx', 'Sheet', 'InfoUAVSheet')




























%xlswrite('D:\simulation\data\InfoUAV.xlsx',BS,'基站信息'); 