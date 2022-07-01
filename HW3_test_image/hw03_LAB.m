clear
clc
img_rgb=imread('house.jpg');
img_hsv_enhanced=color_enhment(img_rgb);

img_rgb=imread('kitchen.jpg');
img_hsv_enhanced=color_enhment(img_rgb);

img_rgb=imread('aloe.jpg');
img_hsv_enhanced=color_enhment(img_rgb);

img_rgb=imread('church.jpg');
img_hsv_enhanced=color_enhment(img_rgb);


function [img_lab_enhanced]=color_enhment(img_rgb)


img_lab = rgb2lab(img_rgb);

%scale the value of L at [0,1]
L_channel = img_lab(:,:,1)/100;
a_channel = img_lab(:,:,2);
b_channel = img_lab(:,:,3);

%histogram equalization in L and scale back the value to origin range
L_channel = adapthisteq(L_channel,'NumTiles',[8 8],'ClipLimit',0.005)*100;

img_lab_enhanced = cat(3,L_channel,a_channel,b_channel);
img_rgb_enhanced = lab2rgb(img_lab_enhanced);

figure  
subplot(1,3,1);imshow(img_rgb);title('Original RGB Image');
subplot(1,3,2);imshow(img_lab_enhanced);title('HSV image');
subplot(1,3,3);imshow(img_rgb_enhanced);title('RGB Image');

end