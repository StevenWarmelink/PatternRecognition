
%% Question 5

threshold = 0.15;
[rows, cols] = size(data);

% create empty clusters matrix of indices;
clusters = {};

for idx = 1:rows
    dist = pdist2(data(idx,:),data(idx+1:rows,:));
    
    low_idx = find(dist < threshold) + idx;
    clusters{idx} = low_idx;    
end

for idx1 = 1:rows-1
    vec1 = [];
    vec1 = [vec1 clusters{idx1}];
    oldlen = length(vec1);
    while true
       if ~isempty(vec1)
            subvec = [];
            for it = vec1
                subvec = [subvec clusters{it}];
            end
            vec1 = unique([vec1 subvec]);
       end
       newlen = length(vec1)
       

       % no change
       if newlen == oldlen
           clusters{idx1} = vec1;
           for idx2 = vec1
               clusters{idx2} = [];           
           end
           break;
       else 
           oldlen = newlen;
       end
    end
end

for i = 1:261
    hold on;
    cur_idx = clusters{i};
    if ~isempty(cur_idx)
       scatter(data(cur_idx,1),data(cur_idx,2)); 
    end
    hold off;
end


% scatter(data(:,1),data(:,2),6,'b','filled');
% title(['Threshold: ',num2str(threshold)]);
% xlabel('x-axis');
% ylabel('y-axis');
% hold off;
% 

