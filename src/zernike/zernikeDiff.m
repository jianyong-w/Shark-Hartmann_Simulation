function [diffxs,diffys] = zernikeDiff(X,Y,ns,ms)
% ¼ÆËãzernikeÆ«µ¼
[theta,r] = cart2pol(X,Y);
half = max(X(:));
r = r./half;

diffxs  =zeros(size(X,1),size(X,2),length(ns));
diffys  =zeros(size(X,1),size(X,2),length(ns));

for i=1:length(ns)
    n = ns(i);
    m = ms(i);
    rad = zeros(size(r));
    radx = zeros(size(rad));
    rady = zeros(size(rad));
    for s = 0:(n-abs(m))/2
      c = (-1)^s*factorial(n-s)/(eps+factorial(s)*factorial((n+abs(m))/2-s)*...
          factorial((n-abs(m))/2-s));
      rad = rad + c*(eps+r).^(n-2*s);
      radx = radx+c.*(n-2*s).*(eps+r).^(n-2*s-1).*(cos(theta));
      rady = rady+c.*(n-2*s).*(eps+r).^(n-2*s-1).*(sin(theta));
    end
    if m>=0
        Mtheta = cos(m.*theta);
        Mthetax = -sin(m.*theta).*m.*(-sin(theta))./(r+eps);
        Mthetay = -sin(m.*theta).*m.*cos(theta)./(r+eps);
    else
        Mtheta = sin(abs(m).*theta);
        Mthetax = cos(abs(m).*theta).*abs(m).*(-sin(theta))./(r+eps);
        Mthetay = cos(abs(m).*theta).*abs(m).*cos(theta)./(r+eps);
    end
    rad = rad.*sqrt((2-(m==0))*(n+1));
    radx = radx.*sqrt((2-(m==0))*(n+1));
    rady = rady.*sqrt((2-(m==0))*(n+1));
    diffxs(:,:,i) = (radx.*Mtheta+rad.*Mthetax).*(r<=1);
    diffys(:,:,i) = (rady.*Mtheta+rad.*Mthetay).*(r<=1);
end