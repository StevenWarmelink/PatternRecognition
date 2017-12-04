%% Decision Boundary Plots


format long;

clear;
clf;


%%normdist 1 specs
meanVec1 = [ 3 5 ];
covMat1  = [ 1 0 ;
             0 4 ];
        
meanVec2 = [ 2 1 ];
covMat2  = [ 2 0 ;
             0 1 ];
                

% based on example on https://nl.mathworks.com [...
% /help/stats/multivariate-normal-distribution.html
[X1, X2] = meshgrid(-10:0.1:20, -10:0.1:20);        
G1 = mvnpdf([X1(:) X2(:)],meanVec1,covMat1);
G1 = reshape(G1,length(X1),length(X2));
mesh((-10:.1:20),(-10:.1:20),G1);
hold on;
G2 = mvnpdf([X1(:) X2(:)],meanVec2,covMat2);
G2 = reshape(G2,301,301);
mesh((-10:.1:20),(-10:.1:20),G2);

syms x y;
eqn = -0.25*(x^2) + 0.375*(y^2) + 2*x -0.25*y -7.3188 == 0;
sol = solve(eqn, y);
%result = solve(-0.25*(x^2) + 0.375*(y^2) + 2*x -0.25*y -7.3188 == 0,y);

ConcreteSol = subs(sol(1,:), 'x', X1);
line(X1, real(ConcreteSol(1,:)), 'Color', 'k');
line(X1, real(ConcreteSol(2,:)), 'Color', 'k');

title('Two-dimensional Gaussian pdf with mean [3;4] Covariance Matrix [1 0; 0 2]'); 
