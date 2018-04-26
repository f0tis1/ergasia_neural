%Input face images.
I=imread(imgetfile);
imshow(I)
title('Original Image');

%check if the input image is RGB, convert to greyscale
if size(I, 3) == 3
I = rgb2gray(I);
figure
imshow(I); hold on
title('Grayscale');
hold off
end

%Detect objects using Viola-Jones Algorithm
%To detect Face
FDetect = vision.CascadeObjectDetector;
FDetect.MergeThreshold=10;

%Returns Bounding Box values based on number of objects
BB_Face = step(FDetect,I);

figure,
imshow(I); hold on
for i = 1:size(BB_Face,1)
    rectangle('Position',BB_Face(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
end
title('Face Detection');
hold off;

%crop and resize image
I = imcrop(I,BB_Face);
I = imresize(I,[150,150]);
figure
imshow(I)
title('Cropped and Resized');

%To detect Eyes
EyeDetect = vision.CascadeObjectDetector('EyePairBig');
BB_Eyes=step(EyeDetect,I);
figure,imshow(I);
rectangle('Position',BB_Eyes,'LineWidth',2,'LineStyle','-','EdgeColor','b');
title('Eyes Detection');

