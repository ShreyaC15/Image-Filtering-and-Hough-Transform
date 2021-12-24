function img1 = myEdgeFilter(img0, sigma)
    hsize = 2 * ceil(3 * sigma) + 1;
    gauss = fspecial('gaussian',[hsize,hsize],sigma);
    
    img_smooth = myImageFilter(img0,gauss);
    
    Sx = [-1 0 1; -2 0 2; -1 0 1];
    Sy = [1 2 1; 0 0 0; -1 -2 -1];
    
    imgx = myImageFilter(img_smooth,Sx);
    imgy = myImageFilter(img_smooth,Sy);
    
    img_edge = sqrt(imgx.^2 + imgy.^2);
    
    %NMS
    angle = atan2d(imgy, imgx)+180;
    [rows,cols] = size(img_edge);
    img1 = zeros(rows,cols);
    i1 = 255;
    i2 = 255;
    
    for i = 2:rows - 1
        for j = 2:cols - 1
             if (angle(i,j)>=337.5 || angle(i,j)<=22.5) || (angle(i,j)>=157.5 && angle(i,j)<=202.5) 
               i1 = img_edge(i,j+1);
               i2 = img_edge(i,j-1);
            elseif ((22.5<=angle(i,j))&&(angle(i,j)<67.5)||(202.5<=angle(i,j))&&(angle(i,j)<247.5))
               i1 = img_edge(i+1,j-1);
               i2 = img_edge(i-1,j+1); 
            elseif ((67.5<=angle(i,j))&&(angle(i,j)<112.5)||(247.5<=angle(i,j))&&(angle(i,j)<292.5))
               i1 = img_edge(i+1,j);
               i2 = img_edge(i-1,j); 
            elseif ((112.5<=angle(i,j))&&(angle(i,j)<157.5)||(292.5<=angle(i,j))&&(angle(i,j)<337.5))
               i1 = img_edge(i-1,j-1);
               i2 = img_edge(i+1,j+1); 
            end
            if((img_edge(i,j) >= i1)&&(img_edge(i,j) >= i2))
                img1(i,j) = img_edge(i,j);
            else
                img1(i,j) = 0;
            end
        end
    end
end
