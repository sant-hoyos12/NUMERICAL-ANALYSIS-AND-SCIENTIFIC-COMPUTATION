clear
syms x

x_i = [2006, 2008, 2011, 2012, 2015, 2017, 2018, 2020, 2021, 2022];
y_i = [0.6455, 0.6818, 0.703, 0.6676, 0.698, 0.704, 0.717, 0.723, 0.716, 0.736];

n = length(x_i);
s = sym('s',[1 n-1]);
df = sym('d',[1 n-1]);
dd= sym('dd',[1 n-1]); 
eqn = sym('eqn',[1 4*(n-1)]);
iter = 1;
variables = sym('a',[4*(n-1) 1]);
for i=1:n-1
    a = sym("a"+i);
    b = sym("b"+i);
    c = sym("c"+i);
    d = sym("d"+i);
    variables(i) = a;
    variables(i+(n-1)) = b;
    variables(i+2*(n-1)) = c;
    variables(i+3*(n-1)) = d;
    s(i) = a + b*(x-x_i(i)) + c*(x-x_i(i))^2 + d*(x-x_i(i))^3;
    df(i) = b + 2*c*(x-x_i(i)) + 3*d*(x-x_i(i))^2;
    dd(i) = 2*c + 6*d*(x-x_i(i));
    
    if i == n-1
        eqn(iter) = subs(s(i),x,x_i(i)) == y_i(i);
        iter = iter+1;
        eqn(iter) = subs(s(i),x,x_i(i+1)) == y_i(i+1);
    else
        eqn(iter) = subs(s(i),x,x_i(i)) == y_i(i);
    end
    iter = iter+1;
end


for i = 1:n-2
    eqn(iter) = subs(s(i),x,x_i(i+1)) == subs(s(i+1),x,x_i(i+1));
    iter = iter+1;
    eqn(iter) = subs(df(i),x,x_i(i+1)) == subs(df(i+1),x,x_i(i+1));
    iter = iter+1;
    eqn(iter) = subs(dd(i),x,x_i(i+1)) == subs(dd(i+1),x,x_i(i+1));
    iter = iter+1;
end

eqn(iter) = subs(dd(1),x,x_i(1)) == 0;
iter = iter+1;
eqn(iter) = subs(dd(n-1),x,x_i(n)) == 0;

[A,b] = equationsToMatrix(eqn);

X = linsolve(A,b);

for i = 1:n-1
    s(i) = subs(s(i),variables,X);
    eval = linspace(x_i(i),x_i(i+1),50);
    f_eval = subs(s(i),x,eval);
end

% Imprimir los resultados en decimales
for i = 1:n-1
    disp(['Spline S', num2str(i-1), '(x):']);
    disp(vpa(s(i), 4));  % 4 es la cantidad de decimales deseada
end

% Graficar la tabla de datos
figure;
plot(x_i, y_i, 'o', 'MarkerSize', 8, 'MarkerFaceColor', 'b');
hold on;

% Graficar los splines obtenidos
for i = 1:n-1
    eval = linspace(x_i(i), x_i(i+1), 50);
    f_eval = subs(s(i), x, eval);
    plot(eval, f_eval, 'LineWidth', 2);
end

hold off;

xlabel('x');
ylabel('y');
title('Interpolación de Splines Cúbicos');
legend('Datos Originales', 'Splines');
grid on;

% Evaluar S0 en x = 2007
s(1) = subs(s(1),variables,X);
estimation = double(subs(s(1), x, 2007));
disp(['Estimación en x = 2007: ', num2str(estimation)]);

% Evaluar S1 en x = 2009
s(2) = subs(s(2),variables,X);
estimation = double(subs(s(2), x, 2009));
disp(['Estimación en x = 2009: ', num2str(estimation)]);

% Evaluar S1 en x = 2010
s(2) = subs(s(2),variables,X);
estimation = double(subs(s(2), x, 2010));
disp(['Estimación en x = 2010: ', num2str(estimation)]);

% Evaluar S3 en x = 2013
s(4) = subs(s(4),variables,X);
estimation = double(subs(s(4), x, 2013));
disp(['Estimación en x = 2013: ', num2str(estimation)]);

% Evaluar S3 en x = 2014
s(4) = subs(s(4),variables,X);
estimation = double(subs(s(4), x, 2014));
disp(['Estimación en x = 2014: ', num2str(estimation)]);

% Evaluar S4 en x = 2016
s(5) = subs(s(5),variables,X);
estimation = double(subs(s(5), x, 2016));
disp(['Estimación en x = 2016: ', num2str(estimation)]);

% Evaluar S6 en x = 2019
s(7) = subs(s(7),variables,X);
estimation = double(subs(s(7), x, 2019));
disp(['Estimación en x = 2019: ', num2str(estimation)]);


% Supongamos que tienes un valor de y que deseas encontrar su correspondiente x
target_y = 0.7250;  % Cambia esto al valor de y que tengas

% Evaluar los splines en intervalos pequeños de x
x_eval = linspace(min(x_i), max(x_i), 1000);

% Inicializar variables
approx_x = NaN;  % Valor de x aproximado correspondiente a target_y
approx_error = Inf;  % Error absoluto mínimo encontrado

% Iterar a través de los splines y encontrar el x correspondiente a target_y
for i = 1:length(s)
    y_eval = subs(s(i), x, x_eval);
    
    % Encontrar la diferencia mínima entre target_y y los valores evaluados
    [min_diff, idx] = min(abs(y_eval - target_y));
    
    % Actualizar si se encontró una diferencia más pequeña
    if min_diff < approx_error
        approx_error = min_diff;
        approx_x = x_eval(idx);
    end
end

disp(['Valor de x aproximado para y = ', num2str(target_y), ': ', num2str(approx_x)]);
