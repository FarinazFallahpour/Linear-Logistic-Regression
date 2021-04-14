% Farinaz Fallahpour
% Date: 2011 
% https://github.com/FarinazFallahpour

%A.b Stochastic Gradient Descent
function [Teta,y] = SGD(Dataset) 
clc;
NOofFeature=size(Dataset,2); % # of feature
NOofSampel=size(Dataset,1); % # of training sample
Y=Dataset(:,NOofFeature);
X=Dataset(:,1:NOofFeature-1);
X=[ones(NOofSampel, 1), X]; % add a column of ones to x
Teta=zeros(NOofFeature,1); % parameters matrix
Alpha=0.01;
NOofIteration=1500;
%Teta_mat=zeros(NOofSampel,NOofIteration,NOofFeature);
for iteration = 1:NOofIteration
	for i=1:NOofSampel
		HTetai = (X(i,:)*Teta);
		HTeta = HTetai*ones(1,NOofFeature);
		Yi = Y(i,:)*ones(1,NOofFeature);
		Teta = Teta - Alpha*1/NOofSampel*((HTeta - Yi).*X(i,:)).';
		%Teta_mat(NOofSampel*(iteration-1)+i,:) = Teta;
    end
    Teta=Teta;
end
y=X*Teta;
end