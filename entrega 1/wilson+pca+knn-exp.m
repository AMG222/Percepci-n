#!/usr/bin/octave -qf

if (nargin!=4)
printf("Usage: pca+knn-exp.m <trdata> <trlabels> <%%trper> <%%dvper>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
trper=str2num(arg_list{3});
dvper=str2num(arg_list{4});

load(trdata);
load(trlabs);

N=rows(X);
rand("seed",23); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);

Ntr=round(trper/100*N);
Ndv=round(dvper/100*N);
Xtr=X(1:Ntr,:); xltr=xl(1:Ntr);
Xdv=X(N-Ndv+1:N,:); xldv=xl(N-Ndv+1:N);

printf("acaba pca\n");

%WILSON
[ind, eliminados] = wilson(Xtr, xltr, 1);
printf("se han eliminado %d muestras de %d muestras totales\n",eliminados,Ntr)
Xtr=Xtr(ind,:);
xltr=xltr(ind,:);
%WILSON

[m,W]=pca(Xtr);
for i=[51 52 53 54 55 56 57 58 59]
    Xtrp = (Xtr-m)*W(:,1:i);
    Xdvp = (Xdv-m)*W(:,1:i);
    [err] = knn(Xtrp,xltr,Xdvp,xldv,1);
    printf("error %f, con %d dimensiones\n", err, i);
end