%% Assignment 6
clear all;
close all;

%% Reading the image
img = imread('C:\Users\arjun\Desktop\PatternRecognition\labassignment4\dogGrayRipples.png');

%% Applying fourier transform

frequencyImage = fftshift(fft2(img));
amplitudeImage = log(abs(frequencyImage));
% Obtaining the maximum frequency
maxValue = max(max(amplitudeImage));
imshow(amplitudeImage, []);
title('Frequency Image');

%% Reducing frequencies corresponding to the noise in the image

[mid_X, mid_Y] = find(amplitudeImage == maxValue);
filterWindow = 9;
for row = mid_Y-filterWindow:mid_Y+filterWindow
	for column = mid_X-filterWindow:mid_X+filterWindow
		frequencyImage(row+15, column+17) = 0;
		frequencyImage(row-50, column+17) = 0;
	end
end

amplitudeImage2 = log(abs(frequencyImage));
minValue = min(min(amplitudeImage2));
maxValue = max(max(amplitudeImage2));
imshow(amplitudeImage2, [minValue maxValue]);

%% Displaying the filterd image after applying inverse fourier transform

filteredImage = ifft2(fftshift(frequencyImage));
amplitudeImage3 = abs(filteredImage);
minValue = min(min(amplitudeImage3));
maxValue = max(max(amplitudeImage3));
imshow(amplitudeImage3, [minValue maxValue]);
title('Final image after inverse fourier');
