% Farinaz Fallahpour
% Date: 2011 
% https://github.com/FarinazFallahpour

% A_7) To understand the cost function better, plot JTeta in terms of Teta0and Teta1. (Note: generate
%      a grid of Teta0=[-1 4] and Tata1=[-10 10]) and plot the cost function, J(Teta0,Teta1), using
%      surf command).
function JTetaInTermsOfTeta(Dataset)
clc;
NOofFeature=size(Dataset,2); % # of feature
NOofSampel=size(Dataset,1); % # of training sample
Y=Dataset(:,NOofFeature);
X=Dataset(:,1:NOofFeature-1);
X=[ones(NOofSampel, 1), X]; % add a column of ones to x
% grid of Teta
Teta0=linspace(-1,1,4);
Teta1=linspace(-10,1,10);
J=zeros(length(Teta0),length(Teta1));
for i=1:length(Teta0)
	  for j=1:length(Teta1)
	  T=[Teta0(i);Teta1(j)];    
	  J(i,j)=(0.5/NOofSampel).*(X*T-Y)'*(X*T-Y); % Calculate JTeta
    end
end
J=J';
% Surf
figure;
surf(Teta0,Teta1,J)
xlabel('Teta0'); 
ylabel('Teta1');
title('J Teta in terms of Teta');
end