%% Question 1-2: Let the value of x* be equal to 10 and 
%  compute the probabilities of hit (h) and false alarm (fa)

format long;

mu_1 = 5;
mu_2 = 7;

var_1 = 4;
var_2 = 4;

% calculate hit
false_alarm  = 1 - normcdf(10,mu_1, sqrt(var_1))

hit          = 1 - normcdf(10,mu_2, sqrt(var_2))

%Hit =  probability gets classified as W1
%FA  =  probability gets classified as W2


%% Question 3-5: Discriminibility

% Question 3
mu_1 = 5;
mu_2 = 7;
var  = 4;

discr = abs((mu_1 - mu_2) / sqrt(var))

% Question 4
mu_1 = 5;
mu_2 = 9;
var  = 4;

discr = abs((mu_1 - mu_2) / sqrt(var))

% Question 5

mu_1 = 5;
mu_2 = 11;
var  = 4;

discr = abs((mu_1 - mu_2) / sqrt(var))

%% Question 6-10

% Question 6
% -Knowing the coordinates of a point in the ROC space is sufficient for calculating the classification accuracy at that point.
% -A random-guess classifier would have an ROC that falls on the diagonal (black line).

% Question 7
data = load('lab3_1.mat');
data = data.outcomes;

% 1 1 = hit
% 1 0 = false negative
% 0 1 = false positive
% 0 0 = no signal

n_hits = 0;

for idx = 1:length(data)
    if (data(idx,1) == 1) && (data(idx,2) == 1)
        n_hits = n_hits + 1;
    end
end

hitrate = n_hits / length(data)

% Question 8

n_fa = 0;

for idx = 1:length(data)
    if (data(idx,1) == 0) && (data(idx,2) == 1)
        n_fa= n_fa + 1;
    end
end

fa_rate = n_fa / length(data)

%% Question 9
figure();
hold on;
line([1 0], [0 1]);
scatter(fa_rate, hitrate);
xlabel('False positive rate');
ylabel('True positive rate');
axis([0 1 0 1]);

%%
data_trans = data'; 
targets = data(1,:);
[tpr, fpr, thresholds] = roc(data(:,1), data(:,2)); 

hold on;
for i = 1:length(thresholds)
   tempdat = thresholds(i);
   tempdat = tempdat{1,1};
   scatter(tempdat
end
scatter(thresholds);