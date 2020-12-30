function img = zernikeRecon(zernPolys,coffes)
% 由zernike系数重建图像
img = zeros(size(zernPolys,1),size(zernPolys,2));
for i=1:size(zernPolys,3)
   img = img+zernPolys(:,:,i).*coffes(i); 
end