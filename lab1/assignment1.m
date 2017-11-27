%% Assignment 1.1: 
% Compute the pair-wise correlation coefficients 
% between the features.
clear;

data = load('./data/lab1_1.mat');
data = data.lab1_1;

% calculate correlation coefficients
X = corrcoef(data);

%  1.00  -0.06  0.71 
% -0.06   1.00  0.51
%  0.71   0.51  1.00


%% 1.2 - Create 2D scatterplots
clear;
data = load('./data/lab1_1.mat');
data = data.lab1_1;


%% plot A
%strongest correlations: 1-3 and 2-3
format long;
%X1 = [ones(length(data(:,3)),1) data(:,3)];
%b1 = X1\data(:,1);
%ycalc1 = X1*b1;
%subplot(2,1,1);
scatter(data(:,1),data(:,3),'r');
%hold on;
%plot(data(:,3),ycalc1);
title('2 features with largest corrcoeff');
xlabel('body length (cm)');
ylabel('body weight (kg)');
%hold off;

%% plot B

%subplot(2,1,2);
X2 = [ones(length(data(:,3)),1) data(:,3)];
b2 = X2\data(:,2);
ycalc2 = X2*b2;
scatter(data(:,2),data(:,3),'r');
%hold on;
%plot(data(:,3),ycalc2);
%hold off;
title('2 features with second-largest corrcoeff');
xlabel('age (years)');
ylabel('body weight (kg)');

