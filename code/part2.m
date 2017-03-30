clear
clc
[image, map] = imread('gallery/CARTOON.jpg');        % read image
if map > 1
    image2 = rgb2gray(image);               % transform image into specific form
else
    image2 = image;
end
gray = im2double(image2);
% figure, imshow(gray);
% title('Original image');   
[row, column] = size(gray);
n = 1;
i = 1;
j = 0;
while n < row && n < column
    n = n * 2;
    j = j + 1;
end
n = n/2;
max = n;
gaussian = cell(j, 1);
gray = imresize(gray, [n, n]);
gaussian{1} = gray;
% figure, imshow(gray);
% title('Resized image');
nextlevel = gray;
while n > 2                                             % Generate Gaussian pyramid
    nextlevel = impyramid(nextlevel, 'reduce');
    i = i + 1;
    img = imresize(nextlevel, [max, max],'bilinear');
    gaussian{i} = img;
    % figure, imshow(nextlevel);
    % title('Next level image');
    n = n/2;
    % img = interp2(nextlevel, sqrt(max/n));
    % figure, imshow(img);
    % title('Next level image with same size');
end
 nextlevel = impyramid(nextlevel, 'reduce');
 i = i + 1;
 img = imresize(nextlevel, [max, max],'bilinear');
 gaussian{i} = img;
% figure, imshow(nextlevel);
% title('Next level image');
% img = imresize(nextlevel, [max, max]);
% figure, imshow(img);
% title('Next level image with same size');

lap = cell(j, 1);
lap{j} = gaussian{j};
for n = 1 : j-1                                       % Generate Laplacian pyramid
   lap{n} = gaussian{n} - gaussian{n + 1};
end
for n = 1 : j
    figure, imshow(lap{n});
    title('Laplasian pyramid')
end
                   

