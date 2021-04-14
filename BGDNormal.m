% Farinaz Fallahpour
% Date: 2011 
% https://github.com/FarinazFallahpour

%D.b Batch Gradient Descent Normal
function [Teta,y] = BGDNormal(Dataset,Alpha) 
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
X=[ones(NOofSample, 1), X]; % add a column of ones to X
Teta=zeros(NOofFeature,1); % parameters matrix
Y=Y*ones(1,NOofFeature); % set dimension
for iteration=1:1500
    HTeta=X*Teta;
    HTeta=HTeta*ones(1,NOofFeature); % set dimension
    Error=HTeta-Y;
    Teta=Teta-Alpha*(1/NOofSample)*(sum(Error.*X))'; % Calculate teta
    Teta_mat(:,iteration) = Teta;
end
y=X*Teta; % estimated line
X(:,1)=[]; % delete column 1
 end
