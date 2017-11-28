%%Function to calculate the cointoss
people = zeros(1,1000000);
counter = 1:20;
for i = 1:1000000
    for j = 1:100
        toss  = randi(10,1,1);
        if toss > 5
            %consider the scenario as tails.
            people(i) = people(i) + 1;
        elseif toss <= 10
            %consider the scenario as heads.
            break
        end
        
    end

end

for i = 1:20
    counter(i) = sum(people == i);    
end

plot (counter,'k')
title({'Random Walk'});
ylabel('count of people');
xlabel('values');

%%

        
        
    