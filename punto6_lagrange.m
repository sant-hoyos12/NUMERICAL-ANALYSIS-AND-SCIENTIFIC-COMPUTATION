function Pn = Polinomios_lagrange(puntos,imagen)
    syms x
    Pn = 0;
    for i=1:length(puntos)
        L = 1;
    
        if i ==1
            copia = puntos(i+1:end);
        else
            copia = union(puntos(1:i-1),puntos(i+1:end));
        end
    
        for j = 1:length(copia)
            L = L*(x-copia(j))/(puntos(i)-copia(j));
        end
    
        Pn = Pn + (imagen(i)*L);
    end


    x_i = linspace(puntos(1),puntos(end),500);
    resultado = [];
    for i=1:length(x_i)
        resultado(i) = round(double(subs(Pn,x,x_i(i))),6);
        
    end
    
    Pn = simplify(Pn);
    plot(x_i,resultado,'blue')
    hold on
    scatter(puntos,imagen,'filled','red')

end