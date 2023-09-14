% Criterio de parada
epsilon = 1e-4;

% Definición de las ecuaciones
equations = {
    @(x) exp(x) - 4 + x,
    @(x) x - 0.2*sin(x) - 0.5,
    @(x) exp(x*0.5) - x^2 - 3*x,
    @(x) exp(x)*cos(x) - x^2 + 3*x,
    @(x) 0.5*x^3 + x^2 - 2*x - 5,
    @(x) exp(x) - 4*x^2 - 8*x
};

methods = {'Secante'};

for eq_num = 1:length(equations)
    f = equations{eq_num};
    
    for method = methods
        fprintf('=================\n');
        fprintf('%s: Ecuación %d\n', char(method), eq_num);
        
        tic;
        [solution, iterations] = secant_method(f, epsilon);
        time = toc;
        
        fprintf('Solución: %.6f, Iteraciones: %d, Tiempo: %.6f segundos\n\n', solution, iterations, time);
    end
end

function [solution, iterations] = secant_method(f, epsilon)
    p0 = 1; % Primer punto inicial
    p1 = 2; % Segundo punto inicial
    
    iterations = 0;
    
    while true
        f_p0 = f(p0);
        f_p1 = f(p1);
        
        p2 = p1 - (f_p1 * (p1 - p0)) / (f_p1 - f_p0);
        
        if abs(p2 - p1) < epsilon
            break;
        end
        
        p0 = p1;
        p1 = p2;
        iterations = iterations + 1;
    end
    
    solution = p2;
end
