%% Clear Workspace
close all;
clear;
clc;


%% (uncategorized/unused) Simulation Parameters
br = 500;           % bit-rate of incident signal [kbit/s]
data_last = 50e-6;  % "data last for 50us"? [seconds] 
fp = 2e6;           % modulation frequency of RF switches [Hz]
snr = 10;           % signal-to-noise ratio of each k source [dB]


%% Source Signals
K = [5, 15];        % broadside angles of signal sources [degrees]


%% Initialize Phased Array
N = 8;              % number of antenna elements
d = 0.5;            % wavelength spacing between elements [wavelengths]

element = phased.IsotropicAntennaElement;
sULA = phased.ULA('Element', element, ...
                  'NumElements', N, ...
                  'ElementSpacing', d, ...
                  'ArrayAxis','y');


%% Generate Gamma - Harmonic Coefficient Matrix
Q = 4;      % maximum sideband signal order Q. Maintain full column rank?
L = 1.5;    % "ON" time of phase 0. L∈(0,N/2]. L=1.5 is best value.

gamma = getHarmonicCoefficientMatrix(Q,N,L);


%% Generate Y(n_t) - Baseband Sideband Signals
snapshots = 1024;                       % number of Nt snapshots
fc = 2.6e9;                             % center frequency of array [Hz]
lambda = physconst('LightSpeed')/fc;    % carrier wavelength
rs = rng(2021);                         % set rng for sensorsig

Xnt = sensorsig(getElementPosition(sULA)/lambda, snapshots, K);
Ynt = gamma*Xnt.';                      % A.' means nonconjugate transpose 

% figure;
% pspectrum(Ynt(1,:)')
% figure;
% pwelch(Ynt')


%% Equation 21
Xhat = inv(gamma'*gamma)\gamma'*Ynt;    % A' means conjugate transpose


%% Generate Covariance Matrix 
xcov = Xhat*Xhat'/snapshots;


%% DF w/ MUSIC
[m_doas,m_spec,m_specang] = musicdoa(xcov,length(K)); display(m_doas);

figure;
plot(m_specang,10*log10(m_spec))
xlabel('Arrival Angle (deg)')
ylabel('Magnitude (dB)')
title('MUSIC Spectrum')
grid


%% DF w/ ESPRIT
e_doas = espritdoa(xcov,length(K)); display(e_doas);
























