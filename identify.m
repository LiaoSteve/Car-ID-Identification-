function [  ] = identify( original )
%%��J�Ƕ��v��


original = imresize(original, [240 NaN]);
for adapt=1:4
    
im=original;
[h, w] = size(im) ; %h�T�w��240 
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
    im=adapthisteq(im,'Numtile',[8 8], 'ClipLimit' ,0.01,'Distribution', 'uniform' );  %�ѨM�r�H�b�@�_ 
elseif adapt==2
     im=adapthisteq(im,'Numtile',[8 8], 'ClipLimit' ,0.0025,'Distribution', 'uniform');  %�ѨM�r�H�b�@�_ 
elseif adapt==3
    im=adapthisteq(im,'Numtile',[8 8], 'ClipLimit' ,0.0025,'Distribution', 'exponential' );  %�ѨM�r�H�b�@�_ 
else
    im=adapthisteq(im,'Numtile',[8 8], 'ClipLimit' ,0.0025,'Distribution', 'rayleigh' );  %�ѨM�r�H�b�@�_ 
end

im=imbinarize(im);
im = bwareaopen(~im, o);%�̷�w�ӱ���o���j�p
figure,imshow(im),title('bw image') ;

Iprops=regionprops(im,'BoundingBox','Area', 'Image');
count = numel(Iprops);%�ѧO���Ӽ�
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
%               oo=input('�O�_�x�s?Y=1\n');
%               if oo==1
%                 imname=input('��J���x�s���ɦW','s');
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
%     subplot(3,7,[8 14]),imshow(im),title([num2str(h), ' * ' ,num2str(w),' ����' ])
%     subplot(3,7,[15 21]),imshow(original),title('�w�쨮�P')
%     suptitle([' ���ѵ��G:  ',(noPlate)]);
        break;
else
    fprintf("  �Ӽ�Error ");
    
end

end




end

