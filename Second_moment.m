function Solution = Second_moment(d0, Prepreg_thickness, lamination_distance, lamination_total)
    for lamination_number = 1:1:lamination_total
        D = d0 + Prepreg_thickness*lamination_number;
        d = d0 + Prepreg_thickness*(lamination_number-1);
        rm = (D + d)/4;
        t = (D - d)/2;
        phi = lamination_distance(lamination_number)/(2* pi* D);
        Ix = 2*rm^3 *t *(phi - sin(phi)* cos(phi));
        Ip = 2*lamination_distance(lamination_number)*(D^4 - d^4)/(32 * D);
        Isump(lamination_number) = Ip - Ix;
    end
    Solution = Isump;
end