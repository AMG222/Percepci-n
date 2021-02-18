#!/usr/bin/octave -qf

if (nargin!=3)
printf("Usage: multinomial-exp.m <trdata> <trlabels> <epsilon>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
epsilon=str2num(arg_list{3});

load(trdata);
load(trlabs);

N=rows(X);
rand("seed",23); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);

Ntr=round(90/100*N);
Ndv=round(10/100*N);
Xtr=X(1:Ntr,:); xltr=xl(1:Ntr);
Xdv=X(N-Ndv+1:N,:); xldv=xl(N-Ndv+1:N);

[etr, edv]=multinomial(Xtr,xltr,Xdv,xldv,epsilon);
x=1;
for i=epsilon
    printf("error de entrenamiento %f%%, con epsilon %f\n", etr(x), i); 
    x+=1;
end
printf("\n**Fin de entrenamiento ahora error de evaluación**\n\n");
x=1;
for i=epsilon
    printf("error de evaluación %f%%, con epsilon %f\n", edv(x), i);
    x+=1;
end

plot([1 2 3 4 5 6 7 8 9 10], edv);
xlabel ("epsilon");
ylabel ("edv");
title ("Grafica error");
pause(50);