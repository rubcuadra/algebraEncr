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
	fclose (encriptado);
end
function [archivodecriptado] = decripta(archivo)
	fid = fopen (archivo, 'r');
		line = fgets(fid); %Leemos todo el documento
	fclose(fid);
	encoded = strsplit(line,'··'); %Separamos entre texto y matrix
	usedMatrix = parseMatrix(encoded{1,2});
	[decoderMatrix deter] = gaussMe(usedMatrix); %Nos regresa det y su inversa si existe
	if deter==0
		disp('No tiene solucion, fue encriptado con una matriz no invertible');
		return
	end
	%Aqui ya podemos decriptar
	
	encodedValues = strsplit(encoded{1,1},'·');
	%Dividimos en partes, se iteraran varias veces para multiplicar
	pv = zeros(rows(decoderMatrix),1); ix = 0;
	for i = [1: columns(encodedValues)/rows(decoderMatrix)]
		for val = [1:rows(pv)]
			pv(val)= str2num(encodedValues{1,val+ix});
		end
		%Aqui ya se puede multiplicar por que ya se lleno pv
		%Esta linea de abajo nos va dando los caracteres, dejar en txt
		setstr(decoderMatrix*pv)'
		ix+=rows(pv);
	end
end

function [matrix] = parseMatrix(enc_matx)
	sz = str2num(enc_matx(end)) ; %Obtener size
	matrix = zeros(sz) ; %Inicializar matrix
	vals = strsplit(enc_matx,'·'); %Split basandonos en ·
	ix = 0;
	for i = [1:sz]
		for j = [1:sz]
			matrix(j,i) = str2num(vals{1,j+ix});
		end
		ix+=sz; %Updateamos
	end
end
function retval = setstr (varargin)
  retval = char (varargin{:});
endfunction

%encr=[3 2 1;9 2 1;4 5 6]
%encripta('/Users/Ruben/Desktop/4to/Algebra/ProyectoFinal/archivo.txt',encr)
decripta('/Users/Ruben/Desktop/4to/Algebra/ProyectoFinal/archivo.mau')

