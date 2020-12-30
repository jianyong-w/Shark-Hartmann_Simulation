function Iout = SH_sense(args,sh,Uin,method)
% Shark-Hartmann 传感函数
% args: 相关光学及仿真参数
% sh: Shark-Hartmann 传感器结构体
% Uin: 输入波前
% method: 传感计算方法
% Iout: 像面强度

Uin = Uin.*sh.SHTrans;
if method == 1
    Uout = FresnelProp(args,Uin,args.fOfMicroLens,sh.delta_pp,sh.delta_ip);
else
    Uout = zeros(size(Uin));
    h = waitbar(0,'像面强度计算中...');
    for i=1:size(sh.lensCoors,1)
        tmpcoor = sh.lensCoors(i,:);
        half = floor(args.n_pixelOfLen/2);
        tmpin = Uin(tmpcoor(2)-half:tmpcoor(2)+half,tmpcoor(1)-half:tmpcoor(1)+half);
        tmpout = FresnelProp(args,tmpin,args.fOfMicroLens,sh.delta_pp,sh.delta_ip);
        Uout(tmpcoor(2)-half:tmpcoor(2)+half,tmpcoor(1)-half:tmpcoor(1)+half) = tmpout;
        if mod(i,50)==0
            waitbar(i/size(sh.lensCoors,1));
        end
    end
    close(h);
end
Iout = Uout.*conj(Uout);
    