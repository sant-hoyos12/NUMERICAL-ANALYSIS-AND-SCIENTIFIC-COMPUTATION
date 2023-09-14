clear
syms x
x_i = [-1, -0.5, 0, 0.5, 1];
y_i = [0.04, 0.137, 1, 0.137, 0.04];

%Splines
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

% Calculando el polinomio interpolador de Lagrange
P = 0;

for i = 1:n
    L = 1;
    for j = 1:n
        if j ~= i
            L = L * (x - x_i(j)) / (x_i(i) - x_i(j));
        end
    end
    P = P + y_i(i) * L;
end

% Simplificando el polinomio
simplified_P = simplify(P);

% Imprimiendo el polinomio interpolador simplificado
disp("Polinomio interpolador de Lagrange simplificado:");
disp(simplified_P);


% Crear valores x y y para la función original
x_original = -1:0.01:1;
y_original = 1./(1+25.*x_original.^2);


% Graficar la tabla de datos y la función original
figure;
plot(x_i, y_i, 'o', 'MarkerSize', 9, 'MarkerFaceColor', 'b');
hold on;
plot(x_original, y_original, 'r', 'LineWidth', 1.5);

% Graficar el polinomio interpolador
x_eval = linspace(min(x_i), max(x_i), 100);
P_eval = subs(simplified_P, x, x_eval);
plot(x_eval, P_eval, 'g', 'LineWidth', 1.5);

% Graficar los splines obtenidos
for i = 1:n-1
    eval = linspace(x_i(i), x_i(i+1), 50);
    f_eval = subs(s(i), x, eval);
    plot(eval, f_eval, 'LineWidth', 1.5);
end

hold off;

xlabel('x');
ylabel('y');
title('Cubic Splines Interpolation');
legend('Datos Originales', 'Función', 'Interpolador', 'Splines');
grid on;

% Calculando el polinomio interpolador de Lagrange
P = 0;

for i = 1:n
    L = 1;
    for j = 1:n
        if j ~= i
            L = L * (x - x_i(j)) / (x_i(i) - x_i(j));
        end
    end
    P = P + y_i(i) * L;
end
% Simplificando el polinomio
simplified_P = simplify(P);

% Imprimiendo el polinomio interpolador simplificado
disp("Polinomio interpolador de Lagrange simplificado:");

disp(simplified_P);


x_values = 0:0.01:1;
y_values_actual = double(subs(f, x, x_values));

figure;
plot(x_values, y_values_actual, 'b', 'LineWidth', 2);
xlabel('x');
ylabel('f(x)');
title('Función de jorobas integradas');

disp(simplified_P);

% Graficar el polinomio interpolador
x_eval = linspace(min(x_i), max(x_i), 100);
P_eval = subs(simplified_P, x, x_eval);
plot(x_eval, P_eval, 'g', 'LineWidth', 1.5);
grid on;