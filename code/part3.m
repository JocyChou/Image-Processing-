clear
clc
[image, map] = imread('gallery/CARTOON.jpg');        % read image
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
j = 0;                                               % count for Gaussian pyramid
while n < row && n < column
    n = n * 2;
    j = j + 1;
end
n = n/2;
max = n;                                             % resize and show
gaussian = cell(j,1);                                % initiate a gaussian pyramid
gray = imresize(gray, [n, n]);
figure, imshow(gray);
title('Resized image');
i = 1;
gaussian{i} = gray;
nextlevel = gray;
while n > 2                                          % generate Gaussian Pyramid
    nextlevel = impyramid(nextlevel, 'reduce');
    n = n/2;
    i = i + 1;
    img = imresize(nextlevel, [max, max],'bilinear');
    gaussian{i} = img;
end
nextlevel = impyramid(nextlevel, 'reduce');
i = i + 1;
gaussian{i} = nextlevel;
img = imresize(nextlevel, [max, max],'bilinear');
gaussian{i} = img;

lap = cell(j, 1);
bi = cell(j, 1);
result = cell(j, 1);
thresh = cell(j, 1);
h = [[-1/8 -1/8 -1/8];[-1/8 1 -1/8];[-1/8 -1/8 -1/8]];
i = 1;
while i < j + 1
    lapop = conv2(gaussian{i}, h, 'same');
    bichange = imbinarize(lapop, 0);
    findedge = edge(bichange, 'zerocross');
    lap{i} = lapop; 
    bi{i} = bichange;
    result{i} = findedge;
    
%     figure, imshow(gaussian{i});
%     title('Gaussian pyramid');
%     figure, imshow(lapop);
%     title('After Lap operatpr');
%     figure, imshow(bichange);
%     title('After segment');
%      figure, imshow(findedge);
%      title('After check for zerocross');
    i = i + 1;
end
final = cell(j, 1);
for m = 1:1:j
    variance = stdfilt(lap{m});
    varianceth = (variance > 0.001);
    final{m} = result{m}&varianceth;
%     figure, imshow(gaussian{m});
%     title('Gaussian pyramid');
%     figure, imshow(lap{m});
%     title('After Lap operatpr');
%     figure, imshow(bi{m});
%     title('Transfer to binary');
%     figure, imshow(result{m});
%     title('After check for zerocross');
    figure, imshow(final{m});
    title('Final result for the edge detection');
end


