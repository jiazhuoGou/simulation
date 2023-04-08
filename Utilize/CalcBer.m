function [ber] = CalcBer(uav, apid, UAV, BS)
    if apid < 100 % 基站
        rss = CalcRecvPowerU2B(uav, BS(apid, :));
    else % 无人机
        rss = CalcRecvPowerU2U(uav, UAV(apid-100, :));
    end
    ber = (1/sqrt(2*pi))*(-(2^(1/2)*pi^(1/2)*(erf((2^(1/2)*sqrt(rss+130+normrnd(0,10)))/2) - 1))/2) * 1e3;

end

