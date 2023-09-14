% Parámetros 
a = 0; 
b = pi;

% Inicializar la tabla 
R = zeros(5,5);

% Calcular R_k,1 mediante la regla trapezoidal
n = 1; h = (b-a)/n;  
R(1,1) = h/2 * ( f(a) + f(b) );

for k = 2:5
    n = 2^(k-1); 
    h = (b-a)/n;
    x = a:h:b;
    R(k,1) = h/2 * ( f(a) + 2*sum(f(x(2:end-1))) + f(b) ); 
end

% Calcular las demás entradas usando extrapolación
for j = 2:5
    for k = j:5
        R(k,j) = R(k,j-1) + (R(k,j-1) - R(k-1,j-1))/(4^(j-1)-1);
    end
end

% Mostrar resultados
format long;
disp(R)

function y = f(x)
  y = sin(x);
end