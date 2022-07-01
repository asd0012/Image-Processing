clear
clc
img_rgb=imread('house.jpg');
img_enhanced=color_enhment(img_rgb,10,0);

img_rgb=imread('kitchen.jpg');
img_hsv_enhanced=color_enhment(img_rgb,20,5);

img_rgb=imread('aloe.jpg');
img_hsv_enhanced=color_enhment(img_rgb,7,10);

img_rgb=imread('church.jpg');
img_hsv_enhanced=color_enhment(img_rgb,3,10);


function [img_enhanced]=color_enhment(img_rgb,m,b)

%histogram equalization in RGB
channeR = histo(img_rgb(:,:,1));
channeG = histo(img_rgb(:,:,2));
channeB = histo(img_rgb(:,:,3));

img_enhanced = cat(3,channeR,channeG,channeB);


figure  
subplot(1,2,1);imshow(img_rgb);title('Original RGB Image');
subplot(1,2,2);imshow(img_enhanced);title('RGB Image');

end



function [hist]=histo(img)

[row,col]=size(img);

hist=uint8(zeros(row,col));

n = row*col;

freq = zeros(256,1);
pdf = zeros(256,1);
cdf = zeros(256,1);
out = zeros(256,1);
cum = zeros(256,1);

% calculate the pdf
for i = 1:row
    for j = 1:col
        value = img(i,j);
        freq(value+1) = freq(value+1)+1;
        pdf(value+1) = freq(value+1)/n;
    end
end

sum = 0;
L = 255;

%calculate the cdf
for i = 1:size(pdf)
    sum = sum + freq(i);
    cum(i) = sum;
    cdf(i) = cum(i)/n;
    out(i) = round(cdf(i)*L);
end

%store the outcome to hist
for i = 1:row;
    for j = 1:col;
        hist(i,j) = out(img(i,j)+1);
    end
end

end