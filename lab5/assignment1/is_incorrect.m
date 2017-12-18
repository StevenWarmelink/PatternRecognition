function error = is_incorrect(weights, point, label)
    [~, I] = min(pdist2(weights(:,1:2),point));
    if label ~= weights(I,3)
        error = 1;
    else
        error = 0;
    end
end