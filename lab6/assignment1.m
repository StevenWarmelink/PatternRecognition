%% lab6 Assignment 1

clear all;

%%
data = load('C:\Users\arjun\OneDrive\Documents\PatternRecognition\lab6\data\kmeans1');
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
icons = ['s','d','v','^','<','>','+','o'];
dataset_old = zeros(1000,3);
dataset = zeros(1000,3);
for K = k
    prototype = datasample(data,K);
    for i = 1:epoch
        [temp,dataset] = Kmeans(K,data,prototype,0);
        if (isequal(dataset,dataset_old))
            break;
        end
            dataset_old = dataset;
            prototype = temp;
    end
    if (K == 2)
        subplot(3,1,1)
        hold on
        for i = 1:K
            temp= dataset(dataset(:,3)== i,:);
            scatter(temp(:,1),temp(:,2),icons(i),'MarkerFaceColor', ...
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
            scatter(temp(:,1),temp(:,2),icons(i),'MarkerFaceColor', ...
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
            scatter(temp(:,1),temp(:,2),icons(i),'MarkerFaceColor', ...
            [1 (i/K) 0], 'MarkerEdgeColor',[0 0 0]);
        end
        scatter(prototype(:,1),prototype(:,2),'MarkerFaceColor', ...
        [0 0 0], 'MarkerEdgeColor',[0 0 0]);
        hold off
    end
end
hold off
%% plots of prototypes ( this is just to see the results of Knn)
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
K = 4;
num = 1;


idx = 1;
figure (2)
hold on


    prot = zeros(K*epoch,2);
    prototype = datasample(data,K);

    scatter(data(:,1),data(:,2),'MarkerFaceColor', ...
    [1 0 0], 'MarkerEdgeColor',[0 0 0],'DisplayName','datapoints');
    scatter(prototype(:,1),prototype(:,2),'MarkerFaceColor', ...
    [0.5 0.5 0.5], 'MarkerEdgeColor',[0 0 0],'DisplayName','initial prototypes');
    for i = 1:epoch
        for j = 1:K
                prot(idx,:) = prototype(j,1:2);
                idx = idx +1;
        end    
        [temp,dataset] = Kmeans(K,data,prototype,0);
            if (isequal(dataset,dataset_old))
                break;
            end
                dataset_old = dataset;
                prototype = temp;
    end

        prot(prot == 0) = nan;
        for i = 1:K
            plot(prot(i:K:end,1),prot(i:K:end,2),'color',[0 (1/i) (1/i)],'LineWidth',2,'DisplayName','transitions');
        end


scatter(prototype(:,1),prototype(:,2),'MarkerFaceColor', ...
    [0 0 0], 'MarkerEdgeColor',[0 0 0],'DisplayName','final prototypes');
hold off
legend('show','Location','southwest');

%% Question 4 : Calculating the quantization error

je = zeros(1000,1);
epoch = 100;
dataset_old = zeros(1000,3);
dataset = zeros(1000,3);
for K = 1:100
    K
    prototype = datasample(data,K);
    for i = 1:epoch
        [temp,dataset] = Kmeans(K,data,prototype,0);
        if (isequal(dataset,dataset_old))
            break;
        end
            dataset_old = dataset;
            prototype = temp;
    end
        for j = 1:1000
            if (dataset(j,3) == prototype(K,3))
                je(K) = je(K) + ((0.5)*(pdist2(data(j,:),prototype(K,1:2))));
            end
        end
        R(K) = je(1)*(K.^(-1));
        D(K) = R(K)/je(K);
end
hold on
plot(D,'g-');
xlabel('Values of K');
ylabel('Values of D');
[maximum,index] = max(D);
%plot(max(D),index,'color','g')
scatter(index,maximum,25,[1 0 0]);
hold off
legend('values of D(K)','Kopt','Location','northwest')

%% question 5

je(je == 0) = nan;

hold on
plot(je,'k-')
plot(R,'r-')
[maximum,index] = max(D);
scatter(index,maximum,25,[0 0.5 0]);
xlabel('X-axis');
ylabel('Y-axis');
hold off
legend('Quantization Error','R(K)','Kopt')
%% K-means ++ Question 8,9

checker = load('C:\Users\arjun\OneDrive\Documents\PatternRecognition\lab6\data\checkerboard.mat');
data = checker.checkerboard;
K = 100;
epoch = 100;
dataset_old = zeros(1000,3);
dataset = zeros(1000,3);
qe = zeros(20,1);
for series = 1:10
    series
    for set = 1:20
        set
        prototype(1,1:2) = datasample(data,1);
        for i = 2:K
            prototype(i,1:2) = Kmeans(K,data,prototype,1);
        end
        for i = 1:epoch
            [temp,dataset] = Kmeans(K,data,prototype,0);
                if (isequal(dataset,dataset_old))
                    break;
                end
                    dataset_old = dataset;
                    prototype = temp;
        end
        for i = 1: size(prototype,1)
            for j = 1:1000
                        if (dataset(j,3) == prototype(i,3))
                            qe(set) = qe(set) + ((0.5)*(pdist2(data(j,:),prototype(i,1:2))));
                        end
            end
        end
        finalresult(series) = min(qe(qe ~= 0));
    end
    prototype = [];
end

%% Question 9 10
hold on
scatter (data(:,1),data(:,2))
scatter (temp(:,1),temp(:,2),50,[0 0 0],'filled')
hold off

result_mean = mean(finalresult);
result_std = std(finalresult);
%% Question 11 12

checker = load('C:\Users\arjun\OneDrive\Documents\PatternRecognition\lab6\data\checkerboard.mat');
data = checker.checkerboard;
K = 100;
epoch = 100;
dataset_old = zeros(1000,3);
dataset = zeros(1000,3);
qe = zeros(20,1);
for series = 1:10
    series
    for set = 1:20
        set
        prototype = datasample(data,K);
        for i = 1:epoch
            [temp,dataset] = Kmeans(K,data,prototype,0);
                if (isequal(dataset,dataset_old))
                    break;
                end
                    dataset_old = dataset;
                    prototype = temp;
        end
        for i = 1: size(prototype,1)
            for j = 1:1000
                        if (dataset(j,3) == prototype(i,3))
                            qe(set) = qe(set) + ((0.5)*(pdist2(data(j,:),prototype(i,1:2))));
                        end
            end
        end
        finalresult(series) = min(qe(qe ~= 0));
    end
    prototype = []
end


