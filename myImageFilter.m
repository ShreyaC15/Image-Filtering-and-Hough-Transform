function [img1] = myImageFilter(img0, h)
 
 [rows_img,cols_img] = size(img0);
 [rows_filt,cols_filt] = size(h);
 
 h_flip1=flip(h,1);
 h_flip2=flip(h_flip1,2);
 
 h_pad = (rows_filt-1)/2;
 img_padded = padarray(img0, [h_pad h_pad]);
 
 img_padded = double(img_padded);
 img = zeros(rows_img-rows_filt+1,cols_img-cols_filt+1);

 for i = 1:rows_img
     for j = 1:cols_img
         img(i,j) = sum(sum(img_padded(i:i+rows_filt-1,j:j+cols_filt-1).*(h_flip2))); 
     end
 end
 img1=img;
end