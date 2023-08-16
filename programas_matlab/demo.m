fig = openfig('cinta_a_1_lux_max.fig', 'new', 'invisible');
imgs = findobj(fig, '-type', 'image');
thiscmap = get(fig, 'colormap');
for K = 1 : length(imgs)
  thisimg = get(imgs(K), 'CData');
    %now do something with it for illustration purposes
    thisfilename = sprintf('extracted_image_%03d.jpg', K);
    imwrite(thisimg, thiscmap, thisfilename);
  end