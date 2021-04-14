% Farinaz Fallahpour
% Date: 2011 
% https://github.com/FarinazFallahpour

%A.a Closed-form
function [Teta,y] = ClosedForm(Dataset) 
clc;
NOofSampel=size(Dataset,1); % # of training sample
NOofFeature=size(Dataset,2); % # of feature
Y=Dataset(:,NOofFeature);
X=Dataset(:,1:NOofFeature-1);
X=[ones(NOofSampel, 1), X]; % add a column of ones to x
Teta=(inv((X'*X)))*(X'*Y); % Calculate teta
y=X*Teta; % estimated line
X(:,1)=[]; % delete column 1
 end
