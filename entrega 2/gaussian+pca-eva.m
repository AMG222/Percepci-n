#!/usr/bin/octave -qf

if (nargin!=6)
printf("Usage: pca+knn-eva.m <trdata> <trlabels> <tedata> <telabels> <alpha> <k>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
tedata=arg_list{3};
telabs=arg_list{4};
alpha=str2num(arg_list{5});
k=str2num(arg_list{6});

load(trdata);
load(trlabs);
load(tedata);
load(telabs);
[m,W]=pca(X);
Xtr=(X-m)*W(:,1:k);
Ydv=(Y-m)*W(:,1:k);
[etr,edv]=gaussian(Xtr,xl,Ydv,yl,alpha);

printf("error gausiano con el mejor alpha y mejor reduccion de dimensionalidad de pca: %f\n", edv);