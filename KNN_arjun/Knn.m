function [output,dataset] = Knn ( k,data,prototype)
me = zeros(k,2);  
        for j = 1:size(prototype,1)
                for i = 1:size(data,1)
                    dist(j,i) = pdist2(prototype(j,:), data(i,:));
                end
        end
        for i = 1:size(data,1)
            [~,idx]=min(dist(:,i));
            data(i,3) = idx;
        end
    % calculating the means of each cluster

    for i = 1:k
        i
        temp= data(data(:,3)== i,:);
        temp(:,3) = [];
        me(i,:) = mean(temp)
    end
    output = me(:,:);
    dataset = data(:,:);
end
