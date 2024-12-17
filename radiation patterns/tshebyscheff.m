function T = tshebyscheff(m,z)
%tshebyscheff Summary of this function goes here
%   Detailed explanation goes here
% This recursive function calculates the Tschebyscheff polynomial of 
% degree `m` at the input values `z`. The function supports both 
% classical Tschebyscheff polynomial cases: for |z| ≤ 1 and |z| > 1.
%
% Inputs:
% m - Order of the Tschebyscheff polynomial (integer)
% z - Input values (can be a scalar or array)
%
% Outputs:
% T - Tschebyscheff polynomial values at the input `z`

% Base cases
if m == 0
    T = 1; % T0(z) = 1
    return;
elseif m == 1
    T = z; % T1(z) = z
    return;
end

% Recursive calculation of Tschebyscheff polynomial
T = 2 .* z .* tshebyscheff(m - 1, z) - tshebyscheff(m - 2, z);
end

