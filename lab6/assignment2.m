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
print('-f1','results/k_means','-dpng')

%% Batch Neural Gas

figure(2);
subplot(2,2,1);
batchNG(data, 100, 20);
title('20 epochs');
subplot(2,2,2);
batchNG(data, 100, 100);
title('100 epochs');
subplot(2,2,3);
batchNG(data, 100, 200);
title('200 epochs');
subplot(2,2,4);
batchNG(data, 100, 500);
title('500 epochs');
print('-f2','results/BNG','-dpng')