clc;clear;close all;

args.lambda = 488e-9; % 光波长
args.fOfMicroLens = 18.8e-3; % 微透镜焦距
args.SizeOfMicroLens = 300e-6; % 微透镜尺寸
args.SizeOfSH = 10e-3; % SH传感器尺寸
args.n_pixelOfLen = 33; % 微透镜仿真pixel数
args.Nmax = 55;

senseMethod = 2; % 传感计算方法

addpath(genpath('.\src\'));

phi = peaks(floor(args.SizeOfSH/args.SizeOfMicroLens)*args.n_pixelOfLen);
Uin = exp(1i.*phi);
sh = SH_init(args); % SH传感器设置
Iout = SH_sense(args,sh,Uin,senseMethod); % SH传感
Uin_recon = SH_recon(args,sh,Iout);

save data\args args;
save data\Uin Uin;
save data\sh sh;
save data\Iout Iout;
save data\Uin_recon Uin_recon;

subplot(221); imagesc(phi); colorbar; axis image; axis off; title('Input Wavefront');
subplot(222); imagesc(angle(sh.SHTrans)); colorbar; axis image; axis off; title('Transmittance of microlens');
subplot(223); imshow((Iout>0.05),[]); axis image; axis off; title('Spots array');
subplot(224); imagesc(Uin_recon); colorbar; axis image; axis off; title('Reconstructed Wavefront');

