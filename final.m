matrixDeEncriptado=[3 2 1
					9 2 1
					4 5 6]
inversa = inv(matrixDeEncriptado)
%ESTO ES UNA FUNCTION LLAMADA ENCRIPTAR QUE RECIBE PATH to txt y Matrix
encriptado = fopen ('encriptado.mau', 'w+');
	fid = fopen ('archivo.txt', 'r');
		while true
			line = fgets(fid,rows(matrixDeEncriptado))'	;
			if line==-1 fputs(encriptado,'·'); break end %Se nos acabo el doc
			%Si no se puede multiplicar,faltan caracteres
			if columns(matrixDeEncriptado)~=rows(line)
				for k= 1:columns(matrixDeEncriptado)-rows(line)
					line(end+1)=' '; %Rellenamos con Dummy
				end
				line=line';
			end
			for i = (matrixDeEncriptado*line)'
				fputs (encriptado, num2str(i) ) ;
				fputs(encriptado,'·');
			end
		end
	fclose (fid);
	%EN ESTE PUNTO YA ESTA TODO ENCRIPTADO, finaliza con ··
	for col=matrixDeEncriptado
		for cel = col'
			fputs(encriptado,num2str(cel));
			fputs(encriptado,'·');
		end
	end
	%Ultimo valor es dimension de la matriz
	fputs(encriptado,num2str(rows(matrixDeEncriptado)));
fclose (encriptado);
%Decriptar, leer primer caracter de derecha a izq, ese es el tam de matrix
%Parsear la matrix de derecha a izq usando ese tam
%los demas valores igual parsear basado en el tam de matrix

