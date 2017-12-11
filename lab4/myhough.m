function [acc_mat] = myhough(edgemap) 

    [height, width] = size(edgemap);
    % Calculate image diagonal (for rho)
    imgDiagonal = floor(sqrt((height^2)+(width^2)));

    % Set rho and theta to discrete range
    thetas      = -89:1:90;
    rhos        = -imgDiagonal:1:imgDiagonal;

    % Initialize empty accumulator matrix
    acc_mat = zeros(length(rhos),length(thetas));

    % Loop over all pixels in edgemap
    for y_idx = 1:height
        for x_idx = 1:width
            % If there is a nonzero-value
            % (there is a foreground pixel)
            if (edgemap(y_idx,x_idx) ~= 0)
                % Loop over all thetas
                for theta_idx = 1:length(thetas)
                    % Calculate all rho for given thetas
                    dist = x_idx*cosd(thetas(theta_idx)) + y_idx*sind(thetas(theta_idx));
                    
                    % get the rho index for the closest rho
                    [d, rho_idx] = min(abs(rhos-dist));
                    
                    % if the distance is less than or equal to one:
                    if d <= 1
                        % increment the accumulator array at point 
                        % (rho_idx,theta_idx)
                        acc_mat(rho_idx,theta_idx) = acc_mat(rho_idx,theta_idx) + 1;
                    end
                end
            end
        end
    end
end