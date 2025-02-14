function Solution = Double_integral(func, Variable, Minimum, Maximum)
    Indefinite_integral = int(func,Variable);
    Definite_integral = integral(@(x) double(subs(Indefinite_integral, Variable, x)), Minimum, Maximum);
    Solution = Definite_integral;
end