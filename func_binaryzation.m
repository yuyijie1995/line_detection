function [ aa,bb ] = func_binaryzation( imag )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%��sobel�����ͼƬ��ֵ��
[high,width] = size(imag);   % ���ͼ��ĸ߶ȺͿ��
imag_z=imag(high/2-15:high-1,1:width/2);%��ͼ
imag_y=imag(high/2-15:high-1,width/2:width-1);%��ͼ
lm=360;
%�����ֵ(���Ƕ��д���)
sum_z=sum(imag_z,2);%�к�
max_z=max(imag_z,[],2);%�����ֵ ��
mean=floor(sum_z/lm);
max_z=double(max_z);%��doubleתΪuint8�������г���
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
nThreshold=nthreshold*matrx_build;%��������
nThreshold=uint8(nThreshold);
aa=(imag_z-nThreshold)./abs(imag_z-nThreshold)*255;%��ֵ�����ҳ���
%�����ֵ(���Ƕ��д���)
sum_y=sum(imag_y,2);%�к�
max_y=max(imag_y,[],2);%�����ֵ ��
mean=floor(sum_y/lm);
max_y=double(max_y);%��doubleתΪuint8�������г���
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
bb=(imag_y-nThreshold)./abs(imag_y-nThreshold)*255;%��ֵ�����󳵵�
end

