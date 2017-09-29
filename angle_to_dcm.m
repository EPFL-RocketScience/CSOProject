function DCM = angle_to_dcm( alpha )
%ANGLE_TO_DCM return dcm based on inputed angles
%
%   DESCRIPTION : calculate dcm based on euler angles given in vector
%   alpha. The transformation sequence is as follows: 1. X, 2. Y, 3. Z.
%   INPUTS:
%   -   alpha   :   1x3, matrice, euler angles [rad]

Q_x = [             1,              0,              0;
                    0,  cos(alpha(1)), -sin(alpha(1));
                    0,  sin(alpha(1)), cos(alpha(1))];
                
Q_y = [ cos(alpha(2)),              0, sin(alpha(2));
                    0,              1,              0;
        -sin(alpha(2)),             0, cos(alpha(2))];
    
Q_z = [ cos(alpha(3)), -sin(alpha(3)),              0;
        sin(alpha(3)),  cos(alpha(3)),              0;
                    0,              0,              1];

DCM = Q_z*Q_y*Q_x;                
end

