%% ================================��վ��Ϣ========================================= 
%  ģ��һ�γ�2000m����2000m�ĳ�������  �����ڲ�����2�����վ��20��΢��վ��20��WLAN
%  ��վ����Ϊ���շ������Ժܶ�����ò�����
%  ���������������ò������£�
%  ��վ������        ������
%  ���ǰ뾶��        ��m�� Ӧ�����ڿռ���İ뾶 ��4��
%  ��Դ��������        ��KHZ��                   ��5��
%  ��Դ������ ��      ������                   ��6��
%  ��Դ��ʣ������      ������                 ��7��
%  ��վid��                                    ��8��      
%  ռλ��                                  ȫ0���ھ���

%%  5G ���վ
T5GM_NUM    = 2;
R_5GM       =   1200;
B_5GM       =   2;
Tprb_5GM    =   100;   
Available_5GM = Tprb_5GM * 0.5;
ID_5GM = (1:1:2)';


X_5GM       =  [500,1750]';
Y_5GM       =  [1750,600]';
Z_5GM       = repelem(0, T5GM_NUM)';
R_5GM       = repelem(R_5GM, T5GM_NUM)';        % ���վ�İ뾶 
B_5GM       = repelem(B_5GM, T5GM_NUM)';        % ���վ�Ĵ���
Tprb_5GM    = repelem(Tprb_5GM, T5GM_NUM)';     % ����ܵ���Դ������
Available_5GM = repelem(Available_5GM, T5GM_NUM)';  % ������Դ��
HOLDER_5GM = repelem(0, T5GM_NUM)';

%%  5G ΢��վ
T5GS_NUM    =   20;
R_5GS       =   300;
B_5GS       =   2;
Tprb_5GS    =   75;
Available_5GS = Tprb_5GS * 0.6;
ID_5GS = (3:1:22)';
 
X_5GS       =  [300, 650, 340, 620, 260, 700, 750, 900, 820, 1300, 860, 1160, 1550, 1720, 1460, 1900, 1750, 1680, 1900, 430]';
Y_5GS       =  [350, 560, 1150, 1050, 1450, 1800, 260, 490, 1000, 1100, 1640, 1950, 660, 555, 1240, 480, 1360, 1600, 570, 720]';
Z_5GS       = repelem(0, T5GS_NUM)';
R_5GS       = repelem(R_5GS,T5GS_NUM )';        % ΢��վ�İ뾶 
B_5GS       = repelem(B_5GS,T5GS_NUM )';        % ΢��վ�Ĵ���
Tprb_5GS    = repelem(Tprb_5GS,T5GS_NUM )';     % ΢��վ����Դ������ 
Available_5GS = repelem(Available_5GS, T5GS_NUM)';  % ������Դ��
HOLDER_5GS = repelem(0, T5GS_NUM)';

%%  5G WLAN
TWLAN_NUM   = 20;
R_WLAN       =   200;
B_WLAN       =   2;
Tprb_WLAN    =   50;
Available_WLAN = Tprb_WLAN  * 0.8;
ID_WLAN = (23:1:42)'; 

X_WLAN      =  [1150,300,500,600,800,900,1000,1200,1300,1400,1500,1700,1800,200,730,400,1600,1800,1900,2000]';
Y_WLAN      =  [1350,1590,19200,680,340,490,880,1280,1540,360,940,760,1650,1780,1860,270,1060,990,690,1830]';
Z_WLAN       = repelem(0, TWLAN_NUM)';
R_WLAN      = repelem(R_WLAN,TWLAN_NUM )';        % ���߾������İ뾶 
B_WLAN      = repelem(B_WLAN,TWLAN_NUM )';        % ���߾������Ĵ���
Tprb_WLAN   = repelem(Tprb_WLAN,TWLAN_NUM )';     % ���߾���������Դ������ 
Available_WLAN = repelem(Available_WLAN, T5GS_NUM)';    % ������Դ��
HOLDER_WLAN = repelem(0, TWLAN_NUM)';

%% ���������ڵĻ�վ
Z_TOTAL = repelem(0, 42)';
M_5G  = [X_5GM, Y_5GM, Z_5GM, R_5GM, B_5GM, Tprb_5GM, Available_5GM, ID_5GM, HOLDER_5GM];
S_5G  = [X_5GS, Y_5GS, Z_5GS, R_5GS, B_5GS, Tprb_5GS, Available_5GS, ID_5GS, HOLDER_5GS];
WLAN  = [X_WLAN, Y_WLAN, Z_WLAN, R_WLAN, B_WLAN, Tprb_WLAN, Available_WLAN, ID_WLAN, HOLDER_WLAN];
BS = [M_5G;S_5G;WLAN];  
writematrix(BS, 'D:\simulation\data\InfoBs.xlsx', Sheet='InfoBsSheet');  








