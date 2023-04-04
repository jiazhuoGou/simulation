%% ================================���˻���Ϣ=========================================

%% ================================���˻���Ϣ=========================================
%  ���˻���ʼλ�óʾ���������ֲ����߶�һ��
%  ���˻����ò������£�
%  ���˻�������   (��) 
%  ���书�ʣ�      dB          ��4�� 
%  ��Դ��ʣ����������Ϊ50��ÿ����Դ�����2k,���Խ���һ�����˻���20����         (m/s)        ��5��
%  ����          MHZ         ��6��
%  ��ţ�                      ��8��
%  �Ƿ�������                  ��7��  >1����Ĵ�ͷ��0�س�Ա��-1δ������ ��ʼ��Ϊ0
%  ����                      ��9�� 

UAV_NUM = 20;   
UAV_PU = 23;
UAV_B = 2;  
UAV_AVALIABLE = 40; 

%% ���˻�����
UAV_X = [];
UAV_Y = [];
UAV_Z = [];
UAV = [];

%������һ�ŵ����˻�6��
x = linspace(50,1950,6);
y = unifrnd(500,750,6,1)';
UAV_X = [UAV_X, x];
UAV_Y = [UAV_Y, y];

%������һ�ŵ����˻�6��
x = linspace(50,1950,6);
y = unifrnd(1250,1500,6,1)';
UAV_X = [UAV_X, x];
UAV_Y = [UAV_Y, y];

% ���һ�е����˻�4��
x = unifrnd(750,900,4,1)';
y = linspace(50,1950,4);
UAV_X = [UAV_X, x];
UAV_Y = [UAV_Y, y];

% �ұ�һ�е����˻�4��
x = unifrnd(1200,1350,4,1)';
y = linspace(50,1950,4);
UAV_X = [UAV_X, x];
UAV_Y = [UAV_Y, y];

UAV = horzcat(UAV_X', UAV_Y');

% ����Z��
UAV_Z = unifrnd(50,100,20,1);
UAV = horzcat(UAV, UAV_Z);

%% ���˻����书�� 4
PU_UAVs = repelem(UAV_PU,UAV_NUM)'; %�Ӹ�������ת��
UAV = horzcat(UAV, PU_UAVs);

%% ���˻���Դ 5
SPEED_UAVs = repelem(UAV_AVALIABLE, UAV_NUM)';
UAV = horzcat(UAV, SPEED_UAVs);

%% ���˻����� 6
B_UAVs = repelem(UAV_B, UAV_NUM)';
UAV = horzcat(UAV, B_UAVs);

%% ������־ 7
Cluster_UAVs = linspace(0, 0, 20)';
UAV = horzcat(UAV, Cluster_UAVs);

%% ���˻���� 8
%ID_UAVs = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]';
ID_UAVs  = (101:1:120)';
UAV = horzcat(UAV, ID_UAVs);

%% ���˻��ƶ�����,����
Deriction_UAVs = randi([0,3],UAV_NUM,1); % �����4��ǰ������(0-3)
UAV = horzcat(UAV, Deriction_UAVs);


writematrix(UAV, 'D:\simulation\data\InfoUAV.xlsx', 'Sheet', 'InfoUAVSheet')




























%xlswrite('D:\simulation\data\InfoUAV.xlsx',BS,'��վ��Ϣ'); 