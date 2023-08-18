function Ypred = knn2(Xent,Yent,Xrec)

NumObj = size(Xrec,1);

D = sqrt(bsxfun(@plus,dot(Xrec',Xrec',1),dot(Xent',Xent',1))-2*(Xent*Xrec));

[~,nearest] = sort(D,1);

idx = nearest(1:3,:);

C = Yent(idx);

V = zeros(NumObj,max(Yent));

for i = 1:max(Yent)
    V(:,i) = sum(C==i,2);

end

[~,Ypred] = max(V,[],2);

end