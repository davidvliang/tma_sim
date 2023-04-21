%% Clear Workspace
close all;
clear all;
clc;


%% (uncategorized) Simulation Parameters
br = 500; % bit-rate of incident signal [kbit/s] (500kbit/s)
data_last = 50e-6; % "data last for 50us"? [seconds] (50 us)
fp = 2e6; % modulation frequency of RF switches [Hz] (2MHz)


%% Source Signals
K = [5, 15]; % broadside angles of signal sources [degrees]
snr = 10; % signal-to-noise ratio of each source [dB]


%% Initialize Phased Array
N = 8; % number of antenna elements
d = 0.5; % wavelength spacing between elements [wavelengths]

element = phased.IsotropicAntennaElement;
sULA = phased.ULA('Element',element, ...
                  'NumElements', N, ...
                  'ElementSpacing', d, ...
                  'ArrayAxis','z');


%% Generate Gamma - Harmonic Coefficient Matrix
Q = 4; % maximum sideband signal order Q. Set to maintain full column rank?
L = N/2; % "ON" time of phase 0..

gamma = getHarmonicCoefficientMatrix(Q,N,L);


%% Generate Y(n_t) - Baseband Sideband Signals
c = 3e8; % speed of light
fc = 2.6e9; % center frequency of array [Hz] (2GHz)
lambda = c/fc; % carrier wavelength
snapshots = 100; 

Xnt = sensorsig(getElementPosition(sULA)/lambda, snapshots, K);
Ynt = gamma*Xnt';


%% Equation 21
% Xhat = zeros(N);
% for nt = 1:N
%     Xhat(nt) = inv(gamma'*gamma)*gamma'*Ynt(nt);
% end

Xhat = inv(gamma'*gamma)\gamma'*Ynt;


%% Generate Covariance Matrix 
% xcov = sensorcov(pos,ang, );
% xcov = cov(Xhat);
xcov = Xhat*Xhat'/snapshots; % https://github.com/wodls929/BLE_AOA_Positioning/blob/e08485bf93de9162ca50e66f6c137bee432cf5f0/Music_function.m


%% DF w/ MUSIC
[m_doas,m_spec,m_specang] = musicdoa(xcov,length(K)); display(m_doas);

plot(m_specang,10*log10(m_spec))
xlabel('Arrival Angle (deg)')
ylabel('Magnitude (dB)')
title('MUSIC Spectrum')
grid


%% DF w/ ESPRIT
% [e_doas,e_spec,e_specang] = espritdoa(xcov,length(K)); display(e_doas);
































