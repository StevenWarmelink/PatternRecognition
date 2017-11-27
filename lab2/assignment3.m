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


% Mahalanobis Distance ?!?!?!?!?!?!?!
d_1010 = mahal([10 10]', meanVec');
disp(d_1010);

d_0_0 = mahal([0 0]', meanVec');
disp(d_0_0);

d_3_4 = mahal([3 4]', meanVec');
disp(d_3_4);

d_6_8 = mahal([6 8]', meanVec');
disp(d_6_8);