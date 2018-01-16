%% clear & close
clear all;
close all;

%% setup and enter data
% add all files to working directory
addpath(genpath('.'));

% set vectors
x1 = [0 0]';
x2 = [2 3]';
x3 = [1 4]';
x4 = [4 2]';
x5 = [3 0]';

% create data vector
data = [x1 x2 x3 x4 x5];
%% question 1

% create cluster division
avg_c1_q1 = (x1 + x2 + x3) / 3;
avg_c2_q1 = (x4 + x5)      / 2;

% print result
disp('Question 1');
calculateJe(data, avg_c1_q1,avg_c2_q1);

%% question 2

% create cluster division
avg_c1_q2 = (x2 + x3 + x5) / 3;
avg_c2_q2 = (x1 + x4)      / 2;

% print result
disp('Question 2');
calculateJe(data, avg_c1_q2,avg_c2_q2);

%% question 3

% create cluster division
avg_c1_q3 = x4;
avg_c2_q3 = (x1 + x2 + x3 + x5) / 4;

% print result
disp('Question 3');
calculateJe(data, avg_c1_q3,avg_c2_q3);

%% question 4

% create cluster division
avg_c1_q4 = (x3 + x5)       / 2;
avg_c2_q4 = (x1 + x2 + x4)  / 3;

% print result
disp('Question 4');
calculateJe(data, avg_c1_q4,avg_c2_q4);
