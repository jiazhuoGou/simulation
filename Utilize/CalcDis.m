function [ dis ] = CalcDis( i, j )
%CALC_DIS 此处显示有关此函数的摘要
%   此处显示详细说明
dis =  sqrt( power(abs(i(1) - j(1)),2) + power(abs(i(2) - j(2)),2) +  ... 
    power(abs(i(3) - j(3)),2) );
end

