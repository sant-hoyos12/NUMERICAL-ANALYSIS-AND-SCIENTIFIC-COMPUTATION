% Criterio de parada
epsilon = 1e-4;

% Definición de las ecuaciones y sus derivadas
equations = {
    @(x) exp(x) - 4 + x,
    @(x) x - 0.2*sin(x) - 0.5,
    @(x) exp(x*0.5) - x^2 - 3*x,
    @(x) exp(x)*cos(x) - x^2 + 3*x,
    @(x) 0.5*x^3 + x^2 - 2*x - 5,
    @(x) exp(x) - 4*x^2 - 8*x
};

derivatives = {
    @(x) exp(x) + 1,
    @(x) 1 - 0.2*cos(x),
    @(x) 0.5*exp(0.5*x) - 2*x - 3,
    @(x) exp(x)*cos(x) - 2*x + 3,
    @(x) 1.5*x^2 + 2*x - 2,
    @(x) exp(x) - 8*x
};

methods = {'Newton-Raphson'};

for eq_num = 1:length(equations)
    f = equations{eq_num};
    df = derivatives{eq_num};
    
    for method = methods
        fprintf('=================\n');
        fprintf('%s: Ecuación %d\n', char(method), eq_num);
        
        tic;
        [solution, iterations] = newton_raphson(f, df, epsilon);
        time = toc;
        
        fprintf('Solución: %f, Iteraciones: %d, Tiempo: %f segundos\n\n', solution, iterations, time);
    end
end

function [solution, iterations] = newton_raphson(f, df, epsilon)
    p0 = 1.5; % Valor inicial
    
    iterations = 0;
    
    while true
        p1 = p0 - f(p0) / df(p0);
        
        if abs((p1 - p0)/p1) < epsilon
            break;
        end
        
        p0 = p1;
        iterations = iterations + 1;
    end
    
    solution = p1;
end
