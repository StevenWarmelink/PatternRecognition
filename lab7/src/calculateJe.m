function calculateJe(c1, c2, m1, m2)

% Initialize variables for saving error per cluster
sum_c1 = 0;
sum_c2 = 0;

[rows1, ~] = size(c1);
[rows2, ~] = size(c2);

% Calculate squared deviation from mean
for point = 1:rows1
    sum_c1 = sum_c1 + pdist2(c1(point,:),m1,'squaredeuclidean');
end
for point = 1:rows2
    sum_c2 = sum_c2 + pdist2(c2(point,:),m2,'squaredeuclidean');
end

% Sum squared deviations
total = sum_c1 + sum_c2;

% Print output
disp(total);
end