epsilon = 0.0005; % 0.05%

% Definición de la función
f = @(x) -2*x.^6 - 1.5*x.^4 + 10*x + 2;

% Definición de la derivada de la función
df = @(x) -12*x.^5 - 6*x.^3 + 10;

ddf = @(x) -60*x.^4 - 18*x.^2;

tic;
[solution, iterations] = newton_raphson(df, ddf, epsilon);
time = toc;
        
fprintf('Solución: %f, Iteraciones: %d, Tiempo: %f segundos\n\n', solution, iterations, time);

% Aplicar método de Newton - Raphson
c_newton_raph = newton_raphson(df, ddf, epsilon);
disp(['Máximo de la Función: ', num2str(c_newton_raph)]);
disp(['Evaluando en F(x) ', num2str(f(c_newton_raph))]);

function [solution, iterations] = newton_raphson(f, df, epsilon)
    p0 = 1.0; % Valor inicial
    
    iterations = 0;
    
    while true
        p1 = p0 - (f(p0) / df(p0));
        
        if abs((p1 - p0)/p1) < epsilon
            break;
        end
        
        p0 = p1;
        iterations = iterations + 1;
    end
    
    solution = p1;
end
