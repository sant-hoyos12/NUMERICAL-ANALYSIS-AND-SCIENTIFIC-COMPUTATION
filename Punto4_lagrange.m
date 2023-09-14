% Datos de la tabla
x_data = [1.6, 2, 2.5, 3.2, 4, 4.5];
f_data = [2, 8, 14, 15, 8, 2];
n = length(x_data);

% Símbolo 'x' para representar el polinomio
syms x;

% Calculando el polinomio interpolador de Lagrange
P = 0;

for i = 1:n
    L = 1;
    for j = 1:n
        if j ~= i
            L = L * (x - x_data(j)) / (x_data(i) - x_data(j));
        end
    end
    P = P + f_data(i) * L;
end

% Simplificando el polinomio
simplified_P = simplify(P);

% Imprimiendo el polinomio interpolador simplificado
disp("Polinomio interpolador de Lagrange simplificado:");
disp(simplified_P);

% Graficando la tabla de datos y el polinomio interpolador
x_eval = linspace(min(x_data), max(x_data), 100);
P_eval = subs(simplified_P, x, x_eval);

figure;
plot(x_data, f_data, 'o', 'MarkerFaceColor', 'b', 'DisplayName', 'Datos');
hold on;
plot(x_eval, P_eval, 'r', 'DisplayName', 'Polinomio Interpolador');
xlabel('x');
ylabel('f(x)');
title('Tabla de Datos y Polinomio Interpolador de Lagrange');
legend;
grid on;

% Calculando f(2.8)
x_value = 2.8;
f_2_8 = subs(simplified_P, x, x_value);
simplified_f = simplify(f_2_8);
disp("El valor de f(2.8) es:");
disp(simplified_f);