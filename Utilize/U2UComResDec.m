function [ link_quality ] = U2UComResDec( uav1, uav2 )
%U2UCOMRESDEC 无人机到无人机的链路质量
%   返回的是得分
    snr = CalcSNRU2U(uav1, uav2);
    rate = CalcRate( snr(2));
        
    link_quality = CalcLinkQuality( snr(1), rate);  % 第一列是速率，第二列是误包率
    
end

