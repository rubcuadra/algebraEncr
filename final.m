function [x, ainv, d, solucion] = encripta(archivo,matrixDeEncriptado)
	pathEncriptado = strcat(substr(archivo, 1, index(archivo, '.')), 'mau');
	encriptado = fopen (pathEncriptado, 'w+');
		fid = fopen (archivo, 'r');
			while true
				line = fgets(fid,rows(matrixDeEncriptado))'	;
				if line==-1 fputs(encriptado,'·'); break end %Se nos acabo el doc
				%Si no se puede multiplicar,faltan caracteres
				if columns(matrixDeEncriptado)~=rows(line)
					for k= 1:columns(matrixDeEncriptado)-rows(line)
						line(end+1)=' '; %Rellenamos con Dummy space
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
		%Ultimo valor es dimension de la matriz usada para encriptar
		fputs(encriptado,num2str(rows(matrixDeEncriptado)));
	fclose (encriptado);
end
%encr=[3 2 1;9 2 1;4 5 6]
%encripta('/Users/Ruben/Desktop/4to/Algebra/ProyectoFinal/archivo.txt',encr)