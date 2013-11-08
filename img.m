function im = img(im)

im = double(im);
im = (im-min(im(:)))/(max(im(:))-min(im(:)));
 figure, imagesc(im), axis image; colormap gray
end