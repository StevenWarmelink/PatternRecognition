%% - clear
clear all;
close all;

%% - setup & load
% add all files to working directory
addpath(genpath('.'));

% load data
data = load('checkerboard');
data = data.checkerboard;

% load prototypes
prototypes = load('clusterCentroids');
prototypes = prototypes.clusterCentroids;
%% K-means

figure(1);
[output, ~] = euclidian_kmeans(data, 100, prototypes);
plot_kmeans(output);

%% Batch Neural Gas

figure(2);
batchNG(data, 100, 1000);