clc
clear
A=double((imread('blurry_moon.tif'))); %read image  

%Filter Masks. I use F2 for this code.
F1=[0 1 0;1 -4 1; 0 1 0];
F2=[1 1 1;1 -8 1; 1 1 1];

A=double(A);

%Calculate the img of Laplacian. 
[I,shrp_img]=cal_Lap(A,F2);

A=uint8(A);

% display img blurry_moon.tif
figure  
subplot(1,3,1);imshow(A);title('Original image');
subplot(1,3,2);imshow(I);title('Filtered Image');
subplot(1,3,3);imshow(shrp_img);title('Laplacian Sharpened Image');

A=double((imread('skeleton_orig.bmp'))); %read image  
A=double(A);

[I,shrp_img]=cal_Lap(A,F2);

%covert the type to display correctly
A=uint8(A);
I = rgb2gray(I);

% display img skeleton_orig.bmp
figure
subplot(1,3,1);imshow(A);title('Original image');
subplot(1,3,2);imshow(I);title('Filtered Image');
subplot(1,3,3);imshow(shrp_img);title('Laplacian Sharpened Image');


img=double((imread('blurry_moon.tif')));

[filt_img shrp_img]=Highboost(img,1); %A=1

%covert the type to display correctly
img=uint8(img);
filt_img=uint8(filt_img);
shrp_img=uint8(shrp_img);

% display img of Highboost blurry_moon.tif
figure
subplot(1,3,1);imshow(img);title('Original image');
subplot(1,3,2);imshow(filt_img);title('Filtered Image');
subplot(1,3,3);imshow(shrp_img);title('Highboost Sharpened Image');

img=0;

img=double(imread('skeleton_orig.bmp'));

[filt_img shrp_img]=Highboost(img,1);  %A=1

%covert the type to display correctly
img=uint8(img);
filt_img=uint8(filt_img);
shrp_img=uint8(shrp_img);
filt_img = rgb2gray(filt_img);
shrp_img = rgb2gray(shrp_img);

% display img of Highboost skeleton_orig.bmp
figure
subplot(1,3,1);imshow(img);title('Original image');
subplot(1,3,2);imshow(filt_img);title('Filtered Image');
subplot(1,3,3);imshow(shrp_img);title('Highboost Sharpened Image');

function [L]=Laplacian(I,F)
L=zeros(size(I));

%calculate the Laplacian with sum to add. every 3X3 elements are added each time. 
%fisrt sum to calcuate the value of matrix,secnod sum to calculate the
%f(x+1,y)+f(x-1,y)+.........+f(x+1,y+1).after multiplied by laplacian
%operator.

for i=1:size(I,1)-2
    for j=1:size(I,2)-2
        L(i,j)=sum(sum(F.*I(i:i+2,j:j+2)));
    end
end
end

function [L H] = Highboost(I, A)
%Filter mask
F2=[1 1 1;1 -8 1; 1 1 1];

% A is parameter A>=1;
A = double(A);
if A < 1
    error('Unavailable Value of A');
end
f = double(I);
[m n]=size(f);
L = f;

L=Laplacian(f,F2);
%Highboost img = fA-blurred img(J0);

H  = f.*A-L;
end

function [I,B]=cal_Lap(A,f)
I1=A;
I=zeros(size(A));  %the img of Laplacian value
B=zeros(size(A)); %sharpened img
A=double(A);

%cal the Laplacian value.
[I]=Laplacian(A,f);

I1=uint8(I1);
B=uint8(B);
I=uint8(I);
%calculate the sharpened img by Laplacian.
B=I1-I;
end