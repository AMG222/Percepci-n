% Computa la tasa de error de los k vecinos más cercanos 
% del conjunto de test Y con respecto al conjunto de entrenamiento X
% X es una matriz de tamaño n x d de datos de entrenamiento
% xl es un vector de tamaño n x 1 vector con las etiquetas de la matriz X
% Y es una matriz de tamaño m x d matriz de datos de evaluación
% yl es un vector de tamaño m x 1 vector con las etiquetas de la matriz Y 
% k es el numero de vecinos más cercanos

function [c] = knn_class(V,ind,xl,i,k);
	% No tengo en cuenta las muestras eliminadas
	Vi = V(:,i);
	idx = Vi(ismember(Vi,ind));

	% Necesitan computarse más vecinos
	if (length(idx)<k)
		print("Necesitan computarse más vecinos");
	end

	% Indexa en conjunto de entrenamiento los k vecinos más cecanos de la muestra i
	idx = idx(1:k);

	% Clacificación de la muestra i en la clase mayoritaria entre los k vecinos más cercanos
	% Nota: (xl' es necesario cuando k=1 y xl(idx) es un vector y no una matriz)
	c = mode(xl'(idx),1);
end