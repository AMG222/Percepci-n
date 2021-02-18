#!/usr/bin/octave -qf

if (nargin!=5)
printf("Usage: pca+knn-eva.m <trdata> <trlabels> <tedata> <telabels> <k>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
tedata=arg_list{3};
telabs=arg_list{4};
k=str2num(arg_list{5});

load(trdata);
load(trlabs);
load(tedata);
load(telabs);
printf("acaba load\n");

[m,W]=pca(X);
Xtrp=(X-m)*W(:,1:k);
Ydvp=(Y-m)*W(:,1:k);
printf("acaba pca\n");
err=knn(Xtrp, xl, Ydvp, yl, 1);
printf("aplicando pca: %f\n", err);

err=knn(X, xl, Y, yl, 1);
printf("sin aplicar pca: %f\n", err);