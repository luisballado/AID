function mpq = momgeom(I,x,y,p,q)
mpq = sum(sum(I.*(x.^p).*(y.^q)));