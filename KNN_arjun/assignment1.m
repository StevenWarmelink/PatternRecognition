%% lab6 Assignment 1

clear all;

%%
data = load('../data/kmeans1');
data = data.kmeans1;

%%
scatter(data(:,1),data(:,2),'MarkerFaceColor', ...
    [1 0 0], 'MarkerEdgeColor',[0 0 0]);
k=2;
y = datasample(data,k);
scatter(y(:,1),y(:,2),'MarkerFaceColor', ...
    [0 0 0], 'MarkerEdgeColor',[0 0 0]);


%% Question 1 and 2
figure(1)
hold on
epoch = 100;
k = [2,4,8];

dataset_old = zeros(1000,3);
dataset = zeros(1000,3);
for K = k
    prototype = datasample(data,K);
    for i = 1:epoch
        [temp,dataset] = Knn(K,data,prototype);
        if (isequal(dataset,dataset_old))
            break;
        end
            dataset_old = dataset;
        if (abs(temp - prototype) < 0.0001)
            break;
        end
        prototype = temp;
    
    end
    if (K == 2)
        subplot(3,1,1)
        hold on
        for i = 1:K
            temp= dataset(dataset(:,3)== i,:);
            scatter(temp(:,1),temp(:,2),'MarkerFaceColor', ...
            [(i/K) 0 0], 'MarkerEdgeColor',[0 0 0]);
            
        end
        scatter(prototype(:,1),prototype(:,2),'MarkerFaceColor', ...
        [0 0 0], 'MarkerEdgeColor',[0 0 0]);
        hold off
    end
    if (K == 4) 
        subplot(3,1,2)
        hold on
        for i = 1:K
            temp= dataset(dataset(:,3)== i,:);
            scatter(temp(:,1),temp(:,2),'MarkerFaceColor', ...
            [(i/K) 0 1], 'MarkerEdgeColor',[0 0 0]);
        end
        scatter(prototype(:,1),prototype(:,2),'MarkerFaceColor', ...
        [0 0 0], 'MarkerEdgeColor',[0 0 0]);
        hold off
    end
    if (K == 8)
        subplot(3,1,3)
        hold on
        for i = 1:K
            temp= dataset(dataset(:,3)== i,:);
            scatter(temp(:,1),temp(:,2),'MarkerFaceColor', ...
            [1 (i/K) 0], 'MarkerEdgeColor',[0 0 0]);
        end
        scatter(prototype(:,1),prototype(:,2),'MarkerFaceColor', ...
        [0 0 0], 'MarkerEdgeColor',[0 0 0]);
        hold off
    end
end
hold off
%% plots of prototypes
hold on
scatter(data(:,1),data(:,2),'MarkerFaceColor', ...
    [1 0 0], 'MarkerEdgeColor',[0 0 0]);
    scatter(prototype(:,1),prototype(:,2),'MarkerFaceColor', ...
    [0 0 0], 'MarkerEdgeColor',[0 0 0]);
hold off
%% Question 3

epoch = 100;
dataset_old = zeros(1000,3);
dataset = zeros(1000,3);
K = 8;
prototype = datasample(data,K);

prot = zeros(K*epoch,2);
idx = 1;
figure (2)
hold on
scatter(data(:,1),data(:,2),'MarkerFaceColor', ...
    [1 0 0], 'MarkerEdgeColor',[0 0 0]);
 scatter(prototype(:,1),prototype(:,2),'MarkerFaceColor', ...
    [0.5 0.5 0.5], 'MarkerEdgeColor',[0 0 0]);
for i = 1:epoch
    for j = 1:K
            prot(idx,:) = prototype(j,:);
            idx = idx +1;
    end    
    [temp,dataset] = Knn(K,data,prototype);
        if (isequal(dataset,dataset_old))
            break;
        end
            dataset_old = dataset;
        if (abs(temp - prototype) <= 0.0001)
            break;
        end
        prototype = temp;
        
   % for j = 1:K 
   %     plot(prototype(j,1),prototype(j,2),'b*');hold on
   % end
end


%for part = 1:K
    %scatter(prot(:,1),prot(:,2),'filled', 'MarkerFaceAlpha',1/part,'MarkerFaceColor', ...
    %[0 0 0], 'MarkerEdgeColor',[0 0 0]);
    prot(prot == 0) = nan;
    for i = 1:K
        plot(prot(i:K:end,1),prot(i:K:end,2),'color',[(1/i) (1/i) 1],'LineWidth',2);
    end
%end

scatter(prototype(:,1),prototype(:,2),'MarkerFaceColor', ...
    [0 0 0], 'MarkerEdgeColor',[0 0 0]);
hold off

