%% - clear
clear all;
close all;

%% - setup & load
% add all files to working directory
addpath(genpath('.'));

% load data
data = load('cluster_data');
data = data.cluster_data;

%% Question 1
% Answer: Euclidean Distance (to the power 1/2 is sqrt)

%% Question 2, 3 - Connected Components

% Create maximized figure (for automatic saving image 
% proportions
figure('units','normalized','outerposition',[0 0 1 1]);

[rows, cols] = size(data);
thresholds = [0.05 0.10 0.15 0.20 0.25];
plotidx = 1;
for threshold = thresholds
    subplot(3,2,plotidx);
    hold on;
    plotidx = plotidx + 1;
    for idx1 = 1:rows-1
        dist = pdist2(data(idx1,:),data(idx1+1:rows,:));
        for idx2 = 1:length(dist)
           if dist(idx2) < threshold 
               x1 = data(idx1,1);
               x2 = data(idx1+idx2,1);
               y1 = data(idx1,2);
               y2 = data(idx1+idx2,2);
               plot([x1 x2],[y1 y2],'k'); 
           end
        end    
    end
    scatter(data(:,1),data(:,2),6,'b','filled');
    title(['Threshold: ',num2str(threshold)]);
    xlabel('x-axis');
    ylabel('y-axis');
    hold off;
end
print('-f1','results/threshold_distances','-dpng')

%% Question 4
% When the threshold is set to 0.10, there are 5 clusters 
% rather than four (there is one very small cluster 
% consisting of 3 points). However, when the threshold 
% is set to 0.20, there are only 3 clusters since the 2 
% leftmost clusters are connected. Therefore, out of the
% given options, the threshold of 0.15 seems best (even 
% though some values we would consider not belonging 
% to any of the classes specifically such as the point 
% around (0.5, 0.45) are attributed to one of the 
% classes).

%% Question 5

threshold = 0.15;

% create empty clusters matrix;
clusters = [];

for idx1 = 1:rows-1
    dist = pdist2(data(idx1,:),data(idx1+1:rows,:));
    for idx2 = 1:length(dist)
       if dist(idx2) < threshold
           [~, col] = size(clusters);
           for numcol = 1:col
               currentCol = clusters(col);
               res1 = find(currentCol == (idx1));
               res2 = find(currentCol == (idx1+idx2));
               if ~isempty(res1)
                   clusters(col) = [clusters(col) 
               end
           end
           find(clusters == (idx1 | idx2));

           x1 = data(idx1,1);
           x2 = data(idx1+idx2,1);
           y1 = data(idx1,2);
           y2 = data(idx1+idx2,2);
           plot([x1 x2],[y1 y2],'k'); 
       end
    end    
end
scatter(data(:,1),data(:,2),6,'b','filled');
title(['Threshold: ',num2str(threshold)]);
xlabel('x-axis');
ylabel('y-axis');
hold off;

