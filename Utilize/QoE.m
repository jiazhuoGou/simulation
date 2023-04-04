function [ qoe ] = QoE(  )
%QOE 传入一个3个元素的行向量，计算出其qoe得分，其实也不需要传入，我直接给你生成一个
%   每列是时延，抖动率，丢包
    DeR=[15;16;17;11];   DeI=[10;9;8;8]; % 时延
    JiR=[1;1;1;1];      JiI=[5;5;5;5];  % 抖动
    PLR=[5;5;5;5];      PLI=[5;5;5;5];  % 丢包
    K=length(DeR);%维度
   
    dwde=DeR+DeI.*rand(K,1);
    dwjit=JiR+JiI.*rand(K,1);
    dwpac=PLR+PLI.*rand(K,1);
    
    A=[dwde; dwjit; dwpac];%建立静态决策矩阵
    [rows, cols]=size(A);
    
    %属性的规范化，因为他们都是及小型数据，越小越好
    total = zeros(1,3);  
    for j = 1 : cols
           a = getMax(A(:,j));
           A(:,j) = a - A(:,j);
           total(j) = sum(A(:,j)) / 3;
     end
      qoe = total(1) * 0.4 + total(2) * 0.3 + total(3) * 0.3;
    
end

    function [max] = getMax(array)
    rows = size(array, 1);
    max = 0;
    for i = 1 : rows
        if max < array(i)
            max = array(i);
        end
    end


end

