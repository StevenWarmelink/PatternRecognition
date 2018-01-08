%% clear workspace
clear all;
close all;

%% Read input
input = load('data/kmeans1');
input= input.kmeans1;

%% Option(s)
% K values used
k_vals = [2 4 8];

% Plot arrows?
plotArrows = true;

%% Calculate kmeans for various K and plot results
figure(1);
for idx = 1:length(k_vals)
   [output, means_over_time] = euclidian_kmeans(input,k_vals(idx));
   subplot(length(k_vals),1,idx);
   plot_kmeans(output);
   
   if plotArrows
   
       [rows, ~] = size(means_over_time);

       % how many steps did it take to converge?
       n_steps = rows / k_vals(idx);

       hold on;
       for cur_k = 1:k_vals(idx)
          p1 = means_over_time(cur_k,:);
          p2 = means_over_time(cur_k + k_vals(idx),:);
          plot_arrow(p1(1), p1(2), p2(1), p2(2));

          % for the current K values in the vector..
          k_idx = cur_k + k_vals(idx);
          while (k_idx + k_vals(idx) < rows)
              p1 = means_over_time(k_idx,:);
              k_idx = k_idx + k_vals(idx);
              p2 = means_over_time(k_idx,:);
              plot_arrow(p1(1), p1(2), p2(1), p2(2));      
          end
       end
   end
end

