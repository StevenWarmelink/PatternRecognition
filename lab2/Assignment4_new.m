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