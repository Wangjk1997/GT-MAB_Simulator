% This function calculate the state function of the GT-MAB. The dynamics of
% the GT-MAB is with respect to the center of gravity. The dynamics
% includes planar motion and vertical motion.

clear; clc; close all

%  x1 -->     px
%  x2 -->     vx
% dx2 --> dot{vx}
%  x3 -->     pz
%  x4 -->     vz
% dx4 --> dot{vz}
%  x5 -->     theta
%  x6 -->     omega_y
% dx6 --> dot{omega_y}

% u1 --> fx
% u2 --> fz
% u3 --> tau_y

syms u1 u2 u3;
syms x1 x2 dx2 x3 x4 dx4 x5 x6 dx6; 
syms mAx mAz mRB mz DvxCB DvzCB Icgy Iy rz DomegaCB g

eqns = [
    dx2*(mAx + mRB) + DvxCB*x2 + x6*(mAz*x4 + mRB*x4) - DvxCB*x6*rz - mAx*dx6*rz - u1 == 0,...
    dx4*(mAz + mRB) + DvzCB*x4 - x6*(mRB*x2 + mAx*(x2 - x6*rz)) - u2 == 0,...
    x4*(mRB*x2 + mAx*(x2 - x6*rz)) + dx6*Icgy - x2*(mAz*x4 + mRB*x4) + x6*(DvxCB*rz^2 + DomegaCB) - DvxCB*rz*x2 - mAx*rz*dx2 + g*mRB*rz*sin(x5)-u3 == 0;
]
[sdx2, sdx4, sdx6] = solve(eqns,[dx2,dx4,dx6])

simplify(sdx2)
simplify(sdx4)
simplify(sdx6)
