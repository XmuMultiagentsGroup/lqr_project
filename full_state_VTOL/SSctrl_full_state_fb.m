function output = Planar_VTOL_SSctrl(in,P)
h_d   = in(1);
z_d   = in(2);
z     = in(3);
h     = in(4);
theta = in(5);
zdot     = in(6);
hdot     = in(7);
thetadot = in(8);
t     = in(9);

x = [z; h; theta; zdot; hdot; thetadot];

%equilibrium
Fe = (P.mc+2*P.mr)*P.g;

%error
% integrator on h
error_h = h_d - h;
persistent integrator_h
persistent error_d1_h
% reset persistent variables at start of simulation
if t==0,
    integrator_h  = 0;
    error_d1_h   = 0;
end
if abs(x(5))<0.1,  % note that x(5) = hdot
    integrator_h = integrator_h + (P.Ts/2)*(error_h+error_d1_h);
end
error_d1_h = error_h;

% integrator on z
error_z = z_d - z;
persistent integrator_z
persistent error_d1_z
% reset persistent variables at start of simulation
if t==0,
    integrator_z  = 0;
    error_d1_z   = 0;
end
if abs(x(4))<0.1,  % note that x(4) = zdot
    integrator_z = integrator_z + (P.Ts/2)*(error_z+error_d1_z);
end
error_d1_z = error_z;

%LQR stuff
%x_reorder = [x(1,1); x(3,1); x(2,1); x(4); x(6); x(5)];
x_reorder = [-error_z; x(3,1); -error_h; x(4); x(6); x(5)];


u = -P.K_lqr*x_reorder;
output = [u(2,1) + Fe; u(1,1)];
%output = [Fe; 0];



end


% saturation function
function out = sat(in,limit)
    if     in > limit,      out = limit;
    elseif in < -limit,     out = -limit;
    else                    out = in;
    end
end
