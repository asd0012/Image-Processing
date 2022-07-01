clear
clc
img=imread('pool.png');

%Filter Masks
F1=[-1 0 1;-2 0 2; -1 0 1];
F2=[-1 -2 -1;0 0 0; 1 2 1];

%calcualte by sobel opreator.
[S,EI]=sobel_op(img,F1,F2);

%plot img
figure
subplot(1,3,1);imshow(img);title("Originimgl Imimgge");
subplot(1,3,2);imshow(S);title("Sobel grimgdient");
subplot(1,3,3);imshow(EI);title("Edge detected imimgge");

img=imread('peppers.png');

[S,EI]=sobel_op(img,F1,F2);

figure
subplot(1,3,1);imshow(img);title("Originimgl Imimgge");
subplot(1,3,2);imshow(S);title("Sobel grimgdient");
subplot(1,3,3);imshow(EI);title("Edge detected imimgge");


img=imread('baboon.png');

[S,EI]=sobel_op(img,F1,F2);
figure
subplot(1,3,1);imshow(img);title("Originimgl Imimgge");
subplot(1,3,2);imshow(S);title("Sobel grimgdient");
subplot(1,3,3);imshow(EI);title("Edge detected imimgge");


function [S,EI]=sobel_op(img,F1,F2)

%read img to RGB
S=rgb2gray(img);

%transform to double type.
img=double(img);

%Define threshold value of img
Th_hold=210;



for i=1:size(img,1)-2
    for j=1:size(img,2)-2
        %calculate the gradient by convolution.
        Gx=sum(sum(F1.*img(i:i+2,j:j+2)));
        Gy=sum(sum(F2.*img(i:i+2,j:j+2)));
        %calculate the magnitude
         S(i+1,j+1)=sqrt(Gx.^2+Gy.^2);
    end
end


S=uint8(S);
%choose the maximum from the value after sobel opreator,or,threshold.
%to edge image.
EI=max(S,Th_hold);
%approximate the value we have.
EI(EI==round(Th_hold))=0;

%transform img to binary
EI=im2bw(EI);

end