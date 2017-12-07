clear all;
load lab3_2.mat;

K=3;
samples=64;
data = lab3_2;
nr_of_classes = 2;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

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
imshow(result,[0 nr_of_classes-1],'InitialMagnification','fit')
hold on;
title([int2str(K) '-NN, ' int2str(nr_of_classes) ' classes']);

% this is only correct for the first question
scaled_data=samples*data;
plot(scaled_data(  1:100,1),scaled_data(  1:100,2),'go');
plot(scaled_data(101:200,1),scaled_data(101:200,2),'r+');

%% LOOCV for k = 3;

clear all;
load lab3_2.mat;

K=3;
samples=64;
data = lab3_2;
nr_of_classes = 2;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

% Sample the parameter space
K_vals = 1:1:25;
e_rates = zeros(length(K_vals),1);
for k_val = 1:length(K_vals)
    numerrors = 0;
    for datapoint = 1:length(data)
        loc_dat = reshape(data, [200, 2]);
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
    K_vals(k_val)
end;
[B I] = min(e_rates);
figure();
plot(K_vals,e_rates);
xlabel('K values');
ylabel('Error rate');
title({'KNN classification rate using LOOCV','for different K with 2 classes'});
%% 4 classes!!!

clear all;
load lab3_2.mat;

K=7;
samples=64;
data = lab3_2;
nr_of_classes = 4;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

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
imshow(result,[0 nr_of_classes-1],'InitialMagnification','fit')
hold on;
title([int2str(K) '-NN, ' int2str(nr_of_classes) ' classes']);

% this is only correct for the first question
scaled_data=samples*data;
plot(scaled_data(  1:50,1),scaled_data(  1:50,2),'go');
plot(scaled_data( 51:100,1),scaled_data(  51:100,2),'cs');
plot(scaled_data(101:150,1),scaled_data(101:150,2),'y+');
plot(scaled_data(151:200,1),scaled_data(151:200,2),'bd');

%% LOOCV for 4 classes 

clear all;
load lab3_2.mat;

K=3;
samples=64;
data = lab3_2;
nr_of_classes = 4;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

% Sample the parameter space
K_vals = 1:1:25;
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
    K_vals(k_val)
end;
[B I] = min(e_rates);
K_vals(I)
plot(K_vals,e_rates);
xlabel('K values');
ylabel('Error rate');
title({'KNN classification rate using LOOCV','for different K with 4 classes'});
