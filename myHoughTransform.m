function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
    img = Im';
    [rows_img, cols_img] = size(img);
    
    rhoMax = ceil(norm([rows_img, cols_img])/rhoRes);
    
    rhos = rhoMax + 1; 
    thetas = 2.0*pi / thetaRes;
    H = zeros([rhos, thetas]);
    
    rhoScale = (0:rhoRes:(rhoRes*rhoMax));
    num_rhos = [rhoScale - 0.5*rhoRes, rhoRes*rhoMax + 0.5*rhoRes];
    
    i = 1:thetas;
    thetaScale = (thetaRes * (i-1));
    
    img_size = size(img);
    index = find(img > threshold);
    [index_x, index_y] = ind2sub(img_size, index);
    
    index_x = index_x - 1;
    index_y = index_y - 1;

    theta_x = index_x * cos(thetaScale); 
    theta_y = index_y * sin(thetaScale);
    rho = theta_x + theta_y;

    for i=1:thetas
        H(:,i) = histcounts(rho(:, i), num_rhos)';
    end
 
end
