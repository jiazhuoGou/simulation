function [ RateU2U ] = CalcRate(  snr_ratio )
%CALCRATEU2U 此处显示有关此函数的摘要
%   此处显示详细说明
    B = 2; % 单位是Mhz
    
    
    RateU2U = B * log2(1 + snr_ratio); % mbps

end

