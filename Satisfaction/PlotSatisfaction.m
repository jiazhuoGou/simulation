%% 横坐标： 无人机终端数量
user_num             =  [5;10;15;20];

%% 纵坐标： 各类算法的z满意度
Satisfiaction_BLQoE  = readmatrix('D:\simulation\Satisfaction\Satisfaction.xlsx','Sheet','Satisfaction','Range','1:1');
Satisfiaction_AHPSAW = readmatrix('D:\simulation\Satisfaction\Satisfaction.xlsx','Sheet','Satisfaction','Range','2:2');
Satisfiaction_GRA = readmatrix('D:\simulation\Satisfaction\Satisfaction.xlsx','Sheet','Satisfaction', 'Range','3:3');
Satisfiaction_RSR = readmatrix('D:\simulation\Satisfaction\Satisfaction.xlsx','Sheet','Satisfaction', 'Range','4:4');

plot(user_num,Satisfiaction_BLQoE, '--or','LineWidth',1,'DisplayName','\fontname{Times New Roman}BLQoE');hold on;
plot(user_num,Satisfiaction_AHPSAW, '--sb','LineWidth',1,'DisplayName','\fontname{Times New Roman}AHPSAW'); hold on;
plot(user_num,Satisfiaction_GRA, '--*g','LineWidth',1,'DisplayName','\fontname{Times New Roman}GRA'); hold on;
plot(user_num,Satisfiaction_RSR,  '--^m','LineWidth',1,'DisplayName','\fontname{Times New Roman}RSR'); hold on;

% grid on;
xlabel('\fontname{宋体}无人机终端数量(台)','FontSize',14);
ylabel('\fontname{宋体}吞吐量\fontname{Times New Roman}(Mbps)','FontSize',14);
hold off;
lgd = legend;
lgd.NumColumns = 1;
lgd.Location = 'NorthWest' ;
set(lgd ,'box','off')