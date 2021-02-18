function [ind, eliminados]=wilson(X,xl,k)
	n=rows(X);
	V=knn_matrix(X,100); %los 100 vecinos
	eliminados=0;
	err = true;
	ind = [1:n]; %ind = [1,2,3,4,...,60000]
	while(err)
		err = false;
		printf("%d ", eliminados);
		for m=1:n
			if (ismember(m,ind))
				c = knn_class(V,ind,xl,m,k);
				if c != xl(m) %Si la clase no es la de la lista de atributos de clase
					eliminados++;
					ind = setdiff(ind,[m]);
					err = true;
				end
			end
		end
	endwhile
end