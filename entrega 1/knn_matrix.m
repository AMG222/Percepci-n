% Computa la tasa de error de los k vecinos más cercanos 
% del conjunto de test Y con respecto al conjunto de entrenamiento X
% X es una matriz de tamaño n x d de datos de entrenamiento
% Y es una matriz de tamaño m x d matriz de datos de evaluación
% k es el numero de vecinos más cercanos

function [V]=knn_matrix(X,k)
	N=rows(X);
	
	numpartes=ceil(N*N*4/1024^3)*4;
	if (numpartes<1) numpartes=1; end
	partam=ceil(N/numpartes);
	
	V=[];
	
	% El clasificador de las muestras de test lo partimos
	% para asegurarnos de que la distancia que queda en la matriz D
	% cabe en memoria
	for i=1:numpartes
		% Reconstruimos las partes a partir del numero total
		Xparte=X((i-1)*partam+1:min(i*partam,N),:);
		% D es una matriz de distancias donde las mustras de entrenamiento
		% van por filas y las muestras de test por columnas
		D = L2dist(X,Xparte);
		% Ordenamos descendentemente por columnas desde el más cercano hata el más lejano
		[D,idx] = sort(D,'ascend');
		% Indexamos en el conjunto de entrenamiento los k vecinos más cercanos de cada muestra de test
		V = [V idx(2:k+1,:)];
	end
end