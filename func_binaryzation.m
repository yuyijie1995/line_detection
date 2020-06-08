function [ aa,bb ] = func_binaryzation( imag )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%将sobel处理的图片二值化
[high,width] = size(imag);   % 获得图像的高度和宽度
imag_z=imag(high/2-15:high-1,1:width/2);%左图
imag_y=imag(high/2-15:high-1,width/2:width-1);%右图
lm=360;
%左最大值(都是对行处理)
sum_z=sum(imag_z,2);%行和
max_z=max(imag_z,[],2);%行最大值 高
mean=floor(sum_z/lm);
max_z=double(max_z);%把double转为uint8，下面有除法
ratio=max_z./mean;
nthreshold=ones(255,1);
for i=1:255
    if ratio(i)>12
    nthreshold(i)=6*mean(i);
elseif ratio(i)>7
    nthreshold(i)=4*mean(i);
else
    nthreshold(i)=10*mean(i);
    end
end
matrx_build=ones(1,360);
nThreshold=nthreshold*matrx_build;%除数矩阵
nThreshold=uint8(nThreshold);
aa=(imag_z-nThreshold)./abs(imag_z-nThreshold)*255;%二值化的右车道
%左最大值(都是对行处理)
sum_y=sum(imag_y,2);%行和
max_y=max(imag_y,[],2);%行最大值 高
mean=floor(sum_y/lm);
max_y=double(max_y);%把double转为uint8，下面有除法
ratio=max_y./mean;
nthreshold=ones(255,1);
for i=1:255
    if ratio(i)>12
    nthreshold(i)=6*mean(i);
elseif ratio(i)>7
    nthreshold(i)=4*mean(i);
else
    nthreshold(i)=10*mean(i);
    end
end
matrx_build=ones(1,360);
nThreshold=nthreshold*matrx_build;
nThreshold=uint8(nThreshold);
bb=(imag_y-nThreshold)./abs(imag_y-nThreshold)*255;%二值化的左车道
end

