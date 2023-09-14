epsilon = 0.0005; % 0.05%

% Definición de la función
f = @(x) -2*x.^6 - 1.5*x.^4 + 10*x + 2;

% Definición de la derivada de la función
df = @(x) -12*x.^5 - 6*x.^3 + 10;

%Definición de g(x)
g = @(x) nthroot((-6*x^3 + 10) / 12, 5);

% Intervalo inicial
a = 0.5;
b = 1.5;

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