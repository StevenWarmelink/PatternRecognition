%% 
clear all;
close all;
%% Read the image 'HeadTool10002.bmp' and convert it to double precision
img = imread('C:\Users\arjun\Desktop\PatternRecognition\labassignment4\HeadTool0002.bmp');
I2 = im2double(img);

%% contrast-limited adaptive histogram equalization
img_final = adapthisteq(I2);
figure, imshow(img_final), hold on
%% finding atleast 6 circles without repetition
[centers,radii] = imfindcircles(img_final,[20 40],'sensitivity',0.93);
disp(centers);
%disp(radii);

idx = ones(size(radii));

min_dist = 2;
for i = 2:length(radii)
    cur_cent = centers(i, :);
    for j = 1:i-1
        other_cent = centers(j,:);
        x_dist = other_cent(1) - cur_cent(1);
        y_dist = other_cent(2) - cur_cent(2);
        if sqrt(x_dist^2+y_dist^2) < min_dist*(radii(i) + radii(j)) && idx(j) == 1
            idx(i) = 0;
            break
        end
    end
end

idx = logical(idx);
centers_use = centers(idx, :);
radii_use = radii(idx, :);
viscircles(centers_use, radii_use,'EdgeColor','b');
x = centers(:,1); 
y = centers(:,2);
plot(x,y,'s','color','blue');
hold off

%% Best two circles

[centers,radii] = imfindcircles(img_final,[20 40],'sensitivity',0.93);
disp(centers);

centers_best2 = centers(1:2,:);
radii_best2 = radii(1:2);
viscircles(centers_best2, radii_best2,'EdgeColor','b');
hold off

