%%
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
for epoch = 1:2750
    %epoch = 1:2725
    [Y,X] = find(temp==s_distances(epoch));
    
    plot([data(X(1),1) data(X(2),1)],[data(Y(2),2) data(Y(1),2)],'r-','LineWidth',2)
    
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
for epoch = 1:5
    %epoch = 1:2725
    [Y,X] = find(temp==s_distances(epoch));
    
    plot([data(X(1),1) data(X(2),1)],[data(Y(2),2) data(Y(1),2)],'r-','LineWidth',2)
    
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
 
tree = linkage(data,'average');

figure()
dendrogram(tree)