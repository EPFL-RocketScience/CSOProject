%   Title:      Reaction Loads
%   Version:    1.1
%   Date:       28.09.2017
%   Description:
%   Calculate reaction loads on CSO when a debris is caught by the 
%   capture system and a time Dt elapses before both bodies enter relative
%   rigid motion.
%   Author:     Eric Brunner

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1.0 Problem parameters and constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1.1 Geometry [length, height, width] [m]
G_D = [1, 1, 1];
G_C = [1, 0.6, 0.7];

% 1.2 Inertias
M_D     = 300;          % mass of debris [kg]
M_C     = 100;          % mass of CSO [kg]
I_D     = get_cuboid_inertia(M_D, G_D); % [kg m^2]
I_C     = get_cuboid_inertia(M_C, G_C); % [kg m^2]

% 1.3 Velocities
w_D     = [0,0,0]';      % rotation vector around center axes of debris [rad/s]
w_C     = [0,0,0]';      % rotation vector around center axes of CSO [rad/s]
v_D     = [0,1,0]';      % velocity vector of debri's center of mass [m/s]
v_C     = [1,0,0]';      % velocity vector of CSO's center of mass [m/s]

% 1.4 Distance
d_r     = [1,0,0]';      % distance between two center of masses when captured [m]

% 1.5 Angle
alpha_D = [0,0,0];
alpha_C = [0,0,0];   
DCM_D   = angle_to_dcm(alpha_D);
DCM_C   = angle_to_dcm(alpha_C);

% 1.6 capture time
Dt      = 1;             % capture time [s]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2.0 Computations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 2.1 Cinetic moments
L_D     = I_D*w_D;
L_C     = I_C*w_C;

% 2.2 momentums
P_D     = M_D*v_D;
P_C     = M_C*v_C;

% 2.3 New Inertias
R_D     =  d_r*(M_C/(M_D+M_C));
R_C     = -d_r*(M_D/(M_D+M_C));

I_D_prim= DCM_D'*I_D*DCM_D;
I_C_prim= DCM_C'*I_C*DCM_C;

J_D_prim=I_D_prim + M_D*((R_D'*R_D)*eye(3)-R_D*R_D');
J_C_prim=I_C_prim + M_C*((R_C'*R_C)*eye(3)-R_C*R_C'); 

% 2.4 Conservation of moments 
M_tot   = M_D + M_C;
J_tot   = J_D_prim + J_C_prim;
L_tot   = L_D + L_C; % faux! prendre en compte
P_tot   = P_D + P_C;

% 2.5 New system velocities
w_tot   = J_tot\L_tot; 
v_tot   = P_tot/M_tot;

% 2.6 Reaction forces
L_C_2   = J_C_prim*w_tot;
T_C     = (L_C_2-L_C)/Dt;
P_C_2   = M_C*(cross(R_C, w_tot) + v_tot);
F_C     = (P_C_2-P_C)/Dt;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3.0 Display results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display(T_C);
display(F_C);