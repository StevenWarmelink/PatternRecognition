% ground truth
GT = load ("C:\Users\arjun\Desktop\PatternRecognition\lab_assignment3\lab3_1")
GT = data.outcomes
P = nnz(GT); % number of positive responses in ground truth
N = nnz(1-GT);
% responses
R = imread('../../Downloads/matlab/data.tif');
% your thresholds
thresholds = [0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8];
% alternatively, use 100 thresholds between min(R) and max(R)
% thresholds = linspace(min(R(:)), max(R(:)));
% pre-allocate for speed
tp = nan(1, length(thresholds));
fp = nan(1, length(thresholds));
for i = 1:numel(thresholds)
  t = thresholds(end-i+1); % thresholds from high to low as i increases
  Rt = R > t; % thresholded response
  tp(i) = nnz(Rt & GT);
  fp(i) = nnz(Rt & ~GT);
end
% convert to rates
TPR = tp/P;
FPR = fp/N;
plot(FPR, TPR) % ROC