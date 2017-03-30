clear
clc
[image, map] = imread('gallery/text.jpg');        % read image
if map > 1
    image2 = rgb2gray(image);               % transform image into specific form
else
    image2 = image;
end
gray = im2double(image2);
gray = imresize(gray, [100, 100]);
[row, column] = size(gray);
figure, imshow(gray);
title('Original image');                    % show original grayscale image
% a)
gray2 = gray';
y = gray(:)';                               % 2D to 1D transformation
ysort = sort(y); 
x = 1:1:row*column;
figure, plot(x,ysort);
title('Grayscale image values in x');       % part a) show grayscale image values
% b)
nbins = 32;
figure, hist(y,nbins);
title('Histogram of grayscale image in 32 bins') % part b) show histogram of grayscale
% c)
binaryImage = (gray > 0.5);
figure, imshow(binaryImage);
title('Binary image with a threshold of 0.5');   % part c) show binary image
% d)
average = mean2(gray);
subtract = gray - average;
subtract(subtract < 0) = 0;
figure, imshow(subtract);
title('Original image subtract mean value'); % part d) show grayscale image subtract mean value
% e)
z = (1:8);
reshapez = reshape(z,[2,4eg]);                %reshape vector z
disp(reshapez);
% f)
odd = (1:2:99);
extract = gray(1:2:end, 1:2:end, :);
figure, imshow(extract);
title('Subsample in half size');    % part f) show the subsample image
% g)
width1 = 3;
width2 = 12;
width3 = 18;
sigma1 = width1/6;
sigma2 = width2/6;
sigma3 = width3/6;
gaussian1 = fspecial('gaussian', [width1 width1], sigma1);
gaussian2 = fspecial('gaussian', [width2 width2], sigma2);
gaussian3 = fspecial('gaussian', [width3 width3], sigma3);
blurred1 = imfilter(gray, gaussian1, 'replicate');
blurred2 = imfilter(gray, gaussian2, 'replicate');
blurred3 = imfilter(gray, gaussian3, 'replicate');
figure;
subplot(2,2,1);
imshow(gray);
title('Original image');
subplot(2,2,2);
imshow(blurred1);
title('Width = 3');
subplot(2,2,3);
imshow(blurred2);
title('Width = 12');
subplot(2,2,4);
imshow(blurred3);
title('Width = 18');
% h)
gaussian = fspecial('gaussian', 3, 0.5);
blurred = imfilter(gray, gaussian, 'replicate');
compare = conv2(gray, gaussian);
figure;
subplot(1,2,1);
imshow(blurred);
title('Guassian filter used fspecial and imfilter');
subplot(1,2,2);
imshow(compare);
title('Gaussian filter used fspecial and conv2');
