% Farinaz Fallahpour
% Date: 2011 
% https://github.com/FarinazFallahpour

%A.c Batch Gradient Descent
function [Teta,y] = BGD(Dataset,Alpha) 
clc;
NOofSampel=size(Dataset,1); % # of training sample
NOofFeature=size(Dataset,2); % # of feature
Y=Dataset(:,NOofFeature);
X=Dataset(:,1:NOofFeature-1);
X=[ones(NOofSampel, 1), X]; % add a column of ones to X
Teta=zeros(NOofFeature,1); % parameters matrix
%Alpha=0.0000001;
Y=Y*ones(1,NOofFeature); % set dimension
for iteration=1:1500
    HTeta=X*Teta;
    HTeta=HTeta*ones(1,NOofFeature); % set dimension
    Error=HTeta-Y;
    Teta=Teta-Alpha*(1/NOofSampel)*(sum(Error.*X))'; % Calculate teta
    Teta_mat(:,iteration) = Teta;
end
y=X*Teta; % estimated line
X(:,1)=[]; % delete column 1
 end
