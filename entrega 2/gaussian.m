function [etr,edv]=gaussian(Xtr,xltr,Xdv,xldv,alphas)
	[n, dimension] = size(Xtr); %%Tamaño datos de entrenamiento
	[ne, de] = size(Xdv);
	clases = unique(xltr');
    numc = columns(clases);
	output_precision(7);
    err=0;
	etr = []; %%Valor a devolver
    edv = []; %%Valor a devolver
	for i=alphas
		p=[];
		mu=[];
		sigma={};
		W={};
		w={};
		w0=[];
		x=xltr;
		for c=1:numc
			idx=find(xltr+1 == c);
			len=length(idx);
			Xc=Xtr(idx,:);
			mu(:,c)= (1/len)*sum(Xc);
			p=[p len/n];
			sigma{c}=cov(Xc,1);
			%%SUAVIZADO
			suave=i*sigma{c}+(1-i)*eye(rows(sigma{c}),columns(sigma{c}));
			sigma{c}=suave;
			%%CALCULO Ws
			W{c}=-0.5*pinv(sigma{c});
			w{c}=pinv(sigma{c})*mu(:,c);
			w0=[w0 log(p(c))-0.5*logDet(sigma{c})-0.5*mu(:,c)'*pinv(sigma{c})*mu(:,c)];
		end
		%%ESTIMACIÓN ERROR
		G=gdc(W,w,w0,Xtr);
		[ma im]=max(G,[],2);
		err = mean((im-1) != xltr)*100;
		%%printf("error de entrenamiento %f, con alpha %f\n",err, i);
        etr = [etr err];
        err=0;
		G=gdc(W,w,w0,Xdv);
		[ma im]=max(G,[],2);
        err = mean((im-1) != xldv)*100;
		%%printf("error de evaluacion %f, con alpha %f\n",err, i);
        edv = [edv err];
	end
endfunction