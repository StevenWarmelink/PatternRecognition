%% 
clear all;
close all;
%% Read Image
img = imread('C:\Users\arjun\Desktop\PatternRecognition\labassignment4\chess.jpg');

%% Convert the image to a greyscale from an RGB
img_grey =rgb2gray(img);

%% Canny algorithm (default params)
img_canny = edge(img_grey,'Canny');

%% Hough transform accumulator array
[hough_array, theta, rho] = hough(img_canny);

hold on;
imshow(imadjust(mat2gray(hough_array)), [],'XData', theta, ...
    'YData', rho, 'InitialMagnification','fit','colormap',hot);
title('accumulator array image');
xlabel('\theta (degrees)');
ylabel('\rho');
axis on;
axis normal;
P = houghpeaks(hough_array);
%P = houghpeaks(hough_array,5,'threshold',threshold);
x = theta(P(:,2)); y = rho(P(:,1));
plot(x,y,'s','color','green');
%ylim([min(rho), max(rho)]);
%xlim([min(theta), max(theta)]);

%% Getting the maxima from the accumulator array
P = houghpeaks(hough_array,1);
x = theta(P(:,2)); y = rho(P(:,1));
plot(x,y,'s','color','blue');
ylim([min(rho)- 5, max(rho) + 5]);
xlim([min(theta) - 5, max(theta) + 5]);

%% Fifteen largest points
P = houghpeaks(hough_array,15);
x = theta(P(:,2)); y = rho(P(:,1));
plot(x,y,'s','color','blue');
ylim([min(rho)- 5, max(rho) + 5]);
xlim([min(theta) - 5, max(theta) + 5]);
hold off;

%% chess.jpg with the 15 strongest lines overlaid
lines = houghlines(img_grey,theta,rho,P)
figure, imshow(img), hold on
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   
end