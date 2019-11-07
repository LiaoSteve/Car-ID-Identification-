function [  ] = identify( original )
%%輸入灰階影像


original = imresize(original, [240 NaN]);
for adapt=1:4
    
im=original;
[h, w] = size(im) ; %h固定為240 
if w<600 
     o=2000;   
 elseif w>=600 && w<770
     o=2000;    
 elseif w>=770 &&w<850
     o=2500;    
 elseif w>=850 && w<900
     o=2500;   
 elseif w>=900 && w<1000
     o=2500;     
 else
     o=1500;  
end

 % 'uniform' 'rayleigh', 'exponential'
%https://blog.csdn.net/piaoxuezhong/article/details/78271785
if adapt==1
    im=adapthisteq(im,'Numtile',[8 8], 'ClipLimit' ,0.01,'Distribution', 'uniform' );  %解決字黏在一起 
elseif adapt==2
     im=adapthisteq(im,'Numtile',[8 8], 'ClipLimit' ,0.0025,'Distribution', 'uniform');  %解決字黏在一起 
elseif adapt==3
    im=adapthisteq(im,'Numtile',[8 8], 'ClipLimit' ,0.0025,'Distribution', 'exponential' );  %解決字黏在一起 
else
    im=adapthisteq(im,'Numtile',[8 8], 'ClipLimit' ,0.0025,'Distribution', 'rayleigh' );  %解決字黏在一起 
end

im=imbinarize(im);
im = bwareaopen(~im, o);%依照w來控制o的大小
figure,imshow(im),title('bw image') ;

Iprops=regionprops(im,'BoundingBox','Area', 'Image');
count = numel(Iprops);%識別之個數
noPlate=[]; % Initializing the variable of number plate string.
j=0;
A(1)=0;
AREA=cat(1,Iprops.Area);


for i=1:count
   ow = length(Iprops(i).Image(1,:));
   oh = length(Iprops(i).Image(:,1));         
  if   ow/h<2/3    &&     oh/ow>1.3    &&    oh>(h/5)    &&    oh<h     &&    oh/ow<10   %12 
      if length(A)>=7  
      else
               j=j+1;
              %figure,imshow(Iprops(i).Image)
              letter=readLetter(Iprops(i).Image); 
               noPlate=[noPlate letter]; 
              A(j)=i;
              
%               letter= imcrop(im,Iprops(i).BoundingBox);      
%               letter=imresize(letter,[42 24]);
%               figure,imshow(letter);
%               oo=input('是否儲存?Y=1\n');
%               if oo==1
%                 imname=input('輸入欲儲存之檔名','s');
%                 imwrite(letter,imname);                 
%               end

      end 
  end
end

fprintf('\n');
if j==7
%     figure,    
%     subplot(371),imshow(Iprops(A(1)).Image)
%     subplot(372),imshow(Iprops(A(2)).Image)
%     subplot(373),imshow(Iprops(A(3)).Image)
%     subplot(374),imshow(Iprops(A(4)).Image)
%     subplot(375),imshow(Iprops(A(5)).Image)
%     subplot(376),imshow(Iprops(A(6)).Image)
%     subplot(377),imshow(Iprops(A(7)).Image)
%     subplot(3,7,[8 14]),imshow(im),title([num2str(h), ' * ' ,num2str(w),' 像素' ])
%     subplot(3,7,[15 21]),imshow(original),title('定位車牌')
%     suptitle([' 辨識結果:  ',(noPlate)]);
        break;
else
    fprintf("  個數Error ");
    
end

end




end

