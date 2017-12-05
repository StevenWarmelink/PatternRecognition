function output = KNN ( Coordinates, K, data, class_labels)
    dist = pdist2(Coordinates, data); 
    [~, I] = sort(dist,'ascend');
    output = mode(class_labels(I(1:K)));
end
