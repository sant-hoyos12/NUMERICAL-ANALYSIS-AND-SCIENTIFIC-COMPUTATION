% Valor verdadero de la derivada
true_derivative = cos(0.9);

% Valor de h proporcionado
h = 0.005;

% Calcular los valores de f(x) en los puntos relevantes y redondearlos
fx_plus_h = round(sin(x + h), 5);
fx_minus_h = round(sin(x - h), 5);

% Calcular la derivada utilizando la fórmula del punto medio y redondearla
derivative = (1 / (2 * h)) * (fx_plus_h - fx_minus_h);
derivative_rounded = round(derivative, 5);

% Calcular el error absoluto
error = abs(derivative_rounded - true_derivative);
error = round(error, 5);

% Mostrar el resultado
disp(['El error absoluto para h = 0.005 (con términos redondeados) es: ', num2str(error)]);