%% Clear;

clear all;
close all;
%% Read data

a_data = load('data_lvq_A');
a_data = a_data.matA;

b_data = load('data_lvq_B');
b_data = b_data.matB;

%% Create combined scatter plot
figure(1);
hold on;
scatter(a_data(:,1),a_data(:,2),'MarkerFaceColor', ...
    [1 0 0], 'MarkerEdgeColor',[0 0 0]);
scatter(b_data(:,1),b_data(:,2),'MarkerFaceColor', ...
    [0 0 1], 'MarkerEdgeColor',[0 0 0]);
xlabel('Feature 1');
ylabel('Feature 2');
legend('Class A','Class B');
title('Scatter plots of classes A and B');
hold off;

%% LVQ1

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
for it = 1:4
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

%% Error Plot
figure(2);
hold on;
plot(1:200,errors(2,:),'Color','blue');
title('Error rate for 2 A prototypes and 1 B prototype');
xlabel('Epoch');
ylabel('Error Rate');
xlim([0 200]);
ylim([0 1]);
hold off;

%% Error Plot (2)
figure(3);
hold on;
plot(1:200,errors(1,:),'Color','red');
plot(1:200,errors(2,:),'Color','blue');
plot(1:200,errors(3,:),'Color', 'green');
plot(1:200,errors(4,:),'Color', 'black');
legend('1A 1B','2A 1B', '1A 2B', '2A 2B');
xlabel('Epoch');
ylabel('Error Rate');
xlim([0 200]);
ylim([0 1]);
hold off;

%% Prototype Movement plot

figure(1);
hold on;
scatter(a_data(:,1),a_data(:,2),'MarkerFaceColor', ...
    [1 0 0], 'MarkerEdgeColor',[0 0 0]);
scatter(b_data(:,1),b_data(:,2),'MarkerFaceColor', ...
    [0 0 1], 'MarkerEdgeColor',[0 0 0]);
for part = 1:200
   scatter(first_prototype_over_time(1,part),first_prototype_over_time(2,part), ...
           'filled', 'MarkerFaceAlpha',1/part,'MarkerFaceColor',[1-(part/200) 1 0]);  
end
xlabel('x');
ylabel('y');
legend('Class A','Class B');
title('Scatter plots of classes A and B');
hold off;

%% Plot data according to prototypes
figure(4);
subplot(2,2,1);
hold on;

% Plot 1_1
weight = final_weights_1_1;
classes = zeros(1,200);
for row = 1:200
    classes(row) = classify_point(total_data(row,1:2),weight);
end

a_indices = find(classes == 1);
b_indices = find(classes == 0);
scatter(total_data(a_indices,1), total_data(a_indices,2), 'MarkerFaceColor', ...
[0 0 1], 'MarkerEdgeColor', [0 0 0]);

scatter(total_data(b_indices,1), total_data(b_indices,2), 'MarkerFaceColor', ...
[1 0 0], 'MarkerEdgeColor', [0 0 0]);
title('1 - 1');
xlabel('Feature 1');
ylabel('Feature 2');
legend('Class B','Class A');
scatter(final_weights_1_1(:,1),final_weights_1_1(:,2),'gd','filled');
hold off;

% Plot 1_2
subplot(2,2,2);
hold on;
weight = final_weights_1_2;
classes = zeros(1,200);
for row = 1:200
    classes(row) = classify_point(total_data(row,1:2),weight);
end

a_indices = find(classes == 1);
b_indices = find(classes == 0);
scatter(total_data(a_indices,1), total_data(a_indices,2), 'MarkerFaceColor', ...
[0 0 1], 'MarkerEdgeColor', [0 0 0]);

scatter(total_data(b_indices,1), total_data(b_indices,2), 'MarkerFaceColor', ...
[1 0 0], 'MarkerEdgeColor', [0 0 0]);
title('1 - 2');
xlabel('Feature 1');
ylabel('Feature 2');
legend('Class B','Class A');
scatter(final_weights_1_2(:,1),final_weights_1_2(:,2),'gd','filled');
hold off;

% Plot 2_1
subplot(2,2,3);
hold on;
weight = final_weights_2_1;
classes = zeros(1,200);
for row = 1:200
    classes(row) = classify_point(total_data(row,1:2),weight);
end

a_indices = find(classes == 1);
b_indices = find(classes == 0);
scatter(total_data(a_indices,1), total_data(a_indices,2), 'MarkerFaceColor', ...
[0 0 1], 'MarkerEdgeColor', [0 0 0]);

scatter(total_data(b_indices,1), total_data(b_indices,2), 'MarkerFaceColor', ...
[1 0 0], 'MarkerEdgeColor', [0 0 0]);
title('2 - 1');
xlabel('Feature 1');
ylabel('Feature 2');
legend('Class B','Class A');    
scatter(final_weights_2_1(:,1),final_weights_2_1(:,2),'gd','filled');
hold off;

% Plot 2_2
subplot(2,2,4);
hold on;
weight = final_weights_2_2;
classes = zeros(1,200);
for row = 1:200
    classes(row) = classify_point(total_data(row,1:2),weight);
end

a_indices = find(classes == 1);
b_indices = find(classes == 0);
scatter(total_data(a_indices,1), total_data(a_indices,2), 'MarkerFaceColor', ...
[0 0 1], 'MarkerEdgeColor', [0 0 0]);

scatter(total_data(b_indices,1), total_data(b_indices,2), 'MarkerFaceColor', ...
[1 0 0], 'MarkerEdgeColor', [0 0 0]);

title('2 - 2');
xlabel('Feature 1');
ylabel('Feature 2');
legend('Class B','Class A');
scatter(final_weights_2_2(:,1),final_weights_2_2(:,2),'gd','filled');
hold off;