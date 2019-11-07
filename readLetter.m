function letter=readLetter(snap)
%READLETTER reads the character fromthe character's binary image.
%   LETTER=READLETTER(SNAP) outputs the character in class 'char' from the
%   input binary image SNAP.

%load NewTemplates % Loads the templates of characters in the memory.
load NewCar_Template
snap=imresize(snap,[42 24]); % Resize the input image so it can be compared with the template's images.
comp=[ ];
for n=1:length(NewTemplates)
    sem=corr2(NewTemplates{1,n},snap); % Correlation the input image with every image in the template for best matching.
    comp=[comp sem]; % Record the value of correlation for each template's character.
    %disp(sem);
    
end
maxcomp=max(comp);
if maxcomp >0.3
    vd=find(comp==max(comp)); % Find the index which correspond to the highest matched character.
else
    vd=999;
end

%*-*-*-*-*-*-*-*-*-*-*-*-*-
% Accodrding to the index assign to 'letter'.
% Alphabets listings.

% letter=[A  B C D  E F G H  J K L M N  P  Q  R  S T U V W X Y Z];%24­Ó1~24
% 
% number=[one two three  five six   seven eight  nine   zero ];%9­Ó 25~33

if vd==1 
    letter='A';
elseif vd==2 
    letter='B';
elseif vd==3
    letter='C';
elseif vd==4
    letter='D';
elseif vd==5
    letter='E';
elseif vd==6
    letter='F';
elseif vd==7
    letter='G';
elseif vd==8
    letter='H';
elseif vd==9
    letter='J';
elseif vd==10
    letter='K';
elseif vd==11
    letter='L';
elseif vd==12
    letter='M';
elseif vd==13
    letter='N';
elseif vd==14
    letter='P';
elseif vd==15
    letter='Q';
elseif vd==16
    letter='R';
elseif vd==17
    letter='S';
elseif vd==18
    letter='T';
elseif vd==19
    letter='U';
elseif vd==20
    letter='V';
elseif vd==21
    letter='W';
elseif vd==22
    letter='X';
elseif vd==23
    letter='Y';
elseif vd==24
    letter='Z';
    
    
% Numerals listings.
elseif vd==25
    letter='1';
elseif vd==26
    letter='2';
elseif vd==27
    letter='3';
elseif vd==28
    letter='5';
elseif vd==29
    letter='6';
elseif vd==30
    letter='7';
elseif vd==31
    letter='8';
elseif vd==32
    letter='9';
elseif vd==33
    letter='0';
    
% new_1
elseif vd==34
    letter='B';
elseif vd==35
    letter='8';
elseif vd==36
    letter='S';
elseif vd==37
    letter='0';
elseif vd==38
    letter='1';    
elseif vd==39
    letter='A'; 
elseif vd==40
    letter='E'; 
elseif vd==41
    letter='R'; 
elseif vd==42
    letter='U'; 
elseif vd==43
    letter='P'; 
elseif vd==44
    letter='1'; 
else
    letter='_';
end
fprintf('%s : %f\n',letter,maxcomp);
end