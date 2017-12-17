clear all;
close all;

%% Read Image
img = imread('C:\Users\arjun\Desktop\PatternRecognition\labassignment4\Cameraman.tiff');

%% Canny algorithm (default params)
img_canny = edge(img,'Canny');

%% Hough transform accumulator array(?)
[hough_array, theta, rho] = hough(img_canny);

%% Make image and label axis
% Based on info from slides 'Recognition by 
% transform'. 
figure(1);
hold on;
imshow(imadjust(mat2gray(hough_array)), [],'XData', theta, ...
    'YData', rho, 'InitialMagnification','fit','ColorMap',hot);
title('Hough transform of Cameraman.tiff');
xlabel('\theta (degrees)');
ylabel('\rho');
axis on;
axis normal;
max_res = max(max(hough_array));
threshold = 0.999 * max_res;
P = houghpeaks(hough_array,1);
x = theta(P(:,2)); y = rho(P(:,1));
plot(x,y,'s','color','green');
ylim([min(rho), max(rho)]);
xlim([min(theta), max(theta)]);
%colormap(gca,hot);
hold off;
%% Threshold accumulator array
max_res = max(max(hough_array));
threshold = 0.999 * max_res;
threshold_hough = hough_array * 0;
max_idx = find(hough_array >= threshold);
threshold_hough(max_idx) = hough_array(max_idx); 

%% Display thresholded image
figure(2);
hold on;
imshow(threshold_hough, [],'XData', theta, ...
    'YData', rho, 'InitialMagnification','fit');
title('Thresholded image');
xlabel('\theta (degrees)');
ylabel('\rho');
axis on;
axis normal;
P = houghpeaks(hough_array,5,'threshold',threshold);
x = theta(P(:,2)); y = rho(P(:,1));
plot(x,y,'s','color','green');
ylim([min(rho), max(rho)]);
xlim([min(theta), max(theta)]);
hold off;

%% Local maximum
local_max = max(max(threshold_hough));

%% 5 local maxima accumulator array;
[B, I] = sort(reshape(hough_array,1,(723*180)),'descend');
five_local_max = I(1:5);

%% Threshold accumulator array
five_largest = hough_array * 0;
five_largest(I(1:5)) = B(1:5);
% Display thresholded image
figure(3);
hold on;
imshow(five_largest, [],'XData', theta, ...
    'YData', rho, 'InitialMagnification','fit');
title('Five local maxima');
xlabel('\theta (degrees)');
ylabel('\rho');
axis on;
axis normal;
P = houghpeaks(hough_array,5);
x = theta(P(:,2)); y = rho(P(:,1));
plot(x,y,'s','color','green');
ylim([min(rho), max(rho)]);
xlim([min(theta), max(theta)]);
hold off;



%% 
[ M I1 ] = max(hough_array(:));
[ X Y ] = ind2sub(size(hough_array),I1);
myhoughline(img, rho(X),theta(Y));
