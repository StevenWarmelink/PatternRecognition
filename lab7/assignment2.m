%% Assignment 2

clear all;
%%

data = load('data/cluster_data.mat');
data = data.cluster_data;



     

%% Question 1
figure (3)
hold on;
temp = squareform(pdist(data));
Z = linkage (temp,'single');
T = cluster(Z,'maxclust',4);
data(:,3) = T;
title('Hierarchical clustering based on Dmin')
scatter(data(data(:,3) == 1,1),data(data(:,3) == 1,2),50,[0 0.5 0.5],'filled','d')
scatter(data(data(:,3) == 2,1),data(data(:,3) == 2,2),50,[1 0.5 1],'filled','s')
scatter(data(data(:,3) == 3,1),data(data(:,3) == 3,2),50,[0 0.5 1],'filled','^')
scatter(data(data(:,3) == 4,1),data(data(:,3) == 4,2),50,[0 1 0.5],'filled','>')
clusters = 4;
       c = clusterdata(data,'linkage','single','maxclust',clusters);
       data(:,3) = c;
       for i = 1:clusters
            centroid(i,:) = mean(data(data(:,3)== i,1:2));
       end
       scatter (centroid(:,1),centroid(:,2),80,'k','filled','h');
       data(data(:,3)== i,:)

hold off;
legend('cluster-1','cluster-2','cluster-3','cluster-4','Centers')
%% Question 2 
clear all;

data = load('C:\Users\arjun\OneDrive\Documents\PatternRecognition\lab7\cluster_data.mat ');
data = data.cluster_data;

figure (3)
hold on;
temp = squareform(pdist(data));
Z = linkage (temp,'complete');
T = cluster(Z,'maxclust',4);
data(:,3) = T;
title('Hierarchical clustering based on Dmax')
scatter(data(data(:,3) == 1,1),data(data(:,3) == 1,2),50,[0 0.5 0.5],'filled','d')
scatter(data(data(:,3) == 2,1),data(data(:,3) == 2,2),50,[1 0.5 1],'filled','s')
scatter(data(data(:,3) == 3,1),data(data(:,3) == 3,2),50,[0 0.5 1],'filled','^')
scatter(data(data(:,3) == 4,1),data(data(:,3) == 4,2),50,[0 1 0.5],'filled','>')
clusters = 4;

       for i = 1:clusters
            centroid(i,:) = mean(data(data(:,3)== i,1:2));
       end
       scatter (centroid(:,1),centroid(:,2),80,'k','filled','h');
       data(data(:,3)== i,:)

hold off;
legend('cluster-1','cluster-2','cluster-3','cluster-4','Centers')


     
 %% Question 4
figure()
hold on

distances = pdist(data);
tree = linkage(distances,'average');
dendrogram(tree)
title('Dendogram based on average linkage')
hold off