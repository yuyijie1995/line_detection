function [ uSobel ] = func_sobel( imag )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[high,width] = size(imag);   % ���ͼ��ĸ߶ȺͿ��
%��׼sobel�˲� ��ʼ
F2 = double(imag);        
U = double(imag); 
uSobel = imag;
%for i = 2:high - 1   %sobel��Ե���
for i = high/2-15:high-1   %sobel��Ե���  �����°벿��
    for j = 2:width - 1
        Gx = (U(i+1,j-1) + 2*U(i+1,j) + F2(i+1,j+1)) - (U(i-1,j-1) + 2*U(i-1,j) + F2(i-1,j+1));
        Gy = (U(i-1,j+1) + 2*U(i,j+1) + F2(i+1,j+1)) - (U(i-1,j-1) + 2*U(i,j-1) + F2(i+1,j-1));
        uSobel(i,j) = sqrt(Gx^2 + Gy^2); 
    end
end 
end

