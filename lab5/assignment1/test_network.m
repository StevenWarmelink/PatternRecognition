function errors = test_network(data, weights)
    
    n_errors = 0;
    for datapoint = 1:10
        current_a_point = data.a_dat(datapoint,1:2);
        current_a_label = 0;
        current_b_point = data.b_dat(datapoint,1:2);
        current_b_label = 1;
        
        n_errors = n_errors + is_incorrect(weights, current_a_point, current_a_label);
        n_errors = n_errors + is_incorrect(weights, current_b_point, current_b_label);
    end
    errors = n_errors / 20;
end