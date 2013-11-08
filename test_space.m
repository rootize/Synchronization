% track the features

im=imread('test.jpg');
im=im2double(rgb2gray(im));
% s = [1 ;1];
% dx = [1, -1];
% dy = [1;-1];
% gx = conv2(conv2(I,dx,'same'),s,'same');
% gy = conv2(conv2(I,dy,'same'),s','same');

initPtsObj=detectSURFFeatures(im,'NumOctaves',1,'NumScaleLevels',3);
imshow(im);
hold on
location=initPtsObj.Location;
plot(location(:,1),location(:,2),'r*');
hold off