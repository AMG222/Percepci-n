function ld = logDet(S)
	eigval=eig(S);
	if any(eigval<=0)
		ld=log(realmin);
	else
		ld=sum(log(eigval));
	endif
	ld=det(ld);
endfunction