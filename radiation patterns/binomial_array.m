% Binomial Array Antenna Radiation Pattern Simulation
% Author: Ahmed Osama
% Date: 07 / 12 / 2024
% Description:
% This script calculates and visualizes the radiation pattern of a binomial 
% array antenna. The user specifies the element spacing as a fraction of 
% the wavelength, the number of elements in the array, and the progressive 
% phase shift. The binomial array achieves a smoother radiation pattern by 
% suppressing sidelobes, at the cost of a narrower main lobe. The script generates:
% 1. A plot of the array factor vs. the phase difference (u).
% 2. A polar plot of the radiation pattern in the azimuthal plane.
% 3. A 3D surface plot of the array factor in Cartesian coordinates.

% Clear command window, and all variables
clc; clear all;

% Prompt user for input parameters
element_spacing_ratio = input('Enter the element spacing as a fraction of the wavelength (e.g., 0.5 for half-wavelength): ');
num_elements = input('Enter the number of elements in the array: '); 
progressive_phase_shift = input('Enter the progressive phase shift (in radians): '); 

% Define angular ranges for azimuth (theta) and polar (phi) angles
theta_angles = -pi : 0.01 : pi; % Azimuth angle range for binomial array
phi_angles = 0 : 0.01 : 2*pi;   % Polar angle range from 0 to 2*pi

% Calculate the phase difference (u) across array elements
u = (progressive_phase_shift + (2 * pi) * element_spacing_ratio * cos(theta_angles)) / 2;

% Compute the array factor (AF) for a binomial array
% Binomial array uses binomial coefficients to minimize sidelobes
AF = abs(cos(u) .^ (num_elements - 1)); % Array factor based on binomial pattern


% Plot the Array Factor (AF) as a function of u
figure;
plot(u, AF, 'LineWidth', 1.5); % Line plot with enhanced visibility
grid on; % Add grid for better readability
xlabel('u (Phase Difference / 2)'); % X-axis label
ylabel('|AF| (Array Factor Magnitude)'); % Y-axis label
title('Array Factor vs. Phase Difference (u)'); % Plot title

% Plot the radiation pattern in the azimuthal plane (polar plot)
figure;
ax = polaraxes; % Create polar plot axes
polarplot(theta_angles, AF, 'LineWidth', 1.5); % Polar plot of the array factor
ax.ThetaZeroLocation = 'bottom'; % Set theta=0 to be at the bottom
title('Radiation Pattern in Azimuthal Plane (Binomial Array)'); % Plot title

% Create a meshgrid for 3D radiation pattern calculations
[theta_grid, phi_grid] = meshgrid(theta_angles, phi_angles); % Create angle grids

% Compute 3D Cartesian coordinates for the radiation pattern
x_coords = AF .* sin(theta_grid) .* cos(phi_grid); % X-coordinate
y_coords = AF .* sin(theta_grid) .* sin(phi_grid); % Y-coordinate
z_coords = AF .* cos(theta_grid);                 % Z-coordinate

% Plot the 3D radiation pattern as a surface
figure;
surf(x_coords, y_coords, z_coords); % 3D surface plot
shading flat; % Use flat shading for better visualization
xlabel('X'); ylabel('Y'); zlabel('Z'); % Add axis labels
title('3D Radiation Pattern of the Binomial Array'); % Plot title
axis equal; % Set equal scaling for all axes