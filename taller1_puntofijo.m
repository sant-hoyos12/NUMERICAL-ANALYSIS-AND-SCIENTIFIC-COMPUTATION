% Criterio de parada
epsilon = 1e-4;

% Definición de la función y su función g(x) para iteración de punto fijo
f = @(x) exp(x) - 4*x^2 - 8*x;
g = @(x) log(4*x^2 + 8*x);

% Intervalo inicial
a = 1;
b = 2;

max_iterations = 1000;

tic;
% Evaluar la función en el punto medio del intervalo como valor inicial
x = (a + b) / 2;

for iterations = 1:max_iterations
    x_next = g(x);
    if abs(x_next - x) < epsilon
        root = x_next;
        time = toc;
        fprintf("Raíz aproximada encontrada: x = %.6f\n", root);
        fprintf("Número de iteraciones: %d\n", iterations);
        fprintf("Tiempo: %.6f segundos\n", time);
        break;
    end
    x = x_next;
end

if iterations == max_iterations
    fprintf("No se alcanzó convergencia en el número máximo de iteraciones.\n");
end
