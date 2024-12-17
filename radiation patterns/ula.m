% Uniform Linear Array (ULA) Radiation Pattern Simulation
% Author: Ahmed Osama
% Date: 30 / 11 / 2024
% Description:
% This script calculates and visualizes the array factor (AF) of a uniform 
% linear array (ULA) antenna. The user specifies the element spacing as a 
% fraction of the wavelength, the number of elements in the array, and the 
% progressive phase shift. The script generates:
% 1. A plot of the array factor vs. the phase difference (psi).
% 2. A polar plot of the radiation pattern in the azimuthal plane.
% 3. A 3D surface plot of the array factor in Cartesian coordinates.

% Clear command window, and all variables
clc; clear all;

% Prompt user for input parameters
element_spacing_ratio = input('Enter the element spacing as a fraction of the wavelength (e.g., 0.5 for half-wavelength): ');
num_elements = input('Enter the number of elements in the array: '); 
progressive_phase_shift = input('Enter the progressive phase shift (in radians): '); 

% Define angular ranges for azimuth (gamma) and polar (phi) angles
gamma_angles = 0 : 0.01 : 2*pi; % Azimuth angle range from 0 to 2*pi
phi_angles = 0 : 0.01 : 2*pi;   % Polar angle range from 0 to 2*pi

% Calculate the phase difference (psi) across array elements
psi = progressive_phase_shift + (2 * pi) * element_spacing_ratio * cos(gamma_angles);

% Compute the array factor (AF) using the uniform linear array formula
% `AF` represents the normalized amplitude of the radiation pattern
AF = abs((sin(num_elements * psi ./ 2)) ./ (num_elements * sin(psi ./ 2)));

% Handle singularities where sin(psi/2) = 0 (set to max value to avoid NaN/Inf)
AF(isnan(AF) | isinf(AF)) = 1; 

% Plot the Array Factor (AF) as a function of psi
figure;
plot(psi, AF, 'LineWidth', 1.5); % Line plot with enhanced visibility
grid on; % Add grid for better readability
xlabel('\psi (Phase Difference)'); % X-axis label
ylabel('|AF| (Array Factor Magnitude)'); % Y-axis label
title('Array Factor vs. Phase Difference (\psi)'); % Plot title

% Plot the radiation pattern in the azimuthal plane (polar plot)
figure;
ax = polaraxes; % Create polar plot axes
polarplot(gamma_angles, AF, 'LineWidth', 1.5); % Polar plot of the array factor
ax.ThetaZeroLocation = 'bottom'; % Set theta=0 to be at the bottom
title('Radiation Pattern in Azimuthal Plane (ULA)'); % Plot title

% Create a meshgrid for 3D radiation pattern calculations
[gamma_grid, phi_grid] = meshgrid(gamma_angles, phi_angles); % Create angle grids

% Compute 3D Cartesian coordinates for the radiation pattern
x_coords = AF .* sin(gamma_grid) .* cos(phi_grid); % X-coordinate
y_coords = AF .* sin(gamma_grid) .* sin(phi_grid); % Y-coordinate
z_coords = AF .* cos(gamma_grid);                 % Z-coordinate

% Plot the 3D radiation pattern as a surface
figure;
surf(x_coords, y_coords, z_coords); % 3D surface plot
shading flat; % Use flat shading for better visualization
xlabel('X'); ylabel('Y'); zlabel('Z'); % Add axis labels
title('3D Radiation Pattern of the ULA'); % Plot title
axis equal; % Set equal scaling for all axes