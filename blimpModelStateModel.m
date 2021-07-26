function y = blimpModelStateModel(x, u)

%vector order: px vx pz vz theta omega
%force vector order: u1 u3
vx = x(2);
vz = x(4);
theta = x(5);
omega = x(6);

u1 = u(1);
u3 = u(2);

%initialize non-inputs
mx = 0.1708;
mz = 0.1794;
DvxCB = 0.0125;
DvzCB = 0.0480;
rz = 0.09705;
mRB = 0.1249;
Iy = 0.0066;
DomegaCB = 0.000862;
g = 9.8;
mAx = mx - mRB;
mAy = mz - mRB;
T = 0.26;

u2 = u1 * T;

%calculate d_theta
d_theta = omega;

% calculate d_theta_ddot or d_omega
d2_theta_comp1 = (1/(-mRB^2 * rz^2 + Iy * mx));

d2_theta_comp2_1 = mx^2 * vx * vz;
d2_theta_comp2_2 = mx * u2; 
d2_theta_comp2_3 = DomegaCB * mx * omega;
d2_theta_comp2_4 = mRB * rz * u1; 
d2_theta_comp2_5 = mx * mz * x(2) * vz;
d2_theta_comp2_6 = DvxCB * mRB * rz * vx;
d2_theta_comp2_7 = mRB * mx * rz * vz * omega;
d2_theta_comp2_8 = mRB * mz * rz * vz * omega;
d2_theta_comp2_9 = g * mRB * mx * rz * sin(theta);

d_omega = d2_theta_comp1 * (d2_theta_comp2_1 - d2_theta_comp2_2 ...
    + d2_theta_comp2_3 + d2_theta_comp2_4 - d2_theta_comp2_5 ...
    - d2_theta_comp2_6 + d2_theta_comp2_7 - d2_theta_comp2_8 ...
    + d2_theta_comp2_9);

% calculate d_vx
dp2_x_comp1 = (1/(-(mRB)^2 * rz^2 + Iy * mx));

dp2_x_comp2_1 = Iy * u1;
dp2_x_comp2_2 = DvxCB * Iy * vx;
dp2_x_comp2_3 = mRB * rz * u2;
dp2_x_comp2_4 = Iy * mz * vz * omega;
dp2_x_comp2_5 = g * mRB^2 * rz^2 * sin(theta);
dp2_x_comp2_6 = mRB^2 * rz^2 * vz * omega;
dp2_x_comp2_7 = DomegaCB * mRB * rz * omega;
dp2_x_comp2_8 = mRB * mx * rz * vx * vz;
dp2_x_comp2_9 = mRB * mz * rz * vx * vz;

d_vx = dp2_x_comp1 * (dp2_x_comp2_1 - dp2_x_comp2_2 - dp2_x_comp2_3 ... 
    - dp2_x_comp2_4 + dp2_x_comp2_5 + dp2_x_comp2_6 + dp2_x_comp2_7 ...
    + dp2_x_comp2_8 - dp2_x_comp2_9);

% calculate d_vz
d_vz = (1/mz) * (u3 + omega * (mx * vx + omega * mRB * rz) - DvzCB * vz);

% calculate d_p_x
d_p_x = sin(theta) * vz + cos(theta) * vx;

% calculate d_p_z
d_p_z = -sin(theta) * vx + cos(theta) * vz;

y = [d_theta, d_omega, d_vx, d_vz, d_p_x, d_p_z].';
