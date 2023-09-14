% Intervalo [a, b] y tolerancia para el criterio de convergencia
a = 1;
b = 2;
tolerance = 0.02; % 2%

% Encontrar la raíz para la ecuación 1
root_equation1 = bisection_method(@equation1, a, b, tolerance);
fprintf('Raíz de la ecuación 1: %.6f\n', root_equation1);

% Encontrar la raíz para la ecuación 2
root_equation2 = bisection_method(@equation2, a, b, tolerance);
fprintf('Raíz de la ecuación 2: %.6f\n', root_equation2);

% Función para la ecuación 1: f(x) = x^3 + 4x^2 - 10
function y = equation1(x)
    y = x^3 + 4*x^2 - 10;
end

% Función para la ecuación 2: f(x) = exp(x) - 4 + x
function y = equation2(x)
    y = exp(x) - 4 + x;
end

% Método de bisección
function root = bisection_method(func, a, b, tolerance)
    if func(a) * func(b) > 0
        error('La función no cumple con el teorema de Bolzano en el intervalo proporcionado.');
    end
    
    while (b - a) / 2 > tolerance
        c = (a + b) / 2;
        
        if func(c) == 0
            root = c;
            return;
        elseif func(c) * func(a) < 0
            b = c;
        else
            a = c;
        end
    end
    
    root = (a + b) / 2;
end
