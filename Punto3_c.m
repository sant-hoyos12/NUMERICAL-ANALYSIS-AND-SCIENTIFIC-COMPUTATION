epsilon = 0.0005; % 0.05%

% Definición de la derivada de la función
df = @(x) -12*x.^5 - 6*x.^3 + 10;

tic;
[solution, iterations] = secant_method(df, epsilon);
time = toc;
        
fprintf('Solución: %f, Iteraciones: %d, Tiempo: %f segundos\n\n', solution, iterations, time);

c_secant_method = secant_method(df, epsilon);

disp(['Máximo de la Función: ', num2str(c_secant_method)]);
disp(['Evaluando en F(x) ', num2str(df(c_secant_method))]);

function [solution, iterations] = secant_method(f, epsilon)
    p0 = 0; % Primer punto inicial
    p1 = 1; % Segundo punto inicial
    
    iterations = 0;
    
    while true
        f_p0 = f(p0);
        f_p1 = f(p1);
        
        p2 = p1 - (f_p1 * (p1 - p0)) / (f_p1 - f_p0);
        
        if abs((p2 - p1)/p1) < epsilon
            break;
        end
        
        p0 = p1;
        p1 = p2;
        iterations = iterations + 1;
    end
    
    solution = p2;
end