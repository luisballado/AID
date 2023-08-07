function TH = tophat(I,t)
w = strel('square',t);
E = imerode(I,w);
D = imdilate(E,w);
TH = imsubtract(I,D);