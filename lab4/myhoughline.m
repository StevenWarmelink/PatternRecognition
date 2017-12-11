function myhoughline(image, rho, theta)
    figure();
    hold on;
    x = -100000:1:100000;
    y = (rho - (x * cosd(theta))) / sind(theta);
    xlim([0 255]);
    ylim([0 255]);
    imshow(image);
    if theta == 0
        line([rho rho],[0 255],'Color','red');
    else
        line([x(1) x(end)],[y(1) y(end)],'Color','red');
    end
    hold off;
end