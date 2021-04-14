% Farinaz Fallahpour
% Date: 2011 
% https://github.com/FarinazFallahpour
% E. Logistic Regression
function LogisticRegression()
close all;
clc;
Dataset = load('dataset3.txt'); %load Dataset
NOofSample=size(Dataset,1);  % # of training sample
NOofFeature=size(Dataset,2); % # of feature
Y=Dataset(:,NOofFeature);
X=Dataset(:,1:NOofFeature-1);
X=[ones(NOofSample, 1), X]; % add a column of ones to x
Teta=zeros(NOofFeature,1);  % parameters matrix
Sigmoid = inline('1.0 ./ (1.0 + exp(-z))'); % Define the sigmoid function
%% E_2) Estimate the parameter Teta using Newton method.
iteration = 20;
J = zeros(iteration, 1);
for i = 1:iteration
    z = X * Teta;  
    H = Sigmoid(z); % Calculate the hypothesis function
    Gradient = (1/NOofSample).*X' * (H-Y); % Calculate Gradient
    Hessian = (1/NOofSample).*X' * diag(H) * diag(1-H) * X; % Calculate Hessian
    %   probability class 1 ra ghotri karde
    %   probability class 0 ra ghotri karde
    %   zarb 2 ta probability ha dar vaghe mishe likelihood
    %   hessian=gradian h_theta* gradian h_theta '
    J(i) =(1/NOofSample)*sum(Y.*log(H) + (1-Y).*log(1-H)); % Calculate J 
    Teta = Teta - Hessian\Gradient;
end
disp('estimated by Newton:');
disp(Teta );
%% E_3) Plot the cost function JTeta along the epochs of the Newton method.
figure,plot(0:iteration-1, J, '-r'); 
xlabel('Iteration');
ylabel('JTeta');
legend('Cost function');
title('cost function JTeta in terms of iteration');
%% E_4) Use the learned model to classify all training example.
%  E_7) Determine the accuracy of the learned method over the training data.
Class1Porb=Sigmoid(X*Teta);
Class0Prob=1-Sigmoid(X*Teta);
 Accuracy=0;
 Prob=zeros(1,NOofSample);
for i=1:NOofSample
    if  Class1Porb(i)> Class0Prob(i)
      Prob(i)=1;
    end
    if Prob(i)==Y(i)
      Accuracy=Accuracy+1;
    end
end
disp('accuracy:');
disp(Accuracy);
disp('No of Sample:');
disp(NOofSample);
%% E_5) Plot the data and show the class of the sample using different colors (red for class 0 &
%  blue for class 1)
figure
Pos = find(Y); 
Neg = find(Y == 0);
plot(X(Pos,2), X(Pos,3), 'ob');hold on,
plot(X(Neg,2), X(Neg,3), 'or');hold on,
xlabel('Feature 1');
ylabel('Feature 2');

%% E_6) (optional) Plot the boundary of the classifier.
% Only need 2 points to define a line, so choose two endpoints
plot_x = [min(X(:,2))-2,  max(X(:,2))+2];
plot_y = (-1./Teta(3)).*(Teta(2).*plot_x +Teta(1));
plot(plot_x, plot_y,'-g'); 
legend('Class 1', 'Class 0', 'Decision Boundary');
title('Logistic Regression')
end