%% �����꣺ ���˻��ն�����
user_num             =  [5;10;15;20];

%% �����꣺ �����㷨��ʱ�俪��
time_cost_BLQoE  = readmatrix('D:\simulation\TimeCost\TimeCost.xlsx','Sheet','Timecost', 'Range','1:1');
time_cost_AHPSAW = readmatrix('D:\simulation\TimeCost\TimeCost.xlsx','Sheet','Timecost', 'Range','2:2');
time_cost_GRA = readmatrix('D:\simulation\TimeCost\TimeCost.xlsx','Sheet','Timecost', 'Range','3:3');
time_cost_M = readmatrix('D:\simulation\TimeCost\TimeCost.xlsx','Sheet','Timecost', 'Range','4:4');

plot(user_num,time_cost_BLQoE, '--or','LineWidth',1,'DisplayName','\fontname{Times New Roman}BLQoE');hold on;
plot(user_num,time_cost_AHPSAW, '--sb','LineWidth',1,'DisplayName','\fontname{Times New Roman}AHPSAW'); hold on;
plot(user_num,time_cost_GRA, '--*g','LineWidth',1,'DisplayName','\fontname{Times New Roman}GRA'); hold on;
plot(user_num,time_cost_M,  '--^m','LineWidth',1,'DisplayName','\fontname{Times New Roman}M'); hold on;

% grid on;
xlabel('\fontname{����}���˻��ն�����(̨)','FontSize',14);
ylabel('\fontname{����}ʱ�俪��\fontname{Times New Roman}(s)','FontSize',14);
hold off;
lgd = legend;
lgd.NumColumns = 1;
lgd.Location = 'NorthWest' ;
set(lgd ,'box','off')