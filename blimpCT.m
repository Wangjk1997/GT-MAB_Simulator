function dxdt = blimpCT(x, u)
%% Continuous-time nonlinear dynamic model of a pendulum on a cart
%
% 6 states (x): 
%   px
%   vx
%   pz
%   vz
%   theta
%   wy
% 
% 2 inputs: (u)
%   fx
%   fz
% 
% Copyright 2018 The MathWorks, Inc.

%#codegen

%% parameters
m_x = 0.1708;
 m_z = 0.1794;
 D_vxCB = 0.0125;
 D_vzCB = 0.0480;
 r_z = 0.09705;
 m_RB = 0.1249;
 I_y = 0.0066;
 D_wyCB = 0.000862;
 g = 9.8;
 m_Ax = m_x - m_RB;
 m_Az = m_z - m_RB;
 T = 0.26;
%% Compute dxdt
 u1 = u(1);
 u2 = u1 * T;
 u3 = u(2);
 
 dxdt = zeros(6,1);
 dxdt(1) = cos(x(5)) * x(2) + sin(x(5)) * x(4);
 dxdt(2) = (I_y*u1 - D_vxCB*I_y*x(2) - m_RB*r_z*u2 - I_y*m_z*x(4)*x(6) + g*m_RB^2*r_z^2*sin(x(5)) + m_RB^2*r_z^2*x(4)*x(6) + D_wyCB*m_RB*r_z*x(6) + m_RB*m_x*r_z*x(2)*x(4) - m_RB*m_z*r_z*x(2)*x(4))/(- m_RB^2*r_z^2 + I_y*m_x);
 dxdt(3) = -sin(x(5)) * x(2) + cos(x(5)) * x(4);
 dxdt(4) = 1/m_z * (u3 + x(6)*(m_x * x(2) + x(6) * m_RB * r_z) - D_vzCB * x(4));
 dxdt(5) = x(6);
 dxdt(6) = -(m_x^2*x(2)*x(4) - m_x*u2 + D_wyCB*m_x*x(6) + m_RB*r_z*u1 - m_x*m_z*x(2)*x(4) - D_vxCB*m_RB*r_z*x(2) + m_RB*m_x*r_z*x(4)*x(6) - m_RB*m_z*r_z*x(4)*x(6) + g*m_RB*m_x*r_z*sin(x(5)))/(- m_RB^2*r_z^2 + I_y*m_x);
