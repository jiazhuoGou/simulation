%% 横坐标： 无人机终端数量
user_num             =  [5;10;15;20];


%% 纵坐标： 各类算法的信令开销
SingalCost_BLQoE  = readmatrix('D:\simulation\SingalCost\SingalCosts.xlsx','Sheet','SingalCost', 'Range','1:1');
SingalCost_AHPSAW = readmatrix('D:\simulation\SingalCost\SingalCosts.xlsx','Sheet','SingalCost', 'Range','2:2');
SingalCost_GRA = readmatrix('D:\simulation\SingalCost\SingalCosts.xlsx','Sheet','SingalCost', 'Range','3:3');
SingalCost_RSR = readmatrix('D:\simulation\SingalCost\SingalCosts.xlsx','Sheet','SingalCost', 'Range','4:4');

plot(user_num,SingalCost_BLQoE, '--or','LineWidth',1,'DisplayName','\fontname{Times New Roman}BLQoE');hold on;
plot(user_num,SingalCost_AHPSAW, '--sb','LineWidth',1,'DisplayName','\fontname{Times New Roman}AHPSAW'); hold on;
plot(user_num,SingalCost_GRA, '--*g','LineWidth',1,'DisplayName','\fontname{Times New Roman}GRA'); hold on;
plot(user_num,SingalCost_RSR,  '--^m','LineWidth',1,'DisplayName','\fontname{Times New Roman}RSR'); hold on;

% grid on;
xlabel('\fontname{宋体}无人机终端数量(台)','FontSize',14);
ylabel('\fontname{宋体}信令开销占总资源消耗的比值\fontname{Times New Roman}(%)','FontSize',14);
hold off;
lgd = legend;
lgd.NumColumns = 1;
lgd.Location = 'NorthWest' ;
set(lgd ,'box','off')