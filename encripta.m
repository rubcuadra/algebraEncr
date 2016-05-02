function [archivoEncriptado] = encripta(archivo,matrixDeEncriptado)
	archivoEncriptado = strcat(substr(archivo, 1, index(archivo, '.')), 'mau');
	encriptado = fopen (archivoEncriptado, 'w+');
		fid = fopen (archivo, 'r');
			while true
				line = fgets(fid,rows(matrixDeEncriptado))'	;
				if line==-1 fputs(encriptado,'·'); break end %Se nos acabo el doc
				%Si no se puede multiplicar,faltan caracteres
				if columns(matrixDeEncriptado)~=rows(line)
					for k= 1:columns(matrixDeEncriptado)-rows(line)
						line(end+1)=' '; %Rellenamos con Dummy space
					end
					%Esta linea invierte si necesita
					%Cuando es 1 caracter octave interpreta raro
					if rows(line)==1 line=line'; end 
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
		%Guardamos el formto original
		fputs(encriptado,'··');
		fputs(encriptado,substr(archivo, index(archivo, '.')+1));
	fclose (encriptado);
end