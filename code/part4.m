clear
clc
[image, map] = imread('gallery/polarcities.jpg');        % read first image
if map > 1
    image2 = rgb2gray(image);               % transform image into specific form
else
    image2 = image;
end
gray1 = im2double(image2);

[image, map] = imread('gallery/kitty.jpg');        % read second image
if map > 1
    image2 = rgb2gray(image);               % transform image into specific form
else
    image2 = image;
end
gray2 = im2double(image2);

[row1, column1] = size(gray1);
n = 1;
i = 1;
j1 = 0;
while n < row1 && n < column1
    n = n * 2;
    j1 = j1 + 1;
end
n = n/2;
max1 = n;
gaussian1 = cell(j1, 1);
gray1 = imresize(gray1, [max1, max1],'bilinear');
gaussian1{1} = gray1;
figure, imshow(gray1);
title('Fisrt resized image');
nextlevel = gray1;
while n > 2                                             % Generate Gaussian pyramid
    nextlevel = impyramid(nextlevel, 'reduce');
    i = i + 1;
    img = imresize(nextlevel, [max1, max1],'bilinear');
    gaussian1{i} = img;
    % figure, imshow(nextlevel);
    % title('Next level image');
    n = n/2;
    % img = interp2(nextlevel, sqrt(max/n));
    % figure, imshow(img);
    % title('Next level image with same size');
end
 nextlevel = impyramid(nextlevel, 'reduce');
 i = i + 1;
 img = imresize(nextlevel, [max1, max1],'bilinear');
 gaussian1{i} = img;
% figure, imshow(nextlevel);
% title('Next level image');
% img = imresize(nextlevel, [max, max]);
% figure, imshow(img);
% title('Next level image with same size');


[row2, column2] = size(gray2);
n = 1;
i = 1;
j2 = 0;
while n < row2 && n < column2
    n = n * 2;
    j2 = j2 + 1;
end
n = n/2;
max2 = n;
gaussian2 = cell(j2, 1);
gray2 = imresize(gray2, [max2, max2],'bilinear');
gaussian2{1} = gray2;
figure, imshow(gray2);
title('Second resized image');
nextlevel = gray2;
while n > 2                                             % Generate Gaussian pyramid
    nextlevel = impyramid(nextlevel, 'reduce');
    i = i + 1;
    img = imresize(nextlevel, [max2, max2],'bilinear');
    gaussian2{i} = img;
    % figure, imshow(nextlevel);
    % title('Next level image');
    n = n/2;
    % img = interp2(nextlevel, sqrt(max/n));
    % figure, imshow(img);
    % title('Next level image with same size');
end
 nextlevel = impyramid(nextlevel, 'reduce');
 i = i + 1;
 img = imresize(nextlevel, [max2, max2],'bilinear');
 gaussian2{i} = img;
% figure, imshow(nextlevel);
% title('Next level image');
% img = imresize(nextlevel, [max, max]);
% figure, imshow(img);
% title('Next level image with same size');

lap1 = cell(j1, 1);
lap1{j1} = gaussian1{j1};
for n = 1 : j1-1                                       % Generate Laplacian pyramid
   lap1{n} = gaussian1{n} - gaussian1{n + 1};
end
% result = 0;
% for n = 1 : j1
%     result = result + lap1{n};
% end
% figure, imshow(result);

lap2 = cell(j2, 1);
lap2{j2} = gaussian2{j2};
for n = 1 : j2-1                                       % Generate Laplacian pyramid
   lap2{n} = gaussian2{n} - gaussian2{n + 1};
end
% result = 0;
% for n = 1 : j1
%     result = result + lap2{n};
% end
% figure, imshow(result);
% for n = 1 : j1
%     figure, imshow(lap2{n});
%     title('Laplasian pyramid')
% end

gaussian3 = cell(j1, 1);
bimask = [[ones(max1/2) zeros(max1/2)];[zeros(max1/2) ones(max1/2)]];
i = 1;
gaussian3{1} = bimask;
n = max1;
nextlevel = bimask;
while n > 2                                          % generate Gaussian Pyramid
    nextlevel = impyramid(nextlevel, 'reduce');
    i = i + 1;
    %[r, c] = size(nextlevel);
    %display([r,c]);
    %figure, imshow(nextlevel);
    %title('Next level image');
    n = n/2;
    img = imresize(nextlevel, [max1, max1],'bilinear');
    gaussian3{i} = img;
    %[r, c] = size(img);
    %display([r,c]);
    %figure, imshow(img);
    %title('Next level image with same size');
end
nextlevel = impyramid(nextlevel, 'reduce');
i = i + 1;
%figure, imshow(nextlevel);
%title('Next level image');
img = imresize(nextlevel, [max1, max1],'bilinear');
gaussian3{i} = img;
% figure, imshow(img);
% title('Next level image with same size');
for n = 1 : 1
    figure, imshow(gaussian3{n});
    title('Bimask pyramid')
end

spline = cell(j1, 1);
for i = 1:1:j1
    pre = zeros(max1);
    lap1pre = lap1{i};
    lap2pre = lap2{i};
    gaussian3pre = gaussian3{i};
    for row = 1:1:max1
        for column = 1:1:max1
            pre(row, column) = lap1pre(row,column)*gaussian3pre(row, column) + lap2pre(row,column)*(1 - gaussian3pre(row, column));
        end
    end
    spline{i} = pre;
    %figure, imshow(pre);
end
 
result = 0;
for t = 1:1:j1
    result = result + spline{t};
end
figure, imshow(result);
title('Result of blending')