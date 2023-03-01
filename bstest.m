%% ================================基站信息========================================= 
%  模拟一段长3000m，宽30m的双向四车道路边部署了2个宏基站，20个微基站，20个WLAN
%  假设各个网络的配置参数如下：
%  发射功率：    （dB）
%  路径损耗：    （dB）
%  覆盖半径:     （m）
%  分配带宽：    （MHZ）
%  网络成本：    （元/块）
%  资源块数量    （个）

%%  5G 宏基站
PW_5GM      =   32;               
PL_5GM      =   46;
R_5GM       =   1200;
B_5GM       =   20;
C_5GM       =   0.1;
Tprb_5GM    =   10000;   
 
T5GM_Num    = 2;
X_5GM       =  [1000,2000]';
Y_5GM       =  [400,600]';
PW_5GM      = repelem(PW_5GM,T5GM_Num )';       % 微基站的发射功率
PL_5GM      = repelem(PL_5GM,T5GM_Num )';       % 微基站的路径损耗
R_5GM       = repelem(R_5GM,T5GM_Num )';        % 微基站的半径 
B_5GM       = repelem(B_5GM,T5GM_Num )';        % 微基站的带宽
C_5GM       = repelem(C_5GM,T5GM_Num )';        % 微基站的成本
Tprb_5GM    = repelem(Tprb_5GM,T5GM_Num )';     % 总的资源块数量 

%%  5G 微基站
PW_5GS      =   23;               
PL_5GS      =   56;
R_5GS       =   300;
B_5GS       =   15;
C_5GS       =   0.3;
Tprb_5GS    =   7500;   
 
T5GS_Num    = 20;
X_5GS       =  [150,350,550,650,800,950,1050,1100,1250,1400,1550,1700,1850,2000,2150,2300,2450,2600,2750,2800]';
Y_5GS       =  [480,540,550,470,560,420,460,550,545,565,543,460,455,480,560,430,570,480,490,555]';
PW_5GS      = repelem(PW_5GS,T5GS_Num )';       % 微基站的发射功率
PL_5GS      = repelem(PL_5GS,T5GS_Num )';       % 微基站的路径损耗
R_5GS       = repelem(R_5GS,T5GS_Num )';        % 微基站的半径 
B_5GS       = repelem(B_5GS,T5GS_Num )';        % 微基站的带宽
C_5GS       = repelem(C_5GS,T5GS_Num )';        % 微基站的成本
Tprb_5GS    = repelem(Tprb_5GS,T5GS_Num )';     % 总的资源块数量 

%%  5G WLAN
PW_WLAN      =   17;               
PL_WLAN      =   58;
R_WLAN       =   200;
B_WLAN       =   10;
C_WLAN       =   0.2;
Tprb_WLAN    =   5000;   
 
TWLAN_Num   = 20;
X_WLAN      =  [100,300,500,600,800,900,1000,1200,1300,1400,1500,1700,1800,2000,2100,2300,2400,2600,2700,2800]';
Y_WLAN      =  [470,550,450,480,540,490,480,580,540,560,540,560,450,580,460,470,560,490,490,550]';
PW_WLAN     = repelem(PW_WLAN,TWLAN_Num )';       % 微基站的发射功率
PL_WLAN     = repelem(PL_WLAN,TWLAN_Num )';       % 微基站的路径损耗
R_WLAN      = repelem(R_WLAN,TWLAN_Num )';        % 微基站的半径 
B_WLAN      = repelem(B_WLAN,TWLAN_Num )';        % 微基站的带宽
C_WLAN      = repelem(C_WLAN,TWLAN_Num )';        % 微基站的成本
Tprb_WLAN   = repelem(Tprb_WLAN,TWLAN_Num )';     % 总的资源块数量 



%%  Ad hoc车载无线收发装置
% 发射功率（dB）和路径损耗（dB）、覆盖半径（m）、分配的带宽（MHz)、成本（元/块）
PW_Adhoc          = 17;                        
PL_Adhoc          = 58;                     
R_Adhoc           = 100;                          
B_Adhoc           = 4;                                           
C_Adhoc           = 0.0001;                       
Tprb_Adhoc        = 2000;

TAdhoc_Num        = 30;
X_Adhoc           =  [100,200,300,400,500,600,700,820,900,990,...
                      1100,120,1300,1400,1500,160,1700,180,1900,2000,...
                      2100,2200,2300,2400,2500,2600,2700,2800,2850,2900]';
Y_Adhoc           =  [450,560,450,480,540,490,480,588,540,561,...
                      470,570,440,450,540,480,490,560,546,563,...                     
                      470,550,480,480,540,490,480,580,540,560]';
PW_Adhoc          = repelem(PW_Adhoc,TAdhoc_Num )';       % 微基站的发射功率
PL_Adhoc          = repelem(PL_Adhoc,TAdhoc_Num )';       % 微基站的路径损耗
R_Adhoc           = repelem(R_Adhoc,TAdhoc_Num )';        % 微基站的半径 
B_Adhoc           = repelem(B_Adhoc,TAdhoc_Num )';        % 微基站的带宽
C_Adhoc           = repelem(C_Adhoc,TAdhoc_Num )';        % 微基站的成本
Tprb_Adhoc        = repelem(Tprb_Adhoc,TAdhoc_Num )';     % 总的资源块数量 


M_5G  = [X_5GM,Y_5GM,PW_5GM,PL_5GM,R_5GM,B_5GM,C_5GM,Tprb_5GM];
S_5G  = [X_5GS,Y_5GS,PW_5GS,PL_5GS,R_5GS,B_5GS,C_5GS,Tprb_5GS];
WLAN  = [X_WLAN,Y_WLAN,PW_WLAN,PL_WLAN,R_WLAN,B_WLAN,C_WLAN,Tprb_WLAN];
Adhoc = [X_Adhoc,Y_Adhoc,PW_Adhoc,PL_Adhoc,R_Adhoc,B_Adhoc,C_Adhoc,Tprb_Adhoc];


BS = [M_5G;S_5G;WLAN;Adhoc];  
xlswrite('E:\Data\matlab\lun1\class_load_balance\Info_Bs.xlsx',BS,'基站信息'); 