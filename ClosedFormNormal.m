% Farinaz Fallahpour
% Date: 2011 
% https://github.com/FarinazFallahpour

%D.a Closed-form Normal
function [Teta,y] = ClosedFormNormal(Dataset) 
clc;
NOofSample=size(Dataset,1); % # of training sample
NOofFeature=size(Dataset,2); % # of feature
MinDs=min(Dataset);
MaxDs=max(Dataset);
MinDs_v=ones(NOofSample,1)*MinDs;
MaxDs_v=ones(NOofSample,1)*MaxDs;
DsNormal=(Dataset-MinDs_v)./(MaxDs_v-MinDs_v);
Y=DsNormal(:,NOofFeature);
X=DsNormal(:,1:NOofFeature-1);
X=[ones(NOofSample, 1), X]; % add a column of ones to x
Teta=(inv((X'*X)))*(X'*Y); % Calculate teta
y=X*Teta; % estimated line
X(:,1)=[]; % delete column 1
 end
