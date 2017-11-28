%% init
clear;
people = zeros(1,1000000);

%%

for person = 1:1000000
    for epoch = 1:100
        res = randi(2);
        if res == 1
            people(person) = people(person) + 1;
        end
   end
end

%%
histogram(people);
axis([0 100 0 80000]);
title('End scores after 100 coin tosses');
xlabel('score (number of times tails)')
ylabel('Number of people (out of 1000000)');

%%
% Note: not Matlab code. 
% variance = 1 / n * sum[i=1:n](x_i - x_avg)^2

% (x_i - x_avg)^2 is always 1/4
% so variance = 1/100 * (100* 1/4)
%    variance = 1/100 * 25
variance = 25/100;
disp(variance);

%% plot normdist to verify
x = 0:0.01:1;
f = normpdf(x,0.5,sqrt(0.25));
plot(x,f);
axis([0 1 0 1]);

