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

%The integral of the first distribution 
%(with mean ?1) for values of x ? x? 
%specifies the probability of wrongly classifying an object from class ?1 into class ?2
%to be referred to as a false alarm. The integral of the second distribution 
%for values of x ? x? specifies the probability of correctly 
%classifying an object from class ?2 into class ?2, to be referred to as a hit.

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
data = load('C:\Users\arjun\Desktop\PatternRecognition\lab_assignment3\lab3_1.mat');
data = data.outcomes

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
scatter(fa_rate, hitrate,'g');
xlabel('False positive rate');
ylabel('True positive rate');
axis([0 1 0 1]);

means = 0:1:20;
xvec = zeros(1001,1);
yvec = zeros(1001,1);
idx = 0;
hold on;
for D = 0:.1:1
    xvec(idx) = 1 - normcdf(D, mean(data(:,2)), sqrt(var(data(:,2))));
    yvec(idx) = 1 - normcdf(D, mean(data(:,1)), sqrt(var(data(:,2))));
    hold off;
    pause();
    close all;
end
fimplicit(xvec, yvec,'r');

%%
data_trans = data'; 
targets = data(1,:);
[tpr, fpr, thresholds] = roc(data(:,1), data(:,2)); 

hold on;
for i = 1:length(thresholds)
   tempdat = thresholds(i);
   tempdat = tempdat{1,1};
   scatter(tempdat)
end
scatter(thresholds);

%% Another attempt at question 10
hitrate = 0.4400;
%number of hits

%consider mu_1 = 1 


for i = 0.9:0.001:1.4
 result = 1 - normcdf(i,1,1);
 if abs(result-hitrate) < 0.0001 
     disp(i)
 end
end

% X* is 1.15100

fa_rate = 0.0450;
for i = -1:0.001:2
 result = 1 - normcdf(1.15100,i,1);
 if abs(result-fa_rate) < 0.0001 
     disp(result)
     disp(i)
 end
end

% mu_2  = -0.544

discr = abs((1 - (-0.544)) / sqrt(1))

%% plotting the ROC curve.
figure();
hold on;
line([1 0], [0 1]);
scatter(fa_rate, hitrate,'*k');
xlabel('False alarm');
ylabel('Hit');
axis([0 1 0 1]);
fa = zeros(200);
ht = zeros(200);
idx = 1;
for x  = -3:0.001:3
    fa(idx)  = 1 - normcdf(x,1,1);

    ht(idx)  = 1 - normcdf(x,-0.544,1);
    idx = idx + 1;

end
disp(fa);
disp(ht);
plot(ht,fa,'--r')    
hold off






