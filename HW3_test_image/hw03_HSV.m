clear
clc
img_rgb=imread('house.jpg');
img_hsv_enhanced=color_enhment(img_rgb,10);

img_rgb=imread('kitchen.jpg');
img_hsv_enhanced=color_enhment(img_rgb,20);

img_rgb=imread('aloe.jpg');
img_hsv_enhanced=color_enhment(img_rgb,7);

img_rgb=imread('church.jpg');
img_hsv_enhanced=color_enhment(img_rgb,3);


function [img_hsv_enhanced]=color_enhment(img_rgb,m)

img_hsv = rgbtohsi(img_rgb);

h_channel = img_hsv(:,:,1);
s_channel = img_hsv(:,:,2);
v_channel = img_hsv(:,:,3);

%enhancement in Saturation.
s_channel = s_channel * m;

img_hsv_enhanced = cat(3,h_channel,s_channel,v_channel);
img_rgb_enhanced = hsv2rgb(img_hsv_enhanced);

figure  
subplot(1,3,1);imshow(img_rgb);title('Original RGB Image');
subplot(1,3,2);imshow(img_hsv_enhanced);title('HSV image');
subplot(1,3,3);imshow(img_rgb_enhanced);title('RGB Image');

end

function [HSI]=rgbtohsi(img_rgb)

%Represent the RGB image in [0 1] range
I=double(img_rgb)/255;

R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

%Hue
numer=1/2*((R-G)+(R-B));
denumer=((R-G).^2+((R-B).*(G-B))).^0.5;

%To avoid divide by zero exception add a small number in the denominator
Hue=acosd(numer./(denumer+0.000001));

%If B>G then H= 360-Theta
Hue(B>G)=360-Hue(B>G);

%Normalize to the range [0 1]
Hue=Hue/360;

%Saturation
Satur=1- (3./(sum(I,3)+0.000001)).*min(I,[],3);


%Intensity
Intsy=sum(I,3)./3;


%HSI
HSI=zeros(size(img_rgb));
HSI(:,:,1)=Hue;
HSI(:,:,2)=Satur;
HSI(:,:,3)=Intsy;

end