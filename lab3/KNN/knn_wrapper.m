%% Options
clear all;
load lab3_2.mat;

K=7;
samples=64;
data = lab3_2;
nr_of_classes = 4;
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );
%% Generate plot for given K

% Sample the parameter space
result=zeros(samples);
for i=1:samples
  X=(i-1/2)/samples;
  for j=1:samples
    Y=(j-1/2)/samples;
    result(j,i) = KNN([X Y],K,data,class_labels);
  end;
end;

% Show the results in a figure
figure(1);
imshow(result,[0 nr_of_classes-1],'InitialMagnification','fit')
hold on;
title([int2str(K) '-NN, ' int2str(nr_of_classes) ' classes']);

% this is only correct for the first question
scaled_data=samples*data;
if nr_of_classes == 2
    plot(scaled_data(  1:100,1),scaled_data(  1:100,2),'go');
    plot(scaled_data(101:200,1),scaled_data(101:200,2),'r+');
else
    plot(scaled_data(  1:50,1),scaled_data(  1:50,2),'go');
    plot(scaled_data( 51:100,1),scaled_data(  51:100,2),'cs');
    plot(scaled_data(101:150,1),scaled_data(101:150,2),'y+');
    plot(scaled_data(151:200,1),scaled_data(151:200,2),'bd');
end
hold off;


%% LOOCV

% Sample the parameter space
K_vals = 1:2:25;
e_rates = zeros(length(K_vals),1);
for k_val = 1:length(K_vals)
    numerrors = 0;
    for datapoint = 1:length(data)
        loc_dat = data;
        loc_dat(datapoint,:) = [];
        loc_lab = class_labels;
        loc_lab(datapoint) = [];
        result = KNN(data(datapoint,:),K_vals(k_val),loc_dat,loc_lab);
        if class_labels(datapoint) ~= result
            numerrors = numerrors + 1;
        end
    end
    error_rate = numerrors / length(data);
    e_rates(k_val) = error_rate;
end;
[B I] = min(e_rates);
figure(2);
plot(K_vals,e_rates);
xlabel('Number of neighbours (K) in KNN');
ylabel('Error rate');
title(['KNN Error rate using LOOCV for different K with ',num2str(nr_of_classes),' class(es)']);

min_K = K_vals(I(1))
min_error = min(e_rates)

%% Assignment 3 - KNN - parzen with 3D data
clear all;
load lab3_3_cat1;
load lab3_3_cat2;
load lab3_3_cat3;

K = 1;

nr_of_classes = 3;

data = [x_w1; x_w2; x_w3]; 

class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

% U
%input = [0.5 1.0 0.0];
% V
%input = [0.31 1.51 -0.50];
% W
input = [-1.7 -1.7 -1.7];

res = KNN(input, K, data, class_labels)

%% INCLUDED KNN FUNCTION - since we have to upload both the entire script and the KNN function

% - should be in separate file named KNN.m
function output = KNN ( Coordinates, K, data, class_labels)
    dist = pdist2(Coordinates, data); 
    [~, I] = sort(dist,'ascend');
    output = mode(class_labels(I(1:K)));
end
