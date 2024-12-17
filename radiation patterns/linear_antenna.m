% Dipole Antenna Radiation Pattern Simulation
% Author: Ahmed Osama
% Date: 30 / 11 / 2024
% Description:
% This script calculates and visualizes the radiation pattern of a dipole 
% antenna based on its length relative to the wavelength (lambda). The 
% program generates a 2D polar plot of the radiation pattern and a 3D 
% surface plot of the same pattern in Cartesian coordinates.

% Clear command window, and all variables
clc; clear all;

% Define angular resolution and range for theta (elevation) and phi (azimuth)
% Note: For physical interpretation, theta in spherical coordinates ranges from 0 to pi.
theta_angles = 0 : 0.01 : 2*pi; % Elevation angle range (extended for visualization)
phi_angles = 0 : 0.01 : 2*pi;   % Azimuth angle range

% Prompt the user to input the dipole length relative to the wavelength
dipole_length_ratio = input("Enter the dipole length as a fraction of the wavelength (e.g., 0.5 for half-wave dipole): ");

% Calculate the normalized radiation intensity of the dipole in 2D
% `En_2D` is the normalized electric field magnitude.
% The denominator sin(theta) handles directivity; for theta = 0 or pi, En is undefined.
En_2D = abs((cos(pi * dipole_length_ratio * cos(theta_angles)) - cos(pi * dipole_length_ratio)) ./ sin(theta_angles));

% Handle singularities where theta = 0 or pi (set to zero to avoid NaN/Inf)
En_2D(isnan(En_2D) | isinf(En_2D)) = 0;

% Plot the 2D radiation pattern of the dipole
figure;
ax = polaraxes; % Create polar plot axes
polarplot(theta_angles, En_2D); % Plot electric field magnitude versus angle
ax.ThetaZeroLocation = 'bottom'; % Set theta=0 to be at the bottom
title('2D Radiation Pattern of the Dipole Antenna'); % Set title for the plot

% Create a meshgrid for 3D radiation pattern calculations
% `theta_grid` and `phi_grid` are grids of elevation and azimuth angles
[theta_grid, phi_grid] = meshgrid(theta_angles, phi_angles);

% Compute 3D Cartesian coordinates for the radiation pattern
% `x_coords`, `y_coords`, `z_coords` are the Cartesian coordinates
x_coords = En_2D .* sin(theta_grid) .* cos(phi_grid); % X-coordinate
y_coords = En_2D .* sin(theta_grid) .* sin(phi_grid); % Y-coordinate
z_coords = En_2D .* cos(theta_grid);                  % Z-coordinate

% Plot the 3D radiation pattern as a surface
figure;
surf(x_coords, y_coords, z_coords); % Plot the 3D surface
shading flat; % Use flat shading for better visualization
xlabel('X'); ylabel('Y'); zlabel('Z'); % Add axis labels
title('3D Radiation Pattern of the Dipole Antenna'); % Set title for the 3D plot
axis equal; % Set equal scaling for all axes