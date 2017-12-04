%% Assignment 3 | Gaussian Plot

format long;

clear;
clf;

meanVec = [ 3 4 ];
covMat  = [ 1 0 ;
            0 2 ];
        
        
% based on example on https://nl.mathworks.com [...
% /help/stats/multivariate-normal-distribution.html
[X1, X2] = meshgrid(-10:0.1:10, -10:0.1:10);        
F = mvnpdf([X1(:) X2(:)],meanVec,covMat);
F = reshape(F,201,201);
surf((-10:.1:10),(-10:.1:10),F);
title('Two-dimensional Gaussian pdf with mean [3;4] Covariance Matrix [1 0; 0 2]'); 

%%
% Mahalanobis Distance ?!?!?!?!?!?!?!
covMat  = [ 1   0 ;
            0   2 ];
meanVec = [ 3 ; 4 ];

% x = [ 10 ;
%       10 ];
X = [10;10];
mahaldist = sqrt((X-meanVec)' * inv(covMat) * (X-meanVec));
disp(mahaldist);


% x = [ 0 ;
%       0 ];
X = [0;0];
mahaldist = sqrt((X-meanVec)' * inv(covMat) * (X-meanVec));
disp(mahaldist);

% x = [ 3 ;
%       4 ];
X = [3;4];
mahaldist = sqrt((X-meanVec)' * inv(covMat) * (X-meanVec));
disp(mahaldist);

% x = [ 6 ;
%       8 ];
X = [6;8];
mahaldist = sqrt((X-meanVec)' * inv(covMat) * (X-meanVec));
disp(mahaldist);