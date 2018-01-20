%% Assignment 2

clear all;
%%

data = load('C:\Users\arjun\OneDrive\Documents\PatternRecognition\lab7\cluster_data.mat ');
data = data.cluster_data;

%% Question 1
figure(1)
hold on
scatter (data(:,1),data(:,2),25,'filled');
distances = pdist(data);
s_distances = sort(distances);
temp = squareform(pdist(data));

for epoch = 1:4700
    %epoch = 1:4700
    [Y,X] = find(temp==s_distances(epoch));
    
    plot([data(X(1),1) data(X(2),1)],[data(Y(2),2) data(Y(1),2)],'r-','LineWidth',0.3)
    
end
clusters = 4;
       c = clusterdata(data,'linkage','single','maxclust',clusters);
       data(:,3) = c;
       for i = 1:clusters
            centroid(i,:) = mean(data(data(:,3)== i,1:2));
       end
       scatter (centroid(:,1),centroid(:,2),50,'k','filled');
       data(data(:,3)== i,:)
hold off

%% Question 2

figure(1)
hold on
scatter (data(:,1),data(:,2),25,'filled');
distances = pdist(data);
s_distances = sort(distances,'descend');
temp = squareform(pdist(data));
for epoch = 1:2725
    %epoch = 1:2725
    [Y,X] = find(temp==s_distances(epoch));
    
    plot([data(X(1),1) data(X(2),1)],[data(Y(2),2) data(Y(1),2)],'r-','LineWidth',0.5)
    
end
clusters = 4;
       c = clusterdata(data,'linkage','complete','maxclust',clusters);
       data(:,3) = c;
       for i = 1:clusters
            centroid(i,:) = mean(data(data(:,3)== i,1:2));
       end
       scatter (centroid(:,1),centroid(:,2),50,'k','filled');
       data(data(:,3)== i,:)
hold off
hold off


%% trial and error
figure (3)
hold on
z = linkage(data,'average');
scatter (data(:,1),data(:,2),25,'filled');
%plot(data(z(:,1)),data(z(:,2)),'r-','LineWidth',2);
clusters = 4;
       c = clusterdata(data,'linkage','complete','maxclust',clusters);
       data(:,3) = c;
       for i = 1:clusters
            centroid(i,:) = mean(data(data(:,3)== i,1:2));
       end
       scatter (centroid(:,1),centroid(:,2),50,'k','filled');
       data(data(:,3)== i,:)
     hold off  
     
     
 %% Question 4
 
distances = pdist(data);
tree = linkage(distances,'average');

figure()
dendrogram(tree)

%% trial and error
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
%% Trial and error for second question

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
%       c = clusterdata(data,'linkage','single','maxclust',clusters);
 %      data(:,3) = c;
       for i = 1:clusters
            centroid(i,:) = mean(data(data(:,3)== i,1:2));
       end
       scatter (centroid(:,1),centroid(:,2),80,'k','filled','h');
       data(data(:,3)== i,:)
%'DisplayName','Centers'
hold off;
legend('cluster-1','cluster-2','cluster-3','cluster-4','Centers')