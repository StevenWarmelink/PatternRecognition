function calculateJe(data, c1, c2)

% Calculate squared deviation from mean
sum_c1 = abs(data - c1).^2;
sum_c2 = abs(data - c2).^2;

% Sum squared deviations
total = sum_c1 + sum_c2;
total = sum(total,2);

% Print output
disp(total);
end