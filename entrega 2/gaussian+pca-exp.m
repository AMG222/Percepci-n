#!/usr/bin/octave -qf

if (nargin!=4)
printf("Usage: pca+knn-exp.m <trdata> <trlabels> <ks> <alphas>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
trper=90;
dvper=10;
ks=str2num(arg_list{3});
alphas=str2num(arg_list{4});

load(trdata);
load(trlabs);

N=rows(X);
rand("seed",23); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);

Ntr=round(trper/100*N);
Ndv=round(dvper/100*N);
Xtr=X(1:Ntr,:); xltr=xl(1:Ntr);
Xdv=X(N-Ndv+1:N,:); xldv=xl(N-Ndv+1:N);

[m,W]=pca(Xtr);
error=[];
for j=alphas
printf("Comienzo de alfa %f\n", j);
for i=ks
    Xtrp=(Xtr-m)*W(:,1:i);
    Xdvp=(Xdv-m)*W(:,1:i);
    [etr,edv]=gaussian(Xtrp,xltr,Xdvp,xldv,j);
    error=[error edv];
    printf("error gausiano con dimension %f y error %f%%\n", i,edv);
end
end
plot(ks, error);
xlabel ("k");
ylabel ("err");
title ("Grafica error");
pause(50);