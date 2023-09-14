function estimacionY = LagrangeIntervalos(u,v,z)
syms x
if z < u(1) || z > u(length(u))
    error('El dato ingresado no está en el intervalo.');
end

intervalo = find(u > z, 1');

if intervalo == 2 
    Pn = Polinomios_lagrange([u(1),u(2),u(3)],[v(1),v(2),v(3)]);
    estimacionY = vpa(subs(Pn,x,z),6);

elseif intervalo == length(u)
    Pn = Polinomios_lagrange([u(length(v)-2),u(length(v)-1),u(length(v))],[v(length(u)-2),v(length(u)-1),v(length(u))]);
    estimacionY = vpa(subs(Pn,x,z),6);
else
    Pn = Polinomios_lagrange([u(intervalo-2),u(intervalo-1),u(intervalo),u(intervalo+1)],[v(intervalo-2),v(intervalo-1),v(intervalo),v(intervalo+1)]);
    estimacionY = vpa(subs(Pn,x,z),6);
end