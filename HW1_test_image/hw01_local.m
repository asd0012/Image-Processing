clear all
img=imread('Lena.bmp');

out_his = zeros(size(img,1),size(img,2)); % Declare output variable

out_his=L_histo(img);
%transform the format to let imshow and imhist can display normally.
out_his=mat2gray(out_his);
%display the image
figure
subplot(2,2,1), imshow(img), title('Orginal');
subplot(2,2,2), imshow(out_his), title('My hist image');
subplot(2,2,3), imhist(img), title('Orginal Histogram');
subplot(2,2,4), imhist(out_his), title('histogram after local histogram equalization');

%repeat another image
img=imread('Peppers.bmp');

out_his = zeros(size(img,1),size(img,2)); % Declare output variable

out_his=L_histo(img);
out_his=mat2gray(out_his);

figure
subplot(2,2,1), imshow(img), title('Orginal');
subplot(2,2,2), imshow(out_his), title('My hist image');
subplot(2,2,3), imhist(img), title('Orginal Histogram');
subplot(2,2,4), imhist(out_his), title('histogram after local histogram equalization');

function [L_hist]=L_histo(img)

rows=64,cols=64;

for ii = 1 : rows : size(img, 1)
    for jj = 1 : cols : size(img,2)
        % cut the image and get the block
        row_begin = ii;
        row_end = min(size(img, 1), ii + rows-1);
        col_begin = jj;
        col_end = min(size(img, 2), jj + cols-1);
        blk = img(row_begin : row_end, col_begin : col_end, :);
        % Perform histogram equalization to each blk
        freq = zeros(256,1);
        pdf = zeros(256,1);
        cdf = zeros(256,1);
        out = zeros(256,1);
        cum = zeros(256,1);
        n=rows*cols;
        for i = 1:64
          for j = 1:64
            value = blk(i,j);
            freq(value+1) = freq(value+1)+1;
            pdf(value+1) = freq(value+1)/n;
           end
        end

        sum = 0;
        L = 255;
        for i = 1:size(pdf);
           sum = sum + freq(i);
           cum(i) = sum;
           cdf(i) = cum(i)/n;
           out(i) = round(cdf(i)*L);
        end
        
        for i = 1:64;
          for j=1:64;
            hist(i,j) = out(blk(i,j)+1);
           end
        end
        % store the output to out_hist
        L_hist(row_begin : row_end, col_begin : col_end, :) = hist;
    end
end
end
