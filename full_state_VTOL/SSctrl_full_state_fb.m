function output = SSctrl_full_state_fb(in,P)
h_d   = in(1);
z_d   = in(2);
z     = in(3);
theta     = in(4);
h = in(5);
zdot     = in(6);
thetadot     = in(7);
hdot = in(8);
t     = in(9);

x = [z; theta; h; zdot; thetadot; hdot];

%equilibrium
Fe = (P.mc+2*P.mr)*P.g;

%error
%error_h = h - h_d;

%error_z = z - z_d;


%___LQR stuff___

%desired state
x_desired = [z_d; 0; h_d; 0; 0; 0];

%calculate the output u
u = -P.K_lqr*(x - x_desired);

%apply saturation
F_out = sat(u(2,1) + Fe, 2*P.fmax);
T_out = sat(u(1,1), P.taumax);

%send the output
output = [F_out; T_out];

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
