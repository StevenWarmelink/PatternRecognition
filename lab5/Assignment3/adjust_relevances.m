function [rel0 ,rel1] = adjust_relevances(weights,rel0, rel1 , point, label, lr)
 for i = 1 : size(weights(:,1),1)
     if (label == weights(i,3))
        psi = 1;
        if (weights(i,3) == 0)
           rel0 = rel0 - (lr * psi * pdist2(weights(i,1:2),point));
           rel1 = 1 - rel0;
        else
           rel1 = rel1 - (lr * psi * pdist2(weights(i,1:2),point));
           rel0 = 1 - rel1;
        end
    
    else
        psi = -1;
        if (weights(i,3) == 0)
           rel0 = rel0 - (lr * psi * pdist2(weights(i,1:2),point));
           rel1 = 1 - rel0;
        else
           rel1 = rel1 - (lr * psi * pdist2(weights(i,1:2),point));
           rel0 = 1 - rel1;
        end
    
    end
end

end
   

