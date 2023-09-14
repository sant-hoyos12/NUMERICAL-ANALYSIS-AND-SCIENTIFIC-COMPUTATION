% Definir la función anónima
f = @(x) -0.1*x.^4 - 0.15*x.^3 - 0.5*x.^2 - 0.25*x + 1.2;
x0 = 0.5;
h = 0.5;


derivada = diff(f(x), x);
derivada = double(subs(derivada, x, x0));

N1 = richardsonExtrapolation(f, x0, h/2, 1);
N2 = richardsonExtrapolation(f, x0, h, 2);
N9 = richardsonExtrapolation(f, x0, h, 9);

fprintf('f''(0.5) = %.4f\n', derivada);
disp(['Resultado N(', num2str(1), '): ', num2str(N1)]);
disp(['Resultado N(', num2str(2), '): ', num2str(N2)]);
disp(['Resultado N(', num2str(9), '): ', num2str(N9)]);

error = abs(N9 - derivada);
disp(['El error absoluto para h = 0.5 con N(5) es: ', num2str(error)]);


function result = richardsonExtrapolation(f, x0, h, j)
    if j == 1
        % Caso base: j = 1, devuelve la estimación de derivada en x0 con h
        result = (f(x0 + h) - f(x0)) / h;
    else
        % Llamada recursiva para calcular N_{j-1}(h) y N_{j-1}(h/2)
        N_j_minus_1_h = richardsonExtrapolation(f, x0, h, j - 1);
        N_j_minus_1_h_over_2 = richardsonExtrapolation(f, x0, h / 2, j - 1);
        
        % Cálculo de N_j(h) utilizando la fórmula de Extrapolación de Richardson
        result = N_j_minus_1_h_over_2 + (N_j_minus_1_h_over_2 - N_j_minus_1_h) / ((4^(j-1) - 1));
    end
end
