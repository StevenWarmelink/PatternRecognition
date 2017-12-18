function class = classify_point(point, weights)
    [~, I] = min(pdist2(weights(:,1:2),point));
    class = weights(I,3);
end