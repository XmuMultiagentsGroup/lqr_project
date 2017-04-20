function output = SSctrl_output_observer_fb(in,P)
h_d   = in(1);
z_d   = in(2);
z     = in(3);
theta     = in(4);
h = in(5);
t     = in(6);

%___equilibrium___
Fe = (P.mc+2*P.mr)*P.g;
%Fe = 0;

%___Observer Implementation___

persistent xhat
persistent dhat
persistent F_out
persistent T_out
if t<P.Ts,
    xhat = [0; 0; 0; 0; 0; 0];
    dhat = [0; 0];
    dhat_h = 0;
    dhat_z = 0;
    F_out      = 0;
    T_out = 0;
end

N = 10;
for i=1:N,
%     xhat = xhat + P.Ts/N*...
%         (P.A_full*(xhat) + P.B_full*[T_out; F_out - Fe] + P.L_full*([z; theta; h] - P.C_full*xhat));
    xhat = xhat + P.Ts/N*...
        (P.A_full*(xhat) + P.B_full*[T_out + dhat(1,1); F_out - Fe + dhat(2,1)] + P.L_full*([z; theta; h] - P.C_full*xhat));
    dhat = dhat + P.Ts/N*P.Ld_full*([z;theta;h]-P.C_full*xhat);
end

%___add integrators___

%_integrator on h
error_h = h_d - h;
persistent integrator_h
persistent error_d1_h
% reset persistent variables at start of simulation
if t<P.Ts==1,
    integrator_h  = 0;
    error_d1_h   = 0;
end
if abs(xhat(6))<0.1,  % note that x6=hdot
    integrator_h = integrator_h + (P.Ts/2)*(error_h+error_d1_h);
end
error_d1_h = error_h;

%_integrator on z
error_z = z - z_d;
persistent integrator_z
persistent error_d1_z
% reset persistent variables at start of simulation
if t<P.Ts==1,
    integrator_z  = 0;
    error_d1_z   = 0;
end
if abs(xhat(4))<0.1,  % note that x4=zdot
    integrator_z = integrator_z + (P.Ts/2)*(error_z +error_d1_z);
end
error_d1_z = error_z;


%___LQR stuff___

%desired state
x_desired = [z_d; 0; h_d; 0; 0; 0];

%calculate the output u
u = -P.K_lqr*(xhat - x_desired);

%add the extra output from the integrator
u(2,1) = u(2,1) + P.k_integrator_h*integrator_h - dhat(2,1);
u(1,1) = u(1,1) + P.k_integrator_z*integrator_z - dhat(1,1);

%apply saturation
F_out = sat(u(2,1) + Fe, 2*P.fmax);
T_out = sat(u(1,1), P.taumax);

%send the output
output = [F_out; T_out; xhat; dhat];

% %integrator on h anti-windup
% if P.k_integrator_h ~= 0,
%     F_unsat = P.Fe + F_tilde;
%     integrator_h = integrator_h + P.Ts/P.k_integrator_h*(F_out - F_unsat);
% end
% 
% %integrator on z anti-windup
% if P.k_integrator_z ~= 0,
%     T_unsat = u(1,1);
%     integrator_z = integrator_z + P.Ts/P.k_integrator_z*(T_out - T_unsat);
% end



end


% saturation function
function out = sat(in,limit)
    if     in > limit,      out = limit;
    elseif in < -limit,     out = -limit;
    else                    out = in;
    end
end
