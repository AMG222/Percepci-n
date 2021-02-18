function [etr,edv]=multinomial(Xtr,xltr,Xdv,xldv,epsilon)
	[n, dimension] = size(Xtr); %%Tamaño datos de entrenamiento
	clases = unique(xltr); %%Vector con cada una de las clases
	clases=clases';
	numc = columns(clases);
	etr = []; %%Valor a devolver
	edv = []; %%Valor a devolver
    for i=epsilon
    	P=[];
		p=[];
		for c=0:numc-1
			idx=find(xltr==c);
			p = [p length(idx)/n];
			P(c+1,:)=sum(Xtr(idx,:))/sum(sum(Xtr(idx,:)));
		end
		Pt=sum((P+i),2);
		P=(P+i)./Pt;
		w=log(P);
		w0=log(p);
		G=(Xtr*w')+w0;
		[ma im]=max(G,[],2);
		err=mean((im-1) != xltr)*100;
		etr = [etr err];
		Gd=(Xdv*w')+w0;
		[ma imd]=max(Gd,[],2);
		errd=mean((imd-1) != xldv)*100;
        edv = [edv errd];
    end
endfunction