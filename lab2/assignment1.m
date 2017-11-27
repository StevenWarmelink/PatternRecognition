%% Assignment 1 

format long;

% means of features
% construct matrix
Dat = [4 6 8 7 4;
       5 3 7 4 6;
       6 9 3 8 5];
   
% calculate feature means
m1 = mean(Dat(1,:))
v1 = var(Dat(1,:))
m2 = mean(Dat(2,:))
v2 = var(Dat(2,:))
m3 = mean(Dat(3,:))
v3 = var(Dat(3,:))

%% Covariance Matrix

covMat = cov(Dat')

%% Probability Density
means = [m1 m2 m3];
vars  = [v1 v2 v3];
X = [4 6.5 1];

mvnpdf(X,means,covMat)

