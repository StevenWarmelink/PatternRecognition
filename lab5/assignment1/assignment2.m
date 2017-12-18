%% Clear;

clear all;
close all;
%% Generate folds

% Divide data into 10 folds
fold_data = generateFolds();

errors = zeros(1,10);

for fold = 1:10
    weights      = train_network(fold_data(setdiff(1:end,fold)));
    errors(fold) = test_network(fold_data(fold), weights);
end
    
%% Plot errors
figure(1);
bar_fig = bar(1:10, errors);
xlabel('Fold');
ylabel('Error Rate');
title('Cross-validated error rate for LVQ1');
ylim([0 1]);
hold on;
me  = mean(errors);
sde = sqrt(var(errors));

for i = 1:numel(errors)
    text(i - 0.3, errors(i) + 0.05, [num2str(errors(i))], 'VerticalAlignment', 'top', 'FontSize', 8)
end

text(10, me+0.02, ['\mu = ', num2str(me,2)]);
text(10, me+sde+0.02, ['\sigma = ', num2str(sde,2)]);

plot(xlim,[me me], 'r');
plot(xlim,[me + sde me + sde], 'b');
plot(xlim,[me - sde me - sde], 'b');
hold off;