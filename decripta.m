function [archivodecriptado] = decripta(archivo, selfMatrix = false)
	fid = fopen (archivo, 'r');
		line = fgets(fid); %Leemos todo el documento
	fclose(fid);
	encoded = strsplit(line,'··'); %Separamos entre texto y matrix y ending
	archivodecriptado = strcat(substr(archivo, 1, index(archivo, '.')), encoded{1,3}); %generamos archivo original
	if selfMatrix==false
		usedMatrix = parseMatrix(encoded{1,2}); %Parseamos matrix
	else
		usedMatrix = selfMatrix;
	end
	[decoderMatrix deter] = gaussMe(usedMatrix); %Nos regresa det y su inversa si existe
	if deter==0
		disp('No tiene solucion, la matriz no es invertible');
		usedMatrix
		return
	end
	%Aqui ya podemos decriptar
	decr = fopen (archivodecriptado, 'w+');
		encodedValues = strsplit(encoded{1,1},'·');
		%Dividimos en partes, se iteraran varias veces para multiplicar
		pv = zeros(rows(decoderMatrix),1); ix = 0;
		for i = [1: columns(encodedValues)/rows(decoderMatrix)]
			for val = [1:rows(pv)]
				pv(val)= str2num(encodedValues{1,val+ix});
			end
			%Aqui ya se puede multiplicar por que ya se lleno pv
			%vs tiene los valores numericos decriptados
			vs = (decoderMatrix*pv)';
			d = find(10==vs); %Break line code en ASCII es 10
			if d %Si encontro un break, deja texto de 1 hasta break
				vs = vs(1:d); %Sliceamos hasta breakLine
			end
			chars = setstr(vs); %convierte de numero a ascii
			fputs(decr, chars); %dump en file
			ix+=rows(pv); %Proximos chars
		end
	fclose(decr);
end

function [matrix] = parseMatrix(enc_matx)
	sz = str2num(enc_matx(end)) ; %Obtener size, es el ultimo digito
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