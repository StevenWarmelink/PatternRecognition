function output = KNN ( Coordinates, K, data, class_labels)
    minval = ones(1,K);
    minidxs = [];
    dist = zeros(1,length(data));

    for idx = 1:length(data)
        dist(idx) = norm(data(idx,:) - Coordinates);
    end 
    
    [B, I] = sort(dist,'ascend');
    total = class_labels(I(1:K));

    output = mode(total);
end
