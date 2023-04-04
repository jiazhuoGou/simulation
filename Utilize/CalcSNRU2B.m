function [ SNRU2B ] = CalcSNRU2B( uav, base )
%CALCSNRU2B �˴���ʾ�йش˺�����ժҪ
%   ���������

    recv = CalcRecvPowerU2B(uav, base); % ��λ��dBm
    
    sigma = -96;%-96dBm�������������������
    I =  abs(normrnd(1.5,sqrt(0.5)));     %%ģ������ź�ǿ��(dBm)
    
    SNRU2B_db = recv - (sigma) - I; % dBm - dBm�õ����Ƿֱ� ����ĵ�λ�Ƿֱ�,����P�ĵ�λ�õ�dBm������w���������ü������ǳ���
    SNRU2B_ratio = power(10, SNRU2B_db / 10);
    SNRU2B = [SNRU2B_db, SNRU2B_ratio];    % ��һ�зֱ����ڶ��дӷֱ�ת��Ϊ��ֵ
    
%{ 
    ����Ҫ��� ��һ�����������������һ����������ʱ����
    PU = uav(4); 
    dis = CalcDis(uav, base);
    B = uav(6) * 1e6; % HZ
    beta = -2.3;
    N0 = -110; % dBm
    
    % �Ӿ�����Ӿ����
    angle = asin( (uav(3) - base(3)) / dis);  % ���ǻ���
    angle = angle * (180 / pi); % Ҫ�õ��Ƕ�
    D = -0.16;
    C = 8.97;
    P_Los = 1 / ( 1 + C * exp(D * (angle-C))  );
    P_NLos = 1 - P_Los;
    MU_Los = 0.1;
    MU_NLos = 21; 
    KI = P_Los * MU_Los + P_NLos * MU_NLos;
    %SNRU2B = (PU * power(dis, beta)) / (N0 * B * KI); 
%}
end

