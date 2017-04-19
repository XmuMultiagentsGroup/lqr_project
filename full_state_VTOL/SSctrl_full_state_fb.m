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



%LQR stuff
x_reorder = [x(1,1); x(3,1); x(2,1); x(4); x(6); x(5)];
u = -P.K_lqr*x_reorder;
output = [u(2,1) + Fe; u(1,1)];


end


% saturation function
function out = sat(in,limit)
    if     in > limit,      out = limit;
    elseif in < -limit,     out = -limit;
    else                    out = in;
    end
end
