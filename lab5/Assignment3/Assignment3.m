%% Clear;

clear all;
close all;
%% Read data

a_data = load('data_lvq_A');
a_data = a_data.matA;

b_data = load('data_lvq_B');
b_data = b_data.matB;

%% LVQ

% Settings
num_epochs = 200;

% Learning Rate
lr = 0.01;

% Allocate array for results
% Attach label to data (0 for class A and 1 for 
% class B) and merge the sets
a_data(:,3) = 0;
b_data(:,3) = 1;
total_data = [a_data;b_data];


% Initialize weight vectors
%w_1 = [2, 4.5, 0];  %% Belongs to class A
%w_2 = [5, 6, 1];    %% Belongs to class B
%w_3 = [8, 4.5, 0];  %% Belongs to class A
%w_4 = [5, 4, 1];    %% Belongs to class B

w_1 = [mean(a_data(:,1)), mean(a_data(:,2)), 0];  %% Belongs to class A
w_2 = [mean(b_data(:,1)), mean(b_data(:,2)), 1];    %% Belongs to class B
% w_3 = [mean(a_data(:,1)), mean(a_data(:,2)), 0];  %% Belongs to class A
% w_4 = [mean(b_data(:,1)), mean(b_data(:,2)), 1];    %% Belongs to class B


% Put it all in 1 weight matrix
weights_1_1 = [mean(a_data(:,1)), mean(a_data(:,2)), 0; ...
               mean(b_data(:,1)), mean(b_data(:,2)), 1];
weights_2_1 = [mean(a_data(:,1))+rand(1,1), mean(a_data(:,2))+rand(1,1), 0; ...
               mean(a_data(:,1))-rand(1,1), mean(a_data(:,2))-rand(1,1), 0;
               mean(b_data(:,1)), mean(b_data(:,2)), 1];
weights_1_2 = [mean(b_data(:,1))+rand(1,1), mean(b_data(:,2))+rand(1,1), 1; ...
               mean(b_data(:,1))-rand(1,1), mean(b_data(:,2))-rand(1,1), 1;
               mean(a_data(:,1)), mean(a_data(:,2)), 0];
weights_2_2 = [mean(a_data(:,1))+rand(1,1), mean(a_data(:,2))+rand(1,1), 0; ...
               mean(a_data(:,1))-rand(1,1), mean(a_data(:,2))-rand(1,1), 0; ...
               mean(b_data(:,1))+rand(1,1), mean(b_data(:,2))+rand(1,1), 1; ...
               mean(b_data(:,1))-rand(1,1), mean(b_data(:,2))-rand(1,1), 1;];

first_prototype_over_time = zeros(2, num_epochs); 
           
errors = zeros(4, 200);
for it = 1:1
    if it == 1
        weights = weights_1_1;
    elseif it == 2
        weights = weights_2_1;
    elseif it == 3
        weights = weights_1_2;
    else
        weights = weights_2_2;
    end
    for epoch = 1:num_epochs
        for datapoint = 1:200
            current_point = total_data(datapoint,1:2);
            current_label = total_data(datapoint,3);
            weights = adjust_weights(weights, current_point, current_label, lr);
        end
        
        % Calculate error rate current epoch
        n_errors = 0;
        for datapoint = 1:200
            current_point = total_data(datapoint,1:2);
            current_label = total_data(datapoint,3);

            n_errors = n_errors + is_incorrect(weights, current_point, current_label);
        end
        errors(it,epoch) = n_errors / 200;
        first_prototype_over_time(1,epoch) = weights(2,1);        
        first_prototype_over_time(2,epoch) = weights(2,2);
    end
    if it == 1
        final_weights_1_1 = weights;
    elseif it == 2
        final_weights_2_1 = weights;
    elseif it == 3
        final_weights_1_2 = weights;
    else
        final_weights_2_2 = weights;
    end
end

%% %calculate the relevances 
figure(2);
hold on;
num_epochs = 20;



% Allocate array for results
% Attach label to data (0 for class A and 1 for 
% class B) and merge the sets
a_data(:,3) = 0;
b_data(:,3) = 1;
rel0 = zeros(1,200);
rel1 = zeros(1,200);
rel0(1) = 0.5;
rel1(1) = 0.5;
total_data = [a_data;b_data];

    for epoch = 1:num_epochs
        for datapoint = 1:200
            current_point = total_data(datapoint,1:2);
            current_label = total_data(datapoint,3);
            [rel0(datapoint), rel1(datapoint)] = adjust_relevances(weights,rel0(datapoint),rel1(datapoint), current_point, current_label, lr);
            rel0
            rel1
            plot(1:200,rel0(epoch),'--r')
            plot(1:200,rel1(epoch),'--g')  
            
        end
    end
hold off