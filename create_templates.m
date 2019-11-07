%CREATE TEMPLATES

%Letter
A=imread('char/A.bmp');B=imread('char/B.bmp');
C=imread('char/C_1.bmp');D=imread('char/D.bmp');
E=imread('char/E.bmp');F=imread('char/F.bmp');
G=imread('char/G.bmp');H=imread('char/H.bmp');
J=imread('char/J.bmp');
K=imread('char/K.bmp');L=imread('char/L.bmp');
M=imread('char/M.bmp');N=imread('char/N_1.bmp');
P=imread('char/P.bmp');
Q=imread('char/Q.bmp');R=imread('char/R.bmp');
S=imread('char/S_1.bmp');T=imread('char/T.bmp');
U=imread('char/U_2.bmp');V=imread('char/V.bmp');
W=imread('char/W.bmp');X=imread('char/X.bmp');
Y=imread('char/Y.bmp');Z=imread('char/Z_2.bmp');

%Number
one=imread('char/1.bmp');  two=imread('char/2_2.bmp');
three=imread('char/3_1.bmp');
five=imread('char/5.bmp'); six=imread('char/6.bmp');
seven=imread('char/7.bmp');eight=imread('char/8_1.bmp');
nine=imread('char/9.bmp'); zero=imread('char/0.bmp');


%%New _1
B_1=imread('char/B_1.bmp');eight_1=imread('char/8.bmp');
S_1=imread('char/S.bmp');zero_1=imread('char/0_4.bmp');
one_1=imread('char/1_2.bmp'); A_1=imread('char/A_4.bmp');
E_1=imread('char/E_1.bmp');R_1=imread('char/R_4.bmp');
U_1=imread('char/U_1.bmp');P_1=imread('char/P_1.bmp');

%New_2
one_2=imread('char/1_3.bmp'); 


%*-*-*-*-*-*-*-*-*-*-*-



letter=[A  B C D  E F G H  J K L M N  P  Q  R  S T U V W X Y Z];%24個 (1~24)

number=[one two three  five six   seven eight  nine   zero ];%9個 (25~33)

new_1=[B_1  eight_1  S_1  zero_1  one_1  A_1  E_1 R_1 U_1 P_1];%9個 (34~43)

new_2=[one_2];%1個(44)

character=[ letter number new_1 new_2 ];

NewTemplates=mat2cell(character,42,[ ...
    24 24 24 24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 24 24 24 ...
    24 24 24 24]);



save ('NewCar_Template','NewTemplates')
clear all