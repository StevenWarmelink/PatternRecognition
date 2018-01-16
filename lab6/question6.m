%% Question 4 : Calculating the quantization error
clear all;

%%
data = load('C:\Users\arjun\OneDrive\Documents\PatternRecognition\lab6\data\kmeans1');
data = data.kmeans1;
je = zeros(1000,1);
epoch = 100;
dataset_old = zeros(1000,3);
dataset = zeros(1000,3);
for K = 1:30
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
scatter(maximum,maximum,25,[0 0.5 0]);
plot([maximum maximum],[0 1800])
xlabel('X-axis');
ylabel('Y-axis');
hold off
legend('Quantization Error','R(K)','Kopt')