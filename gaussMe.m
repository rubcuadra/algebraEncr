function [ainv, d] = gaussMe(A)
	[r,c] = size(A);ainv=0;%Inicializar retornos
	if r~=c  return end %Si A no es cuadrada regresar 
	d=(A*adj(A))(1,1); %Calculamos determinante usando Adjunta*Original, elementos en diagonal principla son la determinante
	if d==0 return end %SI NO ES INVERTIBLE Tampoco SEGUIR
	[ainv]=GaussJordan(A,eye(r)); %Se manda a llamar con la identidad de rxr
end

function [x] = GaussJordan(A,b)
    a=[A,b]; %Generar matriz expandida
    [m,n]=size(a); %Tamaño de expandida
    for j=1:m-1 
        for z=2:m 
            if a(j,j)==0 %Iteracion para remover 0s de diagonal
                t=a(1,:);a(1,:)=a(z,:); %Principal
                a(z,:)=t;
            end
        end
        for i=j+1:m 
        %Ya que no hay 0 en esta columna en su diagonal se realiza operacion
        %Multiplo y suma de renglon para volver 0s los numeros debajo
        %de la diagonal, actualiza todo el renglon
            a(i,:)=a(i,:)-a(j,:)*(a(i,j)/a(j,j));
        end
    end
    %En este punto ya tenemos los numeros debajo de la diagonal principal
    %Convertidos a 0, debemos convertir ahora los de arriba
    %Misma operacion MultSumaReng pero ahora de arriba hacia abajo
    for j=m:-1:2
        for i=j-1:-1:1
            a(i,:)=a(i,:)-a(j,:)*(a(i,j)/a(j,j));
        end
    end
    %Convertir todos los numeros de la diagonal en 1
    for s=1:m
        a(s,:)=a(s,:)/a(s,s); %Renglon/ValorDiag = 1
        x(s)=a(s,n);
    end
    x = a(:,m+1:end); %Regresar lo que no es la identidad
end

function adjunta=adj(a);
    [r c] = size(a);    %size de la matriz        
    cof = ones(r,c);      %generamos espacio para el retorno       
    a_temp=a;           %temporal para iterar, removeremos columnas
    for i = 1:r
        for k = 1:c
            a_temp([i],:)=[];   %removemos fila i
            a_temp(:,[k])=[];   %removemos fila k
            cof(i,k) = ((-1)^(i+k))*det(a_temp);  %Sacamos COFACTOR
            a_temp=a;   %Regresamos la temporal
        end  
    end
    %return cofactor matrix transposed as output variable
    adjunta = cof';
end

