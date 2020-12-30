function [cenx,ceny] = centroid(img)
if sum(img(:))==0
    cenx = 0;
    ceny = 0;
    return;
end
tmpx = floor(size(img,2)/2);
tmpy = floor(size(img,1)/2);
[X,Y] = meshgrid(-tmpx:tmpx,-tmpy:tmpy);
cenx = sum(sum(X.*img))./sum(img(:));
ceny = sum(sum(Y.*img))./sum(img(:));
