function polys = zernikePolys(r,theta,ns,ms)
% 计算zernike多项式
polys = zeros(size(r,1),size(r,2),length(ns));
for i=1:length(ns)
    n = ns(i);
    m = ms(i);
    rad = zeros(size(r));
    for s = 0:(n-abs(m))/2
      c = (-1)^s*factorial(n-s)/(eps+factorial(s)*factorial((n+abs(m))/2-s)*...
          factorial((n-abs(m))/2-s));
      rad = rad + c*(eps+r).^(n-2*s);
    end
    if m>=0
        Mtheta = cos(m.*theta);
    else
        Mtheta = sin(abs(m).*theta);
    end
    rad = rad.*Mtheta.*sqrt((2-(m==0))*(n+1)).*(r<=1);
    polys(:,:,i) = rad;
end