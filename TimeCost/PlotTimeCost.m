%% 横坐标： 无人机终端数量
user_num             =  [5;10;15;20];

%% 纵坐标： 各类算法的时间开销
time_cost_BLQoE  = readmatrix('D:\simulation\TimeCost\TimeCost.xlsx','Sheet','Timecost', 'Range','1:1');
time_cost_AHPSAW = readmatrix('D:\simulation\TimeCost\TimeCost.xlsx','Sheet','Timecost', 'Range','2:2');
time_cost_GRA = readmatrix('D:\simulation\TimeCost\TimeCost.xlsx','Sheet','Timecost', 'Range','3:3');
time_cost_M = readmatrix('D:\simulation\TimeCost\TimeCost.xlsx','Sheet','Timecost', 'Range','4:4');

plot(user_num,time_cost_BLQoE, '--or','LineWidth',1,'DisplayName','\fontname{Times New Roman}BLQoE');hold on;
plot(user_num,time_cost_AHPSAW, '--sb','LineWidth',1,'DisplayName','\fontname{Times New Roman}AHPSAW'); hold on;
plot(user_num,time_cost_GRA, '--*g','LineWidth',1,'DisplayName','\fontname{Times New Roman}GRA'); hold on;
plot(user_num,time_cost_M,  '--^m','LineWidth',1,'DisplayName','\fontname{Times New Roman}M'); hold on;

% grid on;
xlabel('\fontname{宋体}无人机终端数量(台)','FontSize',14);
ylabel('\fontname{宋体}时间开销\fontname{Times New Roman}(s)','FontSize',14);
hold off;
lgd = legend;
lgd.NumColumns = 1;
lgd.Location = 'NorthWest' ;
set(lgd ,'box','off')