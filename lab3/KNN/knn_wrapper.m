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
result    = zeros(samples);
subresult = zeros(samples);
min_error = 10;
min_idx = 0;
for datapoint = 1:length(data)
    numerrors = 0;
    for i=1:samples
    X=(i-1/2)/samples;
        for j=1:samples
            Y=(j-1/2)/samples;
            loc_dat = reshape(data, [200, 2]);
            loc_lab = class_labels;
            loc_dat(datapoint,:) = [];
            loc_lab(datapoint) = [];
            subresult(j,i) = KNN(data(datapoint,:),K,loc_dat,loc_lab);
            if class_labels(datapoint) ~= subresult(j,i)
                numerrors = numerrors + 1;
            end
        end
    end;
    error_rate = numerrors / length(data);
    if error_rate < min_error
        min_error = error_rate;
        min_idx   = datapoint;
    end
    disp(datapoint);
end;
disp(min_error);
disp(min_idx);
