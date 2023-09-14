clear
syms x
x_i = [-1, -0.5, 0, 0.5, 1];
y_i = [0.04, 0.16, 1, 0.16, 0.04];

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
title('Cubic Splines Interpolation');
legend('Datos Originales', 'Splines');
grid on;