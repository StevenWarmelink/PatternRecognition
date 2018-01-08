function plot_kmeans(input)
    % get number of clusters
    num_k = max(input(:,3));
    
    % plot in different colors
    hold on;
    for idx = 1:num_k
        % find idxs of current cluster
        current_idx = find(input(:,3)==idx);
        % take subset
        current_data = input(current_idx,1:2);
        % reconstruct current k_mean
        cur_mean = mean(current_data);
        
        % generate unique colors based on K
        col_grad = (idx - 1) / (num_k - 1);
        
        % plot data in unique color
        plot(current_data(:,1),current_data(:,2),'+','Color', [col_grad, 1 - col_grad, col_grad]);
        
        % plot k means in yellow diamonds
        plot(cur_mean(:,1),cur_mean(:,2),'kd','MarkerFaceColor','y');
    end
    title(['K = ',num2str(num_k)]);
    xlabel('Feature 1');
    ylabel('Feature 2');
    hold off;
end