#!/usr/bin/octave -qf

if (nargin!=3)
printf("Usage: pca+knn-exp.m <trdata> <trlabels> <alphas>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
trper=90;
dvper=10;
alphas=str2num(arg_list{3});

load(trdata);
load(trlabs);

N=rows(X);
rand("seed",23); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);

Ntr=round(trper/100*N);
Ndv=round(dvper/100*N);
Xtr=X(1:Ntr,:); xltr=xl(1:Ntr);
Xdv=X(N-Ndv+1:N,:); xldv=xl(N-Ndv+1:N);

[etr,edv]=gaussian(Xtr,xltr,Xdv,xldv,alphas);

printf("error de clasificador gaussiano alpha %f, error %f%%\n",alphas,edv);

printf("%f\n", edv);
plot(alphas, edv);
xlabel ("alphas");
ylabel ("edv");
title ("Grafica error");
pause(50);