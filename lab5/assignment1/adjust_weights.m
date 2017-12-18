function returnWeigths = adjust_weights(weights, point, label, lr)
    [~, I] = min(pdist2(weights(:,1:2),point));
    if label == weights(I,3)
        psi = 1;
    else 
        psi = -1;
    end
    returnWeigths = weights;
    returnWeigths(I,1:2) = weights(I,1:2) + lr * psi * (point - weights(I,1:2));
end
   