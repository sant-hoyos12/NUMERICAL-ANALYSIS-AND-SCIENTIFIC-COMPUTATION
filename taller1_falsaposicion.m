% Criterio de parada
epsilon = 1e-4;

% Definición de las ecuaciones y funciones
equations = {
    @(x) exp(x) - 4 + x,
    @(x) x - 0.2*sin(x) - 0.5,
    @(x) exp(x*0.5) - x^2 - 3*x,
    @(x) exp(x)*cos(x) - x^2 + 3*x,
    @(x) 0.5*x^3 + x^2 - 2*x - 5,
    @(x) exp(x) - 4*x^2 - 8*x
};

% Intervalo
interval = [1, 2];

methods = {'Falsa posición'};

for eq_num = 1:length(equations)
    f = equations{eq_num};
    a = interval(1);
    b = interval(2);
    
    for method = methods
        fprintf('=================\n');
        fprintf('%s: Ecuación %d\n', char(method), eq_num);
        
        tic;
        [solution, iterations] = false_position(f, a, b, epsilon);
        time = toc;
        
        fprintf('Solución: %f, Iteraciones: %d, Tiempo: %f segundos\n\n', solution, iterations, time);
    end
end

function [solution, iterations] = false_position(f, a, b, epsilon)
    iterations = 0;
    f_a = f(a);
    f_b = f(b);
    
    while abs((a - b)/a) > epsilon
        c = b - (f_b * (b - a)) / (f_b - f_a);
        f_c = f(c);
        
        if abs(f_c) < epsilon
            break;
        end
        
        if f_c * f_a < 0
            b = c;
            f_b = f_c;
        else
            a = c;
            f_a = f_c;
        end
        
        iterations = iterations + 1;
    end
    
    solution = c;
end

