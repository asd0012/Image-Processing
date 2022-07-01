clear all
% read Image
imge = imread('Lena.bmp'); %read image

my_hist=histo(imge);
figure
subplot(2,2,1), imshow(imge), title('Orginal');
subplot(2,2,2), imshow(my_hist), title('My hist image');
subplot(2,2,3), imhist(imge), title('Orginal Histogram');
subplot(2,2,4), imhist(my_hist), title('histogram after histogram equalization');

imge=imread('Peppers.bmp');
my_hist=histo(imge);
figure
subplot(2,2,1), imshow(imge), title('Orginal');
subplot(2,2,2), imshow(my_hist), title('My hist image');
subplot(2,2,3), imhist(imge), title('Orginal Histogram');
subplot(2,2,4), imhist(my_hist), title('histogram after histogram equalization');


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