#!/usr/bin/octave -qf

if (nargin!=5)
printf("Usage: pca+knn-eva.m <trdata> <trlabels> <tedata> <telabels> <epsilon>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
tedata=arg_list{3};
telabs=arg_list{4};
epsilon=str2num(arg_list{5});

load(trdata);
load(trlabs);
load(tedata);
load(telabs);

[etr,edv]=multinomial(X,xl,Y,yl,epsilon);

printf("error multinomial con el mejor epsilon: %f\n", edv);