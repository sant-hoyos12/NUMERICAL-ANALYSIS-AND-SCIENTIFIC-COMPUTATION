clear
syms x

x_1 = [0, 2, 3, 5.5, 8.4, 7.6, 6.7, 7.5, 8.5, 10.5, 12.5, 14, 14.4, 13.5, 13, 14.5, 16.5, 18.5, 19, 19.5, 20.5];
y_1 = [1, 6, 7, 7.5, 9.2, 11, 12.8, 17, 18, 19, 18, 16, 14, 12, 10, 7.9, 7, 6, 5, 3, 1];

x_i = [0, 2, 3, 5.5, 8.4];
y_i = [1, 6, 7, 7.5, 9.2];

x_i2 = [6.7, 7.6, 8.4];
y_i2 = [12.8, 11, 9.2];

x_i3 = [6.7, 7.5, 8.5, 10.5, 12.5, 14, 14.4];
y_i3 = [12.8, 17, 18, 19, 18, 16, 14];

x_i4 = [13, 13.5, 14.4];
y_i4 = [10, 12, 14];

x_i5 = [13, 14.5, 16.5, 18.5, 19, 19.5, 20.5];
y_i5 = [10, 7.9, 7, 6, 5, 3, 1];

%generate_splines(x_i, y_i);
%generate_splines(x_i2, y_i2);

s1 = generate_splines(x_i, y_i);
s2 = generate_splines(x_i2, y_i2);
s3 = generate_splines(x_i3, y_i3);
s4 = generate_splines(x_i4, y_i4);
s5 = generate_splines(x_i5, y_i5);



% Imprimir los resultados en decimales
for i = 1:length(s1)
    disp(['Spline S', num2str(i-1), '(x):']);
    disp(s1(i));  % 4 es la cantidad de decimales deseada
end

% Imprimir los resultados en decimales
for i = 1:length(s2)
    disp(['Spline S', num2str(i-1), '(x):']);
    disp(s2(i));  % 4 es la cantidad de decimales deseada
end

for i = 1:length(s3)
    disp(['Spline S', num2str(i-1), '(x):']);
    disp(s3(i));  % 4 es la cantidad de decimales deseada
end

for i = 1:length(s4)
    disp(['Spline S', num2str(i-1), '(x):']);
    disp(s4(i));  % 4 es la cantidad de decimales deseada
end

for i = 1:length(s5)
    disp(['Spline S', num2str(i-1), '(x):']);
    disp(s5(i));  % 4 es la cantidad de decimales deseada
end

%PLOT
figure;
plot(x_1(1:length(x_1)), y_1(1:length(x_1)), 'o', 'MarkerSize', 8, 'MarkerFaceColor', 'b');
hold on;

for i = 1:length(s1)
    eval = linspace(x_i(i), x_i(i+1), 50);
    f_eval = subs(s1(i), x, eval);
    plot(eval, f_eval, 'LineWidth', 2);
end

for i = 1:length(s2)
    eval = linspace(x_i2(i), x_i2(i+1), 50);
    f_eval = subs(s2(i), x, eval);
    plot(eval, f_eval, 'LineWidth', 2);
end

for i = 1:length(s3)
    eval = linspace(x_i3(i), x_i3(i+1), 50);
    f_eval = subs(s3(i), x, eval);
    plot(eval, f_eval, 'LineWidth', 2);
end

for i = 1:length(s4)
    eval = linspace(x_i4(i), x_i4(i+1), 50);
    f_eval = subs(s4(i), x, eval);
    plot(eval, f_eval, 'LineWidth', 2);
end

for i = 1:length(s5)
    eval = linspace(x_i5(i), x_i5(i+1), 50);
    f_eval = subs(s5(i), x, eval);
    plot(eval, f_eval, 'LineWidth', 2);
end


hold off;

xlabel('x');
ylabel('y');
grid on;

function s = generate_splines(x_i, y_i)
    syms x;
    
    n = length(x_i);
    s = sym('s', [1 n-1]);
    df = sym('d', [1 n-1]);
    dd = sym('dd', [1 n-1]); 
    eqn = sym('eqn', [1 4*(n-1)]);
    iter = 1;
    variables = sym('a', [4*(n-1), 1]);
    
    for i = 1:n-1
        a = sym("a" + i);
        b = sym("b" + i);
        c = sym("c" + i);
        d = sym("d" + i);
        variables(i) = a;
        variables(i + (n-1)) = b;
        variables(i + 2*(n-1)) = c;
        variables(i + 3*(n-1)) = d;
        s(i) = a + b*(x - x_i(i)) + c*(x - x_i(i))^2 + d*(x - x_i(i))^3;
        df(i) = b + 2*c*(x - x_i(i)) + 3*d*(x - x_i(i))^2;
        dd(i) = 2*c + 6*d*(x - x_i(i));
        
        if i == n-1
            eqn(iter) = subs(s(i), x, x_i(i)) == y_i(i);
            iter = iter + 1;
            eqn(iter) = subs(s(i), x, x_i(i+1)) == y_i(i+1);
        else
            eqn(iter) = subs(s(i), x, x_i(i)) == y_i(i);
        end
        iter = iter + 1;
    end

    for i = 1:n-2
        eqn(iter) = subs(s(i), x, x_i(i+1)) == subs(s(i+1), x, x_i(i+1));
        iter = iter + 1;
        eqn(iter) = subs(df(i), x, x_i(i+1)) == subs(df(i+1), x, x_i(i+1));
        iter = iter + 1;
        eqn(iter) = subs(dd(i), x, x_i(i+1)) == subs(dd(i+1), x, x_i(i+1));
        iter = iter + 1;
    end

    eqn(iter) = subs(dd(1), x, x_i(1)) == 0;
    iter = iter + 1;
    eqn(iter) = subs(dd(n-1), x, x_i(n)) == 0;

    [A, b] = equationsToMatrix(eqn);
    X = linsolve(A, b);

    for i = 1:n-1
        s(i) = subs(s(i), variables, X);
        eval = linspace(x_i(i), x_i(i+1), 50);
        f_eval = subs(s(i), x, eval);
    end
end
