function hu = moments_hu(I)

% BASADO DE
% https://raw.githubusercontent.com/Tejas1415/Hu-s-Invariant-Moments-in-MATLAB/master/hu_moments.m

[height, width] = size(I);

xgrid = repmat((-floor(height/2):1:ceil(height/2)-1)',1,width);
ygrid = repmat(-floor(width/2):1:ceil(width/2)-1,height,1);

[x_bar, y_bar] = centerOfMass(I,xgrid,ygrid);

% normalizar restando la media
xnorm = x_bar - xgrid;
ynorm = y_bar - ygrid;

% momentos centrales
mu_11 = central_moments( I ,xnorm,ynorm,1,1);
mu_20 = central_moments( I ,xnorm,ynorm,2,0);
mu_02 = central_moments( I ,xnorm,ynorm,0,2);
mu_21 = central_moments( I ,xnorm,ynorm,2,1);
mu_12 = central_moments( I ,xnorm,ynorm,1,2);
mu_03 = central_moments( I ,xnorm,ynorm,0,3);
mu_30 = central_moments( I ,xnorm,ynorm,3,0);

% Calcular momentos invariantes de Hu

uno   = mu_20 + mu_02;
dos   = (mu_20 - mu_02)^2 + 4*(mu_11)^2;
tres = (mu_30 - 3*mu_12)^2 + (mu_03 - 3*mu_21)^2;
cuatro  = (mu_30 + mu_12)^2 + (mu_03 + mu_21)^2;
cinco  = (mu_30 - 3*mu_12)*(mu_30 + mu_12)*((mu_30 + mu_12)^2 - 3*(mu_21 + mu_03)^2) + (3*mu_21 - mu_03)*(mu_21 + mu_03)*(3*(mu_30 + mu_12)^2 - (mu_03 + mu_21)^2);
seis   = (mu_20 - mu_02)*((mu_30 + mu_12)^2 - (mu_21 + mu_03)^2) + 4*mu_11*(mu_30 + mu_12)*(mu_21 + mu_03);
siete = (3*mu_21 - mu_03)*(mu_30 + mu_12)*((mu_30 + mu_12)^2 - 3*(mu_21 + mu_03)^2) + (mu_30 - 3*mu_12)*(mu_21 + mu_03)*(3*(mu_30 + mu_12)^2 - (mu_03 + mu_21)^2);

hu = [uno,dos,tres,cuatro,cinco,seis,siete];