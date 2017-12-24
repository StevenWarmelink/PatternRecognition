%% Calculate 2D accumulator array

% Read and convert image to grayscale
img = imread('C:\Users\arjun\Desktop\PatternRecognition\labassignment4\Cameraman.tiff');
%img = rgb2gray(img);
% Calculate edge map for input
edgemap = edge(img,'Canny');

% Calculate 2D accumulator array
my_array = myhough(edgemap);


%% Plot comparison

% Use built-in hough function for comparison
[given_array, theta, rho] = hough(edgemap);

% normalize 2D accumulator arrays
H1 = my_array;
H1 = (H1-min(H1(:)))/max(H1(:));
H2 = given_array;
H2 = (H2-min(H2(:)))/max(H2(:));

% plot 2D hough arrays
subplot(1,2,1);
imshow(imadjust(H1), [], 'InitialMagnification','fit','ColorMap',hot);
title('result of myhough');
xlabel('\theta');
ylabel('\rho');
subplot(1,2,2);
imshow(imadjust(H2), [],'InitialMagnification','fit','ColorMap',hot);
title('result of MATLAB hough');
xlabel('\theta');
ylabel('\rho');