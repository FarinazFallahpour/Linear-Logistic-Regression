% Farinaz Fallahpour
% Date: 2011 
% https://github.com/FarinazFallahpour

% A_6) Plot the cost function JT along the epochs (plot both online & batch methods on one
%figure using hold on command).
% C_2) Plot the cost function JTeta along the epochs for Gradient descent method.
function [J_Theta_Batch,J_Theta_Stoch,Iteration]=J_Teta(Dataset,AlphaB,AlphaS)
clc;
close all;
NOofFeature=size(Dataset,2); % # of feature
NOofSampel=size(Dataset,1); % # of training sample
Y=Dataset(:,NOofFeature);
X=Dataset(:,1:NOofFeature-1);
X=[ones(NOofSampel, 1), X]; % add a column of ones to x
Teta=zeros(NOofFeature,1); % parameters matrix
TetaB=zeros(NOofFeature,1);
%Alpha=0.01;
NOofIteration=1500;
for iteration = 1:NOofIteration
    % batch
    HTetaB = (X*TetaB);
	HTetaj = HTetaB*ones(1,NOofFeature);
	YB = Y*ones(1,NOofFeature);
	TetaB = TetaB - AlphaB*1/NOofSampel*sum((HTetaj - YB).*X).';
	J_Theta_Batch(iteration) = 1/(2*NOofSampel)*sum((HTetaB - Y).^2); % Calculate cost function
    
    %stochastic
	for i=1:NOofSampel
		HTetai = (X(i,:)*Teta);
		HTeta = HTetai*ones(1,NOofFeature);
		Yi = Y(i,:)*ones(1,NOofFeature);
		Teta = Teta - AlphaS*1/NOofSampel*((HTeta - Yi).*X(i,:)).';
    end
    J_Theta_Stoch(iteration) = 1/(2*NOofSampel)*sum((HTetai - Y).^2); % Calculate cost function
end
Iteration=iteration;
end