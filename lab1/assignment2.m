%% Assignment 2

clear;
clf;

% set rng seed, using Mersene Twister generator
%rng(14112017,'twister');

% Build set S (same person Hamming distances)

HDsetS = zeros(1,10000);

for i = 1:10000
    % select random file from 20 possible; save into 'data1'
    r = randi([1 20], 1);
    filename = strcat('./data/person',sprintf('%02d',r),'.mat');
    data1 = load(filename);
    data1 = data1.iriscode;

    % pick 2 random rows from person file above
    r1 = randi([1 size(data1,1)], 1);
    r2 = randi([1 size(data1,1)], 1);
    while r2 == r1
        r2 = randi([1 size(data1,1)], 1);
    end    
    dataSetS = [data1(r1,:); data1(r2,:)];
    dist = pdist2(dataSetS(1,:),dataSetS(2,:),'hamming');
    HDsetS(i) = dist;
end
hold on;
histogram(HDsetS,30,'BinLimits',[0 1]);
axis([0 1 0 3500]);

% Build set D (different person Hamming distances)

HDsetD = zeros(1,10000);

for i = 1:10000
    % select random file from 20 possible; save into 'data1'
    p1 = randi([1 20], 1);
    p2 = randi([1 20], 1);
    while p2 == p1
        p2 = randi([1 20], 1);
    end
    filename1 = strcat('./data/person',sprintf('%02d',p1),'.mat');
    data1 = load(filename1);
    data1 = data1.iriscode;
    filename2 = strcat('./data/person',sprintf('%02d',p2),'.mat');
    data2 = load(filename2);
    data2 = data2.iriscode;

    % pick 2 random rows from person file above
    r1 = randi([1 size(data1,1)], 1);
    r2 = randi([1 size(data2,1)], 1); 
    dataSetD = [data1(r1,:); data2(r2,:)];
    dist = pdist2(dataSetD(1,:),dataSetD(2,:),'hamming');
    HDsetD(i) = dist;
end

histogram(HDsetD,30,'BinLimits',[0 1]);
axis([0 1 0 3500]);
title({'Hamming Distances for Binary Iris Codes','in Same and Different Individuals'});
xlabel('Hamming Distance, normalized to range [0, 1]');
ylabel('Count');
legend('Same Individual', 'Different Individual');

%% - Calculate means/vars and plot normaldists
s_mean = mean(HDsetS)
s_var  = var(HDsetS)
x = 0:0.001:1;
f = (1/(sqrt(2*pi) * sqrt(s_var))) * exp(- (1/2)*(((x - s_mean).^2) / (s_var)));

disp(s_mean);
disp(s_var);
%f = f * 3 * (100000 / sum(f));
f1 = normpdf(x,s_mean,sqrt(s_var));
f1 = f1 * 3 * (100000 / sum(f1));
f = f * 3 * (100000 / sum(f));
plot(x,f,'r');
plot(x,f1,'y');


d_mean = mean(HDsetD)
d_var  = var(HDsetD)
x = 0:0.001:1;
f = ( 1/(sqrt(2*pi) * sqrt(s_var)) * exp(- (1/2)*(((x-d_mean).^2)/ d_var)));
f = f * 3 * (100000 / sum(f));
plot(x,f,'k');
hold off;

%% - Part 2
x = 0:0.0001:1;
resD = normcdf(x, d_mean, sqrt(d_var));

resS = normcdf(x, s_mean, sqrt(s_var));


% sweep over calculated values to determine closest to 0.0005
for i = 1:10001
   if (resS(i) > 0.000495) && (resS(i) < 0.000505)
       disp(i);
   end
end


dist = pdist2(dataSetD(1,:),dataSetD(2,:),'hamming');

%%question 14
testdata = load ( 'C:\Users\arjun\Desktop\PatternRecognition\testperson')
testdata = testdata.iriscode
HDset = zeros(1,10000);
HDsetmin = zeros(1,20);
for person = 1:20
    filename = strcat('C:\Users\arjun\Desktop\PatternRecognition\person',sprintf('%02d',person),'.mat');
    data1 = load(filename);
    data1 = data1.iriscode;
    for iris = 1:size(data1,1)
        dataSetS = [data1(iris,:); testdata];
        dist = pdist2(dataSetS(1,:),dataSetS(2,:),'hamming');
        HDset(iris) = dist;
    
    
    end

HDsetmin(person) = min(HDset(iris))
    %disp (HDsetmin)

end
    [value,matchingperson] = min(HDsetmin)
    disp(matchingperson)
    
%%Question 16

HDset;
HDsetmin = zeros(1,20);

set_HDS = [];

for person = 1:20
    filename = strcat('data/person',sprintf('%02d',person),'.mat');
    data1 = load(filename);
    data1 = data1.iriscode;
    for iris = 1:size(data1,1)
        for i = 1:size(testdata)
            if (testdata(i) == 2)
                testdata(i) = []
                iris(i) = []
            end
        end
        dataSetS = [data1(iris,:); testdata];
        dist = pdist2(dataSetS(1,:),dataSetS(2,:),'hamming');
        set_HDS = [set_HDS  dist];   
    end
end

normcdf(min(HDsetmin),mean(set_HDS),sqrt(var(set_HDS)))

