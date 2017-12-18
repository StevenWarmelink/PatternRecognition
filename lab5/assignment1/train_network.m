function weights = train_network(data)

    % Set maximum number of epochs
    num_epochs = 200;
    % Learning Rate
    lr = 0.01;

    total_data = zeros(180,3);
    
    % Combine data
    for fold = 1:9
        total_data((1:10) + (fold-1) * 20, 1:2) = data(fold).a_dat;
        total_data((1:10) + (fold-1) * 20, 3) = 0;
        total_data((11:20) + (fold-1) * 20, 1:2) = data(fold).b_dat;
        total_data((11:20) + (fold-1) * 20, 3) = 1;
    end
    
    % Calculate means for initialization
    a_data = load('data_lvq_A');
    a_data = a_data.matA;
    b_data = load('data_lvq_B');
    b_data = b_data.matB;
    %w_1 = [mean(a_data(:,1)), mean(a_data(:,2)), 0];  %% Belongs to class A
    %w_2 = [mean(b_data(:,1)), mean(b_data(:,2)), 1];    %% Belongs to class B
    %weights = [w_1; w_2];
    
    %2-1
    weights = [mean(a_data(:,1))+rand(1,1), mean(a_data(:,2))+rand(1,1), 0; ...
               mean(a_data(:,1))-rand(1,1), mean(a_data(:,2))-rand(1,1), 0;
               mean(b_data(:,1)), mean(b_data(:,2)), 1];

    for epoch = 1:num_epochs
        for datapoint = 1:180
            current_point = total_data(datapoint,1:2);
            current_label = total_data(datapoint,3);
            weights = adjust_weights(weights, current_point, current_label, lr);
        end
    end
end