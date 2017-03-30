clear
clc
[image, map] = imread('gallery/flowergray.jpg');        % read image
if map > 1
    image2 = rgb2gray(image);                        % transform image into specific form
else
    image2 = image;
end
gray = im2double(image2);                            % transform image into double type
figure, imshow(gray);
title('Original image');                             % show the original image unresized
[row, column] = size(gray);
n = 1;                                               % variable count for the reasonable size
while n < row && n < column
    n = n * 2;
end
n = n/2;
max = n;                                             % resize and show
gray = imresize(gray, [n, n]);
figure, imshow(gray);
title('Resized image');
nextlevel = gray;
while n > 2                                          % generate Gaussian Pyramid
    nextlevel = impyramid(nextlevel, 'reduce');
    [r, c] = size(nextlevel);
    display([r,c]);
    figure, imshow(nextlevel);
    title('Next level image');
    n = n/2;
    img = imresize(nextlevel, [max, max],'bilinear');
    [r, c] = size(img);
    display([r,c]);
    figure, imshow(img);
    title('Next level image with same size');
end
nextlevel = impyramid(nextlevel, 'reduce');
figure, imshow(nextlevel);
title('Next level image');
img = imresize(nextlevel, [max, max],'bilinear');
figure, imshow(img);
title('Next level image with same size');
                   

