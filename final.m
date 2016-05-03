choice = questdlg ('¿Que acción deseas realizar?', 'Title', 'Encriptar', 'Desencriptar', 'Encriptar');
graphics_toolkit('qt')
if (strcmp('Encriptar', choice))
	[archivo, archivopath, indice] = uigetfile('', 'Selecciona el archivo a encriptar');
	completo = strcat(archivopath, archivo);
	prompt = {'Primer renglón:','Segundo renglón:', 'Tercer renglón:'};
	titulo = 'Ingresa la matriz de encriptación';
	lineas = 1;
	default = {'3 2 1','9 2 1', '4 5 6'};
	answer = inputdlg(prompt, titulo, lineas, default);
	linea = str2num(answer{1, :});
	linea2 = str2num(answer{2, :});
	linea3 = str2num(answer{3, :});
	encr = [linea; linea2; linea3];
	encripta(completo, encr)
else
	[archivo, archivopath, indice] = uigetfile('', 'Selecciona el archivo a desencriptar');
	encriptado = strcat(archivopath, archivo);
	choice = questdlg ('¿Conoces la matriz de encriptación?', 'Title', 'Sí', 'No', 'Sí');
	
	if (strcmp('Sí', choice))
		prompt = {'Primer renglón:','Segundo renglón:', 'Tercer renglón:'};
		titulo = 'Ingresa la matriz con la que fue encriptado el archivo';
		lineas = 1;
		default = {'3 2 1','9 2 1', '4 5 6'};
		answer = inputdlg(prompt, titulo, lineas, default);
		linea = str2num(answer{1, :});
		linea2 = str2num(answer{2, :});
		linea3 = str2num(answer{3, :});
		usedMatrix = [linea; linea2; linea3]
		decripta(encriptado, usedMatrix)
	else
		decripta(encriptado)
	end
endif






