%% Assignment 4
clear all;

%% 

data = load('data/provinces');
data = data.provinces;

%% z-score calculations

Z = zscore(data,1);
distance = pdist(Z);
diss_mat = squareform (distance);

% Question3 : Zeeland
% Question4 : 1.9797
% Question5 : North Holland
% Quesition6 : 5.2079

