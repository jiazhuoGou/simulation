function [qos] = QoS(  )
% QoS
%   每列是时延，抖动率，丢包，带宽
DeR=[15;16;17;11];   DeI=[10;9;8;8]; % 时延
JiR=[1;1;1;1];       JiI=[5;5;5;5];  % 抖动
PLR=[5;5;5;5];       PLI=[5;5;5;5];  % 丢包
BWR=[2;1;5;3];       BWI=[1;1;1;1];
K=length(DeR);%维度

dwde=DeR+DeI.*rand(K,1);
dwjit=JiR+JiI.*rand(K,1);
dwpac=PLR+PLI.*rand(K,1);
dwbw=BWR+BWI.*rand(K,1);

A=[dwde,dwjit,dwpac,dwbw];%建立静态决策矩阵

MAX=max(A);
MIN=min(A);
[m1,n1]=size(A);
B=zeros(size(A));

qos = [min(A(:,1:3)) max(A(:,4))];


%{
%属性的规范化 B是哪个决策矩阵
for i=1:m1
    for j=1:n1
        if(j==4)
            B(i,j)=((A(i,j)-MIN(j))/(MAX(j)-MIN(j)));
        else
            B(i,j)=((MAX(j)-A(i,j))/(MAX(j)-MIN(j)));
        end
    end
end
%}

%属性的规范化，因为他们都是及小型数据，越小越好
% total = zeros(1,3);
% for j = 1 : cols
%     a = getMax(A(:,j));
%     A(:,j) = a - A(:,j);
%     total(j) = sum(A(:,j)) / 3;
% end
% qoS = total(1) * 0.4 + total(2) * 0.3 + total(3) * 0.3;
% 
% end




end

