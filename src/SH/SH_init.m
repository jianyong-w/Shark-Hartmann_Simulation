function sh = SH_init(args)
% Shark-Hartmann传感器设置函数
% args: 相关光学及仿真参数
% sh: Shark-Hartmann 结构体

sh.n_Lens = floor(args.SizeOfSH/args.SizeOfMicroLens);
if mod(sh.n_Lens,2)==0
    sh.n_Lens = sh.n_Lens+1;
end

sh.delta_pp = args.SizeOfMicroLens/args.n_pixelOfLen;
sh.delta_ip = args.lambda*args.fOfMicroLens/sh.delta_pp/args.n_pixelOfLen;

tmpmask = ones(args.n_pixelOfLen,args.n_pixelOfLen);
[X,Y] = meshgrid((-floor(args.n_pixelOfLen/2):floor(args.n_pixelOfLen/2)).*sh.delta_pp,(-floor(args.n_pixelOfLen/2):floor(args.n_pixelOfLen/2)).*sh.delta_pp);
R = sqrt(X.^2+Y.^2);
tmpmask(R>args.SizeOfMicroLens/2) = 0;
sh.microLenTrans = tmpmask.*exp(-1i*2*pi/args.lambda/2/args.fOfMicroLens.*R.^2);
sh.maskOfMicroLen = tmpmask;

lensCen = zeros(args.n_pixelOfLen,args.n_pixelOfLen);
lensCen(floor(args.n_pixelOfLen/2)+1,floor(args.n_pixelOfLen/2)+1) = 1;
lensCen = repmat(lensCen,[sh.n_Lens,sh.n_Lens]);
n_pixelOfSH = sh.n_Lens*args.n_pixelOfLen;
[X,Y] = meshgrid((-floor(n_pixelOfSH/2):floor(n_pixelOfSH/2))*sh.delta_pp,(-floor(n_pixelOfSH/2):floor(n_pixelOfSH/2))*sh.delta_pp);
R = sqrt(X.^2+Y.^2);
lensCen(R>args.SizeOfSH/2) = 0;
sh.SHTrans = conv2(lensCen,sh.microLenTrans,'same');
sh.maskOfSH = conv2(lensCen,tmpmask,'same');

[x,y] = find(lensCen==1);
sh.lensCoors = [x,y];
