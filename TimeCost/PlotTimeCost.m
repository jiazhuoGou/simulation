%% �����꣺ ���˻��ն�����
user_num             =  [5;10;15;20];

%% �����꣺ �����㷨��ʱ�俪��
time_cost_BLQoE  = readmatrix('D:\simulation\TimeCost\TimeCost.xlsx','Sheet','Timecost');

plot(user_num,time_cost_BLQoE, '--or','LineWidth',1,'DisplayName','\fontname{Times New Roman}BLQoE');


% grid on;
xlabel('\fontname{����}���˻��ն�����(̨)','FontSize',14);
ylabel('\fontname{����}ʱ�俪��\fontname{Times New Roman}(ms)','FontSize',14);
hold off;
lgd = legend;
lgd.NumColumns = 1;
lgd.Location = 'NorthWest' ;
set(lgd ,'box','off')