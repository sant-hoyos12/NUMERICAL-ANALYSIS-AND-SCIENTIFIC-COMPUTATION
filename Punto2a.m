% Datos del problema
v = 36; % m/s
c = 15; % kg/s
t = 10; % s
g = 9.81; % m/s^2

% Función de velocidad en función de la masa
f = @(m) (g*m/c) * (1 - exp(-c*t/m)) - v;

% Intervalo inicial para el método de bisección
a = 0.01; % Valor mínimo posible para la masa
b = 100; % Valor máximo posible para la masa

% Criterio de parada
epsilon = 0.0002; % 0.02%

% Aplicar método de bisección
m_bisection = bisection_method(f, a, b, epsilon);
disp(['Masa (Método de Bisección): ', num2str(m_bisection), ' kg']);

% Aplicar método de falsa posición
m_false_position = false_position_method(f, a, b, epsilon);
disp(['Masa (Método de Falsa Posición): ', num2str(m_false_position), ' kg']);

function solution = bisection_method(f, a, b, epsilon)
    while abs((a - b)/a) > epsilon
        c = (a + b) / 2;
        if f(c) == 0
            break;
        elseif f(c) * f(a) < 0
            b = c;
        else
            a = c;
        end
    end
    solution = (a + b) / 2;
end

function solution = false_position_method(f, a, b, epsilon)
    f_a = f(a);
    f_b = f(b);
    
    while abs((a - b)/a) > epsilon
        c = b - (f_b * (b - a)) / (f_b - f_a);
        f_c = f(c);
        
        if abs(f_c) < epsilon
            break;
        end
        
        if f_c * f_a < 0
            b = c;
            f_b = f_c;
        else
            a = c;
            f_a = f_c;
        end
    end
    
    solution = c;
end
