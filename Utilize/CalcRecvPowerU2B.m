function [ RecvPowerU2B ] = CalcRecvPowerU2B( uav, base )
%CALCRECVPOWER 计算无人机到基站的基站接收功率
%   uav, base都是向量
    PU = uav(4);    % 无人机发射功率dBm
    
    
    avg = CalcPLAvgU2B(uav, base); % 路径损耗
    
    RecvPowerU2B = PU - avg; % 不要去除，就是用减法，因为avg单位是dB
    %RecvPowerU2B = PU / (power(10, avg / 10));
    
    
    
    
    
    
end

