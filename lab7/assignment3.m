%% clear & close
clear all;
close all;

%% setup and enter data
% add all files to working directory
addpath(genpath('.'));

% set vectors
x1 = [0 0];
x2 = [2 3];
x3 = [1 4];
x4 = [4 2];
x5 = [3 0];


%% Explorative: plot data
% create data vector
data = [x1; x2; x3; x4; x5];


% plot data
figure(1);
scatter(data(:,1),data(:,2));
xlim([-1 5]);
ylim([-1 5]);
%% question 1

% create cluster division
c1 = [x1;x2;x3];
c2 = [x4;x5];
avg_c1 = (x1 + x2 + x3) / 3;
avg_c2 = (x4 + x5)      / 2;

% print result
disp('Question 1');
calculateJe(c1, c2, avg_c1,avg_c2);

%% question 2

% create cluster division
c1 = [x2; x3; x5];
c2 = [x1; x4];
avg_c1 = (x2 + x3 + x5) / 3;
avg_c2 = (x1 + x4)      / 2;

% print result
disp('Question 2');
calculateJe(c1, c2, avg_c1,avg_c2);

%% question 3

% create cluster division
c1 = x4;
c2 = [x1; x2; x3; x5];
avg_c1 = x4;
avg_c2 = (x1 + x2 + x3 + x5) / 4;

% print result
disp('Question 3');
calculateJe(c1, c2, avg_c1,avg_c2);

%% question 4

% create cluster division
c1 = [x3; x5];
c2 = [x1; x2; x4];
avg_c1 = (x3 + x5)       / 2;
avg_c2 = (x1 + x2 + x4)  / 3;

% print result
disp('Question 4');
calculateJe(c1, c2, avg_c1,avg_c2);
