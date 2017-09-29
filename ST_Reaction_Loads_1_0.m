%   Title:      Reaction Loads
%   Version:    1.0
%   Date:       27.09.2017
%   Description:
%   Calculate reaction loads when grasping a debris with mass Md and moment
%   of inertia Id, with angular momentum w and relative velocity v in a 
%   time Dt and bringing it to rest.
%   Author:     Eric Brunner

% 1.0 Constant definitions
Md  = 300;          % Mass of Debris [kg]
Ld   = 1;            % Side length of debris [m]
Id  = [Md*Ld^2/6, 0, 0; 0, Md*Ld^2/6, 0; 0, 0, Md*Ld^2/6];
w   = [0; 0; 1];    % Angular momentum vector [rad/s]
v   = [0; 0; -1];   % Relative velocity vector [m/s]
Dt  = 10;            % Contact time [s]

% 2.0 Computations

% 2.1 Compute cinetic moment
L = Id*w;

% 2.2 Compute reaction moments
M = -L/Dt;

% 2.3 Compute momentum
P = Md*v;

% 2.3 Compute reaction forces
F = -P/Dt;

% 3.0 Display results
display('Reaction moment');
display(M);
display('Reaction Force');
display(F);

    
