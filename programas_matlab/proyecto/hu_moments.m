function hu = hu_moments(I)

I = double(I);
[N,M] = size(I);

[x,y] = meshgrid(0:M-1,0:N-1);

m00 = momgeom(I,x,y,0,0);
m10 = momgeom(I,x,y,1,0);
m01 = momgeom(I,x,y,0,1);
m20 = momgeom(I,x,y,2,0);
m02 = momgeom(I,x,y,0,2);
m11 = momgeom(I,x,y,1,1);

n20 = (m20-((m10^2)/m00))/m00^2;
n02 = (m02-((m01^2)/m00))/m00^2;
n11 = (m11-((m10*m01)/m00))/m00^2;

phi1 = n20 + n02;
phi2 = (n20-n02)^2+4*n11^2;


hu = [phi1,phi2];