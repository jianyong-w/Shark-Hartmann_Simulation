function coffes = zernikeCoffes(img,zernPolys)
% 计算img的zernike系数
coffes = zeros(size(zernPolys,3),1);
for i=1:size(zernPolys,3)
    coffes(i) = sum(sum(img.*zernPolys(:,:,i)));
end