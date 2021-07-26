% This function calculate the state function of the GT-MAB. The dynamics of
% the GT-MAB is with respect to the center of gravity. The dynamics
% includes planar motion and vertical motion.

clear; clc; close all

%  x1 -->     vx
% dx1 --> dot{vx}
%  x2 -->     vz
% dx2 --> dot{vz}
%  x3 -->     theta
%  x4 -->     omega_y
% dx4 --> dot{omega_y}

% u1 --> fx
% u2 --> fz
% u3 --> tau_y

syms u1 u2 u3;
syms x1 dx1 x2 dx2 x3 x4 dx4; 
syms mAx mAz mRB mz DvxCB DvzCB Icgy Iy rz DomegaCB g

eqns = [
    dx1*(mAx + mRB) + DvxCB*x1 + x4*(mAz*x2 + mRB*x2) - DvxCB*x4*rz - mAx*dx4*rz - u1 == 0,...
    dx2*(mAz + mRB) + DvzCB*x2 - x4*(mRB*x1 + mAx*(x1 - x4*rz)) - u2 == 0,...
    x2*(mRB*x1 + mAx*(x1 - x4*rz)) + dx4*Icgy - x1*(mAz*x2 + mRB*x2) + x4*(DvxCB*rz^2 + DomegaCB) - DvxCB*rz*x1 - mAx*rz*dx1 + g*mRB*rz*sin(x3)-u3 == 0;
]
[sdx1, sdx2, sdx4] = solve(eqns,[dx1,dx2,dx4])

simplify(sdx1)
simplify(sdx2)
simplify(sdx4)
