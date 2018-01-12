function [prototypes] = batchNG(Data, n, epochs, xdim, ydim)
    % Batch Neural Gas
    %   Data contains data,
    %   n is the number of clusters,
    %   epoch the number of iterations,
    %   xdim and ydim are the dimensions to be plotted, default xdim=1,ydim=2

    error(nargchk(3, 5, nargin));  % check the number of input arguments
    if (nargin<4)
      xdim=1; ydim=2;   % default plot values
    end;

    [dlen,dim] = size(Data);

    % Load and Set Prototypes
    sbrace = @(x,y)(x{y});
    fromfile = @(x)(sbrace(struct2cell(load(x)),1));
    prototypes=fromfile('clusterCentroids.mat');

    % Neighnourhood values
    lambda0 = n/2;
    lambda = lambda0 * (0.01/lambda0).^([0:(epochs-1)]/epochs);

    %% Action
    for i=1:epochs
        D_prototypes = zeros(n,dim);   % difference for vectors is initially zero
        D_prototypes_av = zeros(n,1);  % the same holds for the quotients

        for j=1:dlen  % consider all points at once for the batch update

            % sample vector
            x = Data(j,:); % sample vector
            X = x(ones(n,1),:);  % we'll need this

            % Calculate Distances
            dists = pdist2(x,prototypes, 'squaredeuclidean');

            % dist_idx is a vector of indices of prototypes, such that the first 
            % element of dist_idx is the index in prototypes for which the distance
            % between x and a prototype is the smallest. rank_idx is a vector of 
            % ranks of prototypes. i.e., the first element of rank_idx contains 
            % the rank of the first element of prototypes etc.
            [~, dist_idx] = sort(dists);
            [~, rank_idx] = sort(dist_idx);

            % Find ranking
            ranks = (1:n)';
            ranks = ranks(rank_idx);

            % Calculate exponent
            exponent = exp(-ranks/lambda(i));

            % Accumulate 
            D_prototypes(:,1) = D_prototypes(:,1) + (exponent * x(:,1));
            D_prototypes(:,2) = D_prototypes(:,2) + (exponent * x(:,2));

            D_prototypes_av = D_prototypes_av + exponent;
        end
        
        % Normalize prototypes
        D_prototypes(:,1) = D_prototypes(:,1) ./ D_prototypes_av;
        D_prototypes(:,2) = D_prototypes(:,2) ./ D_prototypes_av;

        % Update prototypes
        prototypes = D_prototypes;

        % Plot results
        fprintf(1,'%d / %d \r',i,epochs);
        hold off
        plot(Data(:,xdim),Data(:,ydim),'bo','markersize',3)
        hold on
        plot(prototypes(:,xdim),prototypes(:,ydim),'r.','markersize',10,'linewidth',3)

        % Decision Boundaries
        voronoi(prototypes(:,1),prototypes(:,2));

        drawnow
    end
    
end