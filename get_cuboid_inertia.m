function I = get_cuboid_inertia( M, L )
%   GET_PARALLELIPEPED_INERTIA return inertia tensor
%
%   DESCRIPTION : calculate inertia of a parallepiped of homogeneously distributed
%   mass M and side lengths L.
%   INPUTS:
%   -   M   :   scalar, Mass of body [kg]
%   -   L   :   1x3, matrice, Lengths of body [kg]

I = [   M/12*(L(2)^2+L(3)^2), 0                     , 0                     ;
        0                   , M/12*(L(1)^2+L(3)^2)  , 0                     ;
        0                   , 0                     , M/12*(L(1)^2+L(2)^2)] ;

end

