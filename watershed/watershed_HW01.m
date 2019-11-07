%%
clc;
clear;
I= imread('D:\Matlab\bin\Digital_Image_Processing\small_blobs.tif');
figure,imshow(I),title('original')
%%
hy=fspecial('sobel');
hx=hy';
Iy=imfilter(double(I),hy,'replicate');
Ix=imfilter(double(I),hx,'replicate');
gradmag=sqrt(Ix.^2+Iy.^2);
L = watershed(gradmag);
wr= L==0;
figure,imshow(wr),title('Watershed Transform of Gradient Magnitude');
figure,imshow(imregionalmin(gradmag)),title('regional min gradient');
%%
%Compute Foreground Markers
fgm=imextendedmin(I,2);
I2=I;
I2(fgm)=175;
figure,imshow(I2),title('Foreground Markers')
%%
% Compute Background Markers
D = bwdist(fgm);
DL = watershed(D);
bgm = DL == 0;
figure,imshow(bgm),title('Background Markers')
%%
gradmag2 = imimposemin(gradmag, bgm | fgm);
figure,imshow(gradmag2,[]),title('modified gradient');
%%
L2 = watershed(gradmag2);
I3=I;
I3(L2==0)=255;
figure,imshow(I3),title('Watershed Segmentation');