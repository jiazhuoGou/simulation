DeR=[15;16;17;11];   DeI=[7;8;9;10]; % 时延
    JiR=[1;1;1;1];      JiI=[3;4;5;6];  % 抖动
    PLR=[5;5;5;5];      PLI=[2;3;4;5];  % 丢包
    K=length(DeR);%维度
   
    dwde=DeR+DeI.*rand(K,1);
    dwjit=JiR+JiI.*rand(K,1);
    dwpac=PLR+PLI.*rand(K,1);
    
    A=[dwde';dwjit';dwpac'];%建立静态决策矩阵
    j = 1;
    disp(A(:,j));

    [rows, cols]=size(A);
    
    %属性的规范化，因为他们都是及小型数据，越小越好
      for j = 1 : cols
           a = max(A(:,j));
           A(:,j) = a - A(:,j);
      end
    % 规范化
%     for j = 1:size(A, cols)
%             A(:,j) = A(:,j) ./ sqrt(sum(A(:,j).^2));
%     end

function [max] = getMax(array)
    rows = size(array, 1);
    max = 0;
    for i = 1 : rows
        if max < array(i)
            max = array(i);
        end
    end
end
    
    

 
 
 
