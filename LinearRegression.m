% Farinaz Fallahpour
% Date: 2011 
% https://github.com/FarinazFallahpour
function LinearRegression()
%% A. Linear Regression with one variable
Dataset=load('dataset1.txt');
%Alpha=0.01;
%AlphaB=0.0000001;
%A_1_a(Dataset);
%A_1_b(Dataset);
%A_1_c(Dataset,0.01);
%A_3(Dataset,0.01);
%A_4_5(Dataset,0.01);
%A_6(Dataset,0.0001,0.0001);
%% A_7
%JTetaInTermsOfTeta(Dataset);

%% B. Analysis the effect of outlier
%B(Dataset,Alpha);

%% C. Linear Regression with multiple variables
Dataset = load('dataset2.txt'); %load Dataset
%Alpha=0.0001;
%AlphaB=0.0000001;
%AlphaS=0.0001;
%C_1_a(Dataset);
%C_1_b(Dataset,0.0000001);
%C_2(Dataset,0.000000001,0.000000001);
%C_3_4(Dataset,0.000000001);

%% D. Analysis the effect of feature renormalization
Alpha=0.0001;
D(Dataset,Alpha);
end

%% A_1_a) Closed-form solution calculated by LSE method
function A_1_a(Dataset)
NOofFeature=size(Dataset,2); % # of feature
Y=Dataset(:,NOofFeature);
X=Dataset(:,1:NOofFeature-1);
[~,y] = ClosedForm(Dataset);
figure;
plot(X,Y,'.b');
hold on, plot(X,y,'-r');
xlabel('Input variable');
ylabel('Output variable');
legend('Feature','Estimated Line');
title('Closed-Form');
end

%% A_1_b) Gradient descent method in online (stochastic) mode (1500 iterations)
function A_1_b(Dataset)
NOofFeature=size(Dataset,2); % # of feature
Y=Dataset(:,NOofFeature);
X=Dataset(:,1:NOofFeature-1);
[~,y] = SGD(Dataset);
figure;
plot(X,Y,'.b');
hold on, plot(X,y,'-m');
xlabel('Input variable');
ylabel('Output variable');
legend('Feature','Estimated Line');
title('Stochastic Gradient Descent');
end

%% A_1_c) Gradient descent method in batch mode (1500 iterations)
function A_1_c(Dataset,Alpha)
NOofFeature=size(Dataset,2); % # of feature
Y=Dataset(:,NOofFeature);
X=Dataset(:,1:NOofFeature-1);
[~,y] = BGD(Dataset,Alpha);
figure;
plot(X,Y,'.b');
hold on, plot(X,y,'-g');
xlabel('Input variable');
ylabel('Output variable');
legend('Feature','Estimated Line');
title('Batch Gradient Descent');
end

%% A_3) Plot the dataset and superimpose the fitted modelsusing three above methods.
function A_3(Dataset,Alpha)
NOofFeature=size(Dataset,2); % # of feature
Y=Dataset(:,NOofFeature);
X=Dataset(:,1:NOofFeature-1);
[~,yC]=ClosedForm(Dataset);
[~,yB] = BGD(Dataset,Alpha);
[~,yS] = SGD(Dataset);
figure;
plot(X,Y,'.b');
hold on, plot(X,yC,'-r');
hold on, plot(X,yB,'-g');
hold on, plot(X,yS,'-m');
xlabel('Input variable');
ylabel('Output variable');
legend('Feature','Closed-Form','Batch Gradient Descent','Stochastic Gradient Descent');
title('Linear Regression');
end

%% A_4) Use each estimated parameter Teta to predict the output for x=6.2, 12.8, 22.1, 30.
function A_4_5(Dataset,Alpha)
TetaC=ClosedForm(Dataset);
TetaS=SGD(Dataset);
TetaB=BGD(Dataset,Alpha);  
x=[1,6.2;1,12.8;1,22.1;1,30];
yC=x*TetaC; 
disp('predict by ClosedForm:');
disp(yC);
yS=x*TetaS; 
disp('predict by Stochastic:');
disp(yS);
yB=x*TetaB; 
disp('predict by Batch:');
disp(yB);
%% A_5) Compare the parameter Teta estimated by each method.
disp('estimated by ClosedForm:');
disp(TetaC); 
disp('estimated by Stochastic:');
disp(TetaS); 
disp('estimated by Batch:');
disp(TetaB);
end

