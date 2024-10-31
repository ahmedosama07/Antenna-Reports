% |E_θ| = (η * I_m) / (2 π r) { [cos((βl/2)cos(θ)) - cos(βl/2)] / sin(θ) }
% P_max = (|E_θ| ^ 2) / (2 * η)
% W_T = ∫∫ P . dS
%     = (η * I_m ^ 2) * Q / (4 π) 
% G_0 = (4 π r ^ 2) P_max / W_T
%     = 2 F(θ)|_max / Q
% R_rad = 2 W_T / (I_m ^ 2)
%       = { η / (2 π) } Q

dipole = linspace(0, 10, 1000);
theta = linspace(0, pi, 1000);
F_max = zeros(1, length(dipole));
for i = 1:length(dipole)
    F_max(i) = max(((cos(pi .* dipole(i) .* cos(theta)) - cos(pi .* dipole(i))) ./ (sin(theta))) .^ 2);
end
C = double(eulergamma);
Q = C + log(2 .* pi .* dipole) - cosint(2 .* pi .* dipole) ...
    + 0.5 .* sin(2 .* pi .* dipole) .* (sinint(4 .* pi .* dipole) - 2 .* sinint(2 .* pi .* dipole)) ...
    + 0.5 .* cos(2 .* pi .* dipole) .* (C + log(pi .* dipole) + cosint(4 .* pi .* dipole) - 2 .* cosint(2 .* pi .* dipole));

G = 2 .* F_max ./ Q;
R_rad = 60 .* Q;
xlabel('Dipole length \itl \rm(wavelengths)');
yyaxis right
plot(dipole, G, 'LineWidth', 3);
ylabel('\itG_{0} \rm(dimensionless)');
yyaxis left
plot(dipole, R_rad, '--', 'LineWidth', 3);
ylabel('\itR_{rad} \rm(ohms)');
legend('R_{rad} (ohms)','G_{0} (dimensionless)')