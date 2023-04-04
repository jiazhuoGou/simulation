function [ score] = U2BComResDec( uav )
%UNTITLED 计算无人机的到基站的通信资源，返回一个向量，让需要的人自己去用熵权法确定权重
%   uav : 需要检测的无人机
%   Res： 通信资源评分（0-1）
    
    BS = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
    
    
    %% 首先判断该无人机与哪些基站关联
    [bs_num, ~] = size(BS);
    k = 1;
    link_quality = 0;
    for i = 1 : bs_num
        bs = BS(i, :);
        snr  = CalcSNRU2B(uav, bs);
        rate = CalcRate(snr(2));
        if snr(1) >= 10 || rate >= 1 % 关联 必须要多弄几个，不然熵权法确定权重要gg
            % 计算链路质量
            link_quality = CalcLinkQuality(snr(1), rate) + link_quality;
            k  = k + 1;
        end
    end
    
    % 用层次分析法好点，这样如果只有一行也可以处理
    score = link_quality / k;
   
end