%% A_6) Plot the cost function JTeta along the epochs (plot both online & batch methods on one
%figure using hold on command).
function A_6(Dataset,AlphaB,AlphaS)
NOofFeature=size(Dataset,2); % # of feature
Y=Dataset(:,NOofFeature);
X=Dataset(:,1:NOofFeature-1);
[J_Theta_Batch,J_Theta_Stoch,Iteration]=J_Teta(Dataset,AlphaB,AlphaS);
figure; 
plot(0:Iteration-1,J_Theta_Stoch,'-r');
hold on,plot(0:Iteration-1,J_Theta_Batch,'-b');
xlabel('Iteration');
ylabel('J Teta');
legend('Stochastic Cost Function','Batch Cost Function');
title('Cost Function');
end

%% B. Analysis the effect of outlier
function B(Dataset,Alpha)
NOofFeature=size(Dataset,2); % # of Features
Y=Dataset(:,NOofFeature);
X=Dataset(:,1:NOofFeature-1);
%% B_1) Add some outlier by randomly generating some samples in the border of the data range.
% For this, generate 5 samples with x[6 8] and x[20 25] and 5 samples with
% y[20 24] and y[0 10].
outx1=randi([6,8],1,5);
outx2=randi([20,24],1,5);
outy1=randi([20,25],1,5);
outy2=randi([0,10],1,5);
% Create new Dataset (outliers added to old Dataset)
NewDataset(:,1)=[(X(:,1))' outx1 outx2]';
NewDataset(:,2)=[(Y(:,1))' outy1 outy2]';
%% B_2) Fit a model on the new data using:
% a) Closed form solution of liner regression.
% b) Batch Gradient descent (1500 iterations).
[~,yCF] = ClosedForm(Dataset); %ClosedForm without outlier
[~,yBGD] = BGD(Dataset,Alpha);      %Batch Gradient Descent without outlier
[TCFnew,yCFnew] = ClosedForm(NewDataset); %ClosedForm with outlier
[TBGDnew,yBGDnew] = BGD(NewDataset,Alpha);   %Batch Gradient Descent without outlier
%% B_3) Plot the data and superimpose the fitted models from Part A (i.e., A-1-a & A-1-c) and in
% this part onto your figure.
plot(X,Y,'.b');
hold on, plot(X,yCF,'-k'); %  ClosedForm without outliers
hold on, plot(NewDataset(:,1),yCFnew,'-m','LineWidth',3); % ClosedForm with outlier
hold on, plot(X,yBGD,'-r');% Batch Gradient Descent without outlier
hold on, plot(NewDataset(:,1),yBGDnew,'-c'); % Batch Gradient Descent with outlier
hold on, plot(outx1,outy1,'*g');  % outliers
hold on, plot(outx2,outy2,'og');  %outliers
xlabel('Input variable');
ylabel('Output variable');
legend('Feature','ClosedForm without outlier','ClosedForm with outlier',...
        'BGD without outlier','BGD with outlier','outlier1','outlier2');
title('B Analysis the effect of outlier');
%% B_4) Use the estimated parameter Tetato predict the output for x=6.2, 12.8, 22.1, 30.
Xtest=[1,6.2;1,12.8;1,22.1;1,30];
yCFtest=Xtest*TCFnew; 
disp('predict by ClosedForm:');
disp(yCFtest);
yBGDtest=Xtest*TBGDnew;
disp('predict by Batch:');
disp(yBGDtest);
end

%% C. Linear Regression with multiple variables
% C_1_a) Closed form solution of liner regression.
function C_1_a(Dataset)
NOofFeature=size(Dataset,2); % # of feature
Y=Dataset(:,NOofFeature);
X=Dataset(:,1:NOofFeature-1);
[~,y] = ClosedForm(Dataset);
figure;
plot3(X(:,1),X(:,2),Y,'.b');
hold on, plot3(X(:,1),X(:,2),y,'or');
xlabel('Feature1');
ylabel('Feature2');
zlabel('Output variable');
legend('Feature','Estimated Line');
title('Closed-Form');
end

