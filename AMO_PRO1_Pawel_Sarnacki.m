    R_z = 6378137;      
    C = 299792458;      
    H = 20e6;       
    R = R_z + H;    
    
    
    THETA = [52.885907 50.312052 47.796902 50.619584 55.488272];    
    FI    = [13.395837 12.373351 19.381854 26.244260 28.787526];    
    T = [6.673373199095137e-02 6.678066375193663e-02 6.683909890606424e-02 6.687425145593737e-02 6.693691622507883e-02];
    %T=round(T,17)
    global X_i Y_i Z_i CT;
    
    CT = C .* T;
    
    X_i = R .* cos(deg2rad(THETA)) .* cos(deg2rad(FI));
    Y_i = R .* cos(deg2rad(THETA)) .* sin(deg2rad(FI));
    Z_i = R .* sin(deg2rad(THETA));
    
    
    X_0 = [0 0 0];
    %X_0 = [3.6+06 1.1e+06 5.1e+06];
    %X_0 = [3.6+07 1.1e+07 5.1e+07];
    %X_0 = [1.548362e+07 3.687532e+06 2.103486e+07];
    
    %SOLVER OPTIONS
    SOLVER_OPTIONS = optimoptions(@lsqnonlin, 'Algorithm', 'levenberg-marquardt');
    SOLVER_OPTIONS.Display = 'iter-detailed';
    SOLVER_OPTIONS.MaxIter = 400;                   % wartość domyślna: 400
    SOLVER_OPTIONS.MaxFunctionEvaluations = 200;    % wartość domyślna: 200
    SOLVER_OPTIONS.TolFun = 1e-20;                  % wartość domyślna: 1e-6
    SOLVER_OPTIONS.StepTolerance = 1e-20;           % wartość domyślna: 1e-6
    SOLVER_OPTIONS.OptimalityTolerance = 1e-20;     % wartość domyślna: 1e-6
    SOLVER_OPTIONS.SpecifyObjectiveGradient = true; % wartość domyślna: false
    
    [y, resnorm, residual, exitflag, output] = lsqnonlin(@NMK, X_0, [], [], SOLVER_OPTIONS);
    X = y(1);
    Y = y(2);
    Z = y(3);
    
    r = sqrt(X^2 + Y^2 + Z^2);
    szerokosc = rad2deg(asin(Z / r));
    dlugosc = rad2deg(atan(Y / X));
    
    x = sprintf('Szerokosc: %f\nDlugosc: %f\n', szerokosc, dlugosc);
    disp(x)
    display(resnorm)
