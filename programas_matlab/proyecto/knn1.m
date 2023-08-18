function Yrec = knn1(Xent,Yent,Xrec)

NumObj = size(Xrec,1);

idx = knnsearch(Xent,Xrec,'dist','euclidean','k',3);

C = Yent(idx);

V = zeros(NumObj,max(Yent));

for i = 1:max(Yent)
    V(:,i) = sum(C==i,2);
end

[~,Yrec] = max(V,[],2);

end