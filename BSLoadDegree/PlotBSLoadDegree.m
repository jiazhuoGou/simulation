%% 横坐标： 无人机终端数量
user_num             =  [2;4;6;8;10;12;14;16;18;20];
%BSLoadDegree_TOTAL  = readmatrix('D:\simulation\BSLoadDegree\BSLoadDegree.xlsx','Sheet','BSLoadDegree');
%BSLoadDegree_TOTAL = BSLoadDegree_TOTAL / 100;
%writematrix(BSLoadDegree_TOTAL,'D:\simulation\BSLoadDegree\BSLoadDegree.xlsx','Sheet','BSLoadDegree', 'WriteMode','replacefile');
%% 纵坐标： 各类算法的基站负载程度
BSLoadDegree_BLQoE  = readmatrix('D:\simulation\BSLoadDegree\BSLoadDegree.xlsx','Sheet','BSLoadDegree','Range','1:1');
BSLoadDegree_AHPSAW = readmatrix('D:\simulation\BSLoadDegree\BSLoadDegree.xlsx','Sheet','BSLoadDegree','Range','2:2');
BSLoadDegree_GRA = readmatrix('D:\simulation\BSLoadDegree\BSLoadDegree.xlsx','Sheet','BSLoadDegree', 'Range','3:3');
BSLoadDegree_RSR = readmatrix('D:\simulation\BSLoadDegree\BSLoadDegree.xlsx','Sheet','BSLoadDegree','Range','4:4');




plot(user_num,BSLoadDegree_BLQoE, '--or','LineWidth',1,'DisplayName','\fontname{Times New Roman}BLQoE');hold on;
plot(user_num,BSLoadDegree_AHPSAW, '--sb','LineWidth',1,'DisplayName','\fontname{Times New Roman}AHPSAW'); hold on;
plot(user_num,BSLoadDegree_GRA, '--*g','LineWidth',1,'DisplayName','\fontname{Times New Roman}GRA'); hold on;
plot(user_num,BSLoadDegree_RSR,  '--^m','LineWidth',1,'DisplayName','\fontname{Times New Roman}RSR'); hold on;

% grid on;
xlabel('\fontname{宋体}无人机终端数量(台)','FontSize',14);
ylabel('\fontname{宋体}基站负载程度\fontname{Times New Roman}(%)','FontSize',14);
hold off;
lgd = legend;
lgd.NumColumns = 1;
lgd.Location = 'NorthWest' ;
set(lgd ,'box','off')