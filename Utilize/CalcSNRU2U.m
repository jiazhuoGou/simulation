function [ SNRU2U ] = CalcSNRU2U( uav1, uav2 )
%CALCSNRU2U �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%{
    sigma = -96;%-96dBm�������������������
    %sigma2 = power(10, sigma / 10);
    Inter=  - 135 + normrnd(0,sqrt(10));     %%�����ź�ǿ��(dBm)
    recv = CalcRecvPowerU2U(uav1, uav2);
    SNRU2U = recv / (sigma+Inter);
    %SNRU2U = power(10, SNRU2U / 10); 
%}  
%{
    %����Ҫ��� ��һ�����������������һ����������ʱ����
    PU = uav1(4); 
    dis = CalcDis(uav1, uav2);
    B = uav1(6) * 1e6; % HZ
    beta = 2.2;
    N0 = -110; % dBm
    
    % �Ӿ�����Ӿ����
    angle = asin( (uav1(3) - uav2(3)) / dis);  % ���ǻ���
    disp(angle * (180 / pi))
    %angle = angle * (180 / pi); % Ҫ�õ��Ƕ�
    D = 0.16;
    C = 8.97;
    P_Los = 1 / ( 1 + C * exp( (-D) * (angle-C))  );
    P_NLos = 1 - P_Los;
    MU_Los = 0.1;
    MU_NLos = 21; 
    KI = P_Los * MU_Los + P_NLos * MU_NLos;
    SNRU2U = (PU * power(dis, -beta)) / (N0 * B * KI); 
%}  

    % ���öԳ���·��������
    sigma = -96;
    PU = uav1(4);
    dis = CalcDis(uav1, uav2);
    f = 2e9;
    c = 3e8;
    alpha = 2.03;
    G = -31.5;
    %{ 
    54-56 ������
    
    PL = 10 * alpha * log10(dis);
    %}
    
    %% 57������
    %recv = PU + 10 +10 * log10( (c / (4 * pi * dis * f)^alpha) ); % dB��λ �ų�
    %recv = PU - recv;%recv = 23 / power(10, recv / 10);
    %recv = (PU ) * power(10, -alpha);
    
    %% 59������ ��ʱ���ֻ�����
    PL_d0 = 46.4;
    PL =PL_d0 + 10 * alpha * log10(dis);
    small_fading = abs(normrnd(5,sqrt(1)));
    recv = PU - PL - small_fading;
    
    
    %% ���������
    %{
    recv = PU * power(dis, alpha);
    
    SNRU2U = recv / sigma;
    
    %SNRU2U = recv - sigma;
    %G = -31.5;
    %SNRU2U = (PU - PL) - sigma;
    %SNRU2U = power(10, SNRU2U / 10);
    %}
    I =  abs(normrnd(0.5,sqrt(0.5)));     %%ģ������ź�ǿ��(dBm)
    SNRU2U_db = recv - sigma - I; % �������ģ�����
    SNRU2U_ratio = power(10, SNRU2U_db / 10);
    SNRU2U = [SNRU2U_db, SNRU2U_ratio]; % ��һ��ʹ�ֱ����ڶ����Ǳ�ֵ
    
end

