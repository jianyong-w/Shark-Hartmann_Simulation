function Uout = FresnelProp(args,Uin,d,delta_in,delta_out,gpu)
% 菲涅尔衍射函数
% args: 相关光学即仿真参数
% Uin: 输入波前
% d:传播距离
% delta_in: 输入pixel size
% delta_out: 输出pxiel size
% Uout:输出波前

sizex = size(Uin,1);
mid = floor(sizex/2)+1;
Uout = zeros(size(Uin));
% parfor_progress(size(Uin,1)*size(Uin,2));
[X,Y] = meshgrid(1:size(Uin,2),1:size(Uin,1));
% if gpu==1
%    Uout = gpuArray(Uout);
%    Uin = gpuArray(Uin);
%    X = gpuArray(X);
%    Y = gpuArray(Y);
% end
for x1 = 1:size(Uout,2)
    for y1 = 1:size(Uout,1)
        tmp1 = exp(1i*2*pi/args.lambda.*d)/(1i*args.lambda*d);
        tmpR2 = ((x1-mid)*delta_out-(X-mid)*delta_in).^2+((y1-mid)*delta_out-(Y-mid)*delta_in).^2;
        tmp2 = exp(1i*2*pi/args.lambda/2/d.*tmpR2);
        tmpout = tmp1.*Uin.*tmp2.*delta_in.*delta_in;
        Uout(y1,x1) = sum(tmpout(:));
%         parfor_progress;
    end
end
% parfor_progress(0);

% if gpu==1
%     Uout = gather(Uout);
% end
