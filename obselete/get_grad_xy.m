function [gx,gy]=get_grad_xy(im)
% get the image derivatives Ix and Iy of the reference image
I=im2double(rgb2gray(im));
s = [1 ; 1];
dx = [1, -1];
dy = [1;-1];
gx = conv2(conv2(I,dx,'same'),s,'same');
gy = conv2(conv2(I,dy,'same'),s','same');


end