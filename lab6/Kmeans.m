function [output,dataset] = Kmeans ( k,data,prototype,flag)
    if (flag) 
        % execute K-means ++
        Dis = zeros(1000,1);
        prob = zeros(1000,1);
                for i = 1:size(data,1)
                   Dis(i) = min(pdist2(data(i,:),prototype(:,1:2)));
                end
        % selecting the new prototype based on the probability distribution
        Dis(i) = Dis(i)^2;
        total = sum(Dis);
        for i = 1 : size(data,1)
            prob(i)  = Dis(i)/total;
        end
        
        output = data(find(rand<cumsum(prob),1),:);
    else
    % execute K-means
        me = zeros(k,3);  
                for i = 1:size(data,1)
                    [~,idx] = min( pdist2(data(i,1:2),prototype(:,1:2)));
                    data(i,3) = idx;
                end

    % calculating the means of each cluster

    for i = 1:k
        if (data(data(:,3) == i))
            me(i,:) = mean(data(data(:,3)== i,:));
            me(i,3) = i;
        end
    end
    output = me(:,:);
    dataset = data(:,:);        
   end
end
