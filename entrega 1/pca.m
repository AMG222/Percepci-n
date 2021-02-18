function [m,W]=pca(X)
    m=mean(X);
    Xm=X-m;
    Cov=Xm'*Xm;
    [vecp,valp]=eig(Cov);
    [valp,i]=sort(diag(valp), "descend");
    W=vecp(:,i);
end