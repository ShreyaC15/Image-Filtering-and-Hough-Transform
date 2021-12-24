function [rhos, thetas] = myHoughLines(H, nLines)
 img_nms = imdilate(H, strel('square', 5));
 layer = (img_nms == H);
 H = H .* layer;
 [~, index] = sort(H(:), 'descend');
 new_index = index(1:nLines);
 h_size = size(H);
 [rhos, thetas] = ind2sub(h_size, new_index);
end
