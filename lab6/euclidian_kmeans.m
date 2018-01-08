function [ output, means_over_time ] = euclidian_kmeans(input, k)
    [rows, ~] = size(input);
    
    % sample K unique rows from input 
    k_idxs = randsample(rows, k);
    % use as initial k means
    k_means = input(k_idxs,:);
    
    % create output matrix with third row for labels
    output = input;
    output(:,3) = -1;
    
    no_change = false;
    means_over_time = k_means;
    
    % Main loop; perform while labels do not change
    while (~no_change)
        temp_output = output;
        
        % Assign new labels based on kmeans
        for datapoint = 1:rows
            current_point = input(datapoint,:);
            
            % create vector to save distances to all k_means
            distances = zeros(k,1);
            % compare current point to all k_means.
            for idx = 1:k
               distances(idx) = pdist2(current_point,k_means(idx,:)); 
            end
            
            % get index of minimum distance
            [~, I] = min(distances);
            % above index corresponds to kth mean -> assign label
            temp_output(datapoint,3) = I;
        end
        
        % update k_means
        for idx = 1:k
            indices = find(temp_output(:,3)==idx);
            k_means(idx,:) = mean(input(indices,:));
        end
        % check if any labels changed
        if temp_output == output
            no_change = true;
        end
        output = temp_output;
        means_over_time = [means_over_time; k_means];
    end
end