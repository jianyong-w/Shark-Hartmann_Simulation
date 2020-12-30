clc;clear;close all;
imgsize = 101;
Nmax = 15;
zern = zernike(imgsize,Nmax);
for i=1:Nmax
   subplot(3,Nmax,i), imagesc(zern.polys(:,:,i)); axis image; axis off;
   subplot(3,Nmax,i+Nmax), imagesc(zern.diffxs(:,:,i)); axis image; axis off;
   subplot(3,Nmax,i+Nmax*2), imagesc(zern.diffys(:,:,i)); axis image; axis off;
end