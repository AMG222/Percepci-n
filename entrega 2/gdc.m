function v=gdc(W,w,w0,X)
	v=[];
	for i=1:columns(W)
		v=[v sum(((X*W{i}).*X),2)+sum((w{i}'*X')',2)+w0(i)];
	end
endfunction