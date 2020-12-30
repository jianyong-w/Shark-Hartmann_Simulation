function zern = zernike(imgsize,Nmax)
% 计算zernike多项式及其偏导矩阵
n = [];
m = [];
num = 0;
while length(n)<Nmax
   tmpn = ones(1,num+1).*num;
   n = [n,tmpn];
   tmpm = -num:2:num;
   m = [m,tmpm];
   num = num+1;
end
zern.n = n(1:Nmax);
zern.m = m(1:Nmax);

half = floor(imgsize/2);
[X,Y] = meshgrid(-half:half,-half:half);
[theta,r] = cart2pol(X,Y);
r = r./half;

zern.polys = zernikePolys(r,theta,zern.n,zern.m);
[zern.diffxs,zern.diffys] = zernikeDiff(X,Y,zern.n,zern.m);

