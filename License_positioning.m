function output = License_positioning(I)
I = imresize(I, [624 832]);
grayI = rgb2gray(I);
%°ª´µ¥­·Æ

GauI = imgaussfilt(grayI);
J = medfilt2(GauI);

BW2 = edge(J,'Sobel');
% figure(1);
% imshow(BW2)

s = regionprops(BW2,'Area','MajorAxisLength','MinorAxisLength');
idx = find([s.MajorAxisLength] < 300 & [s.MinorAxisLength] >10.9 & [s.Area] > 30); 
L = bwlabel(BW2);
BW2 = ismember(L,idx);
% figure(2);
% imshow(BW2)

dotsY = sgolayfilt(sum(BW2,2),3,31);
T = mean(dotsY) + std(dotsY)*0.8;
maskY = dotsY'>T;
for i = 1:size(BW2,1)
    BW2(i,:)=BW2(i,:).*maskY(i);
end
% figure(4);
% imshow(BW2)

se = strel('rectangle',[16 20]);
BW2 = imdilate(BW2,se);
BW2 = imerode(BW2,se);
% figure(5);
% imshow(BW2)

s2= regionprops(BW2,'Area','BoundingBox');
bb = cat(1,s2.BoundingBox);
idx2 = find([s2.Area] > 1000 & [s2.Area] < 20000);
idx22 = find((bb(:,3).*bb(:,4)./[s2.Area]') < 2);
C = intersect(idx2,idx22);

if ( isempty(C) == true)
    [M,I] = max([s2.Area]);
    myFrame = [bb(I,1)+(bb(I,3)-bb(I,4)*4.2)/2 bb(I,2) bb(I,4)*4.2 bb(I,4)];
else
    L2 = bwlabel(BW2);
    BW2 = ismember(L2,C);
    s3 = regionprops(BW2,'Boundingbox');
%     figure(6);
%     imshow(BW2)
    boundingbox = cat(1,s3.BoundingBox);
    best = [100 1];
    for k = 1:size(boundingbox,1)
        if (boundingbox(k,3)/boundingbox(k,4) - 3.5)^2 < best(1)
            best(1) = (boundingbox(k,3)/boundingbox(k,4) - 3.5)^2 ;
            best(2) = k;
        end
    end
    myFrame = [boundingbox(best(2),1)-5 boundingbox(best(2),2) boundingbox(best(2),3)+10 boundingbox(best(2),4)];
end
% figure(7);
% imshow(J)
% hold on
% rectangle('Position',myFrame,'EdgeColor','r')
% hold off
output = imcrop(J,myFrame);
% figure(8);
% imshow(output);
% path = 'C:\Users\USER\Documents\MATLAB\CV\output';
% imwrite(output, fullfile(path, fname),'jpg');
end