%% C_1_b) Batch Gradient descent (1500 iterations).
function C_1_b(Dataset,Alpha)
NOofFeature=size(Dataset,2); % # of feature
Y=Dataset(:,NOofFeature);
X=Dataset(:,1:NOofFeature-1);
[~,y] = BGD(Dataset,Alpha);
figure;
plot3(X(:,1),X(:,2),Y,'.b');
hold on, plot3(X(:,1),X(:,2),y,'og');
xlabel('Feature1');
ylabel('Feature2');
zlabel('Output variable');
legend('Feature','Estimated Line');
title('Batch Gradient Descent');
end

%% C_2) Plot the cost function JTeta along the epochs for Gradient descent method.
function C_2(Dataset,AlphaB,AlphaS)
NOofFeature=size(Dataset,2); % # of feature
[J_Theta_Batch,J_Theta_Stoch,Iteration]=J_Teta(Dataset,AlphaB,AlphaS);
figure;
plot(0:Iteration-1,J_Theta_Stoch,'-r');
hold on,plot(0:Iteration-1,J_Theta_Batch,'-b');
xlabel('Iteration');
ylabel('J Teta');
legend('Stochastic Cost Function','Batch Cost Function');
title('Cost Function');
end

%% C_3) Use each estimated parameter Teta to predict the output for x = [1357, 5], x=[2500, 4].
%  C_4) Compare the parameter Tetaestimated by each method.
function [yC,yB]=C_3_4(Dataset,Alpha)
    x=[1357 5;2500 4]; %data for test
    x=[ones(2,1),x]; % add a column of ones to x
    TetaC=ClosedForm(Dataset);
    TetaB=BGD(Dataset,Alpha);
    % predict the output
    yC=x*TetaC;
    yB=x*TetaB;
    disp('predict by ClosedForm:');
    disp(yC);
    disp('predict by Batch:');
    disp(yB);
    disp('estimated by ClosedForm:');
    disp(TetaC);
    disp('estimated by Batch:');
    disp(TetaB);
end

%% D. Analysis the effect of feature renormalization
function D(Dataset,Alpha)
NOofFeature=size(Dataset,2);     % # of Features
NOofSample=size(Dataset,1);      % # of Sample
Y=Dataset(:,NOofFeature);
X=Dataset(:,1:NOofFeature-1);
%% D_1) Apply feature normalization on the dataset2 used in Part C (Note: for normalization you
%      can scale the samples such a way that the minimum and maximum values of each
%      feature change to 0 and 1, respectively).
Dataset2=Dataset;
MinDs=min(Dataset2);
MaxDs=max(Dataset2);
MinDs_v=ones(NOofSample,1)*MinDs;
MaxDs_v=ones(NOofSample,1)*MaxDs;
DsNormal=(Dataset2-MinDs_v)./(MaxDs_v-MinDs_v);
%% D_2) Fit a model on the new data using
%       a)Closed form solution of liner regression.
%       b)Batch Gradient descent (1500 iterations)
[~,yC] = ClosedForm(Dataset); % ClosedForm without normalization
[~,yB] = BGD(Dataset,0.0000001); % Batch Gradient Descent without outlier
[TetaCnew,yCnew] = ClosedFormNormal(Dataset); %ClosedForm for Normalized
[TetaBnew,yBnew] = BGDNormal(Dataset,Alpha);%Batch Gradient Descent for Normalized
figure;
plot3(X(:,1),X(:,2),Y,'.b');
hold on, plot3(X(:,1),X(:,2),yB,'.c');
hold on, plot3(X(:,1),X(:,2),yBnew,'og');
hold on, plot3(X(:,1),X(:,2),yC,'om');
hold on, plot3(X(:,1),X(:,2),yCnew,'.r');
xlabel('Feature1');
ylabel('Feature2');
zlabel('Output variable');
legend('Feature','Batch','Normal Batch','Closed-Form','Normal Closed-Form');
title('D Analayze the effect of feature renormalization');
%% D_3) Use the estimated parameter Teta to predict the output for x = [1357, 5], x=[2500, 4].
Xtest=[1,1357,5;1,2500,4];
Ctest=Xtest*TetaCnew;
disp('predict by ClosedForm:');
disp(Ctest); 
Btest=Xtest*TetaBnew; 
disp('predict by Batch:');
disp(Btest); 
end










