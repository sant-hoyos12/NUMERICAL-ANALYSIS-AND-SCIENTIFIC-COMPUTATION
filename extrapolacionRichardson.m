% Definir la función f(x)
f = @(x) -0.1*x^4 - 0.15*x^3 - 0.5*x^2 - 0.25*x + 1.2;

% Punto de interés
x0 = 0.5;

% Paso h
h = 0.5;

% Calcular f'(0.5) usando el método de diferencias hacia adelante
derivada = (f(x0 + h) - f(x0)) / h;

% Extrapolación N1(h/2)
h_half = h / 2;
N1_h_2 = (f(x0 + h_half) - f(x0)) / h_half;

% Extrapolación N2(h)
N2_h = N1_h_2 + (N1_h_2 - derivada) / (4 - 1);

% Mostrar resultados
fprintf('f''(0.5) = %.4f\n', derivada);
fprintf('N1(h/2) = %.4f\n', N1_h_2);
fprintf('N2(h) = %.4f\n', N2_h);

% Definir la función f(x)
f2 = @(x) (1/2) * atan(sqrt(x));

% Punto de interés
x0 = 1;

% Paso h
h = 0.1;

% Calcular f'(0.5) usando el método de diferencias hacia adelante
derivada = (f2(x0 + h) - f2(x0)) / h;

% Extrapolación N1(h/2)
h_half = h / 2;
N1_h_2 = (f2(x0 + h_half) - f2(x0)) / h_half;

% Extrapolación N2(h)
N2_h = N1_h_2 + (N1_h_2 - derivada) / (4 - 1);

% Mostrar resultados
fprintf('f2''(0.5) = %.4f\n', derivada);
fprintf('N1(h/2) = %.4f\n', N1_h_2);
fprintf('N2(h) = %.4f\n', N2_h);

