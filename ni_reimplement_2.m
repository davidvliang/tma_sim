%% Clear Workspace
close all;
clear;
clc;


%% (uncategorized/unused) Simulation Parameters
br = 500;               % bit-rate of incident signal [kbit/s]
data_last = 50e-6;      % "data last for 50us"? [seconds] 
    

%% Source Signals
K = [5, 15];            % broadside angles of signal sources [degrees]
snr = 10;               % signal-to-noise ratio of each k source [dB]


%% Initialize Phased Array
fc = 2e9;                               % center frequency of array [Hz]
lambda = physconst('LightSpeed')/fc;    % carrier wavelength
N = 8;                                  % number of antenna elements
d = lambda/2;                           % spacing between elements

element = phased.IsotropicAntennaElement;
sULA = phased.ULA('Element', element, ...
                  'NumElements', N, ...
                  'ElementSpacing', d, ...
                  'ArrayAxis','y');


%% Generate Recvd Incident Signal, Xn(t)
Nt = 100;                               % number of snapshots
rs = rng(2021);                         % set rng for sensorsig

Xnt = sensorsig(getElementPosition(sULA)/lambda, Nt, K, db2pow(-snr));
Xnt = Xnt.';                            % set dimensions to NxNt

% estimator = phased.BeamscanEstimator('SensorArray',sULA,...
%    'PropagationSpeed',physconst('LightSpeed'),'OperatingFrequency',fc,...
%    'DOAOutputPort',true,'NumSignals',length(K));
% [~,ang_est] = estimator(Xnt.');
% plotSpectrum(estimator)


%% Initialize Harmonic Coefficient Matrix, Gamma
Q = 4;      % maximum sideband signal order Q. Maintain full column rank
L = 1.5;    % "ON" time of phase 0. L∈(0,N/2]. L=1.5 is best value.

gamma = getHarmonicCoefficientMatrix(Q,N,L);


%% Equation 6: Generate Single Channel RF Signal, Y(t)
fp = 2e6;                       % modulation frequency of RF switches [Hz]

Yt = getSingleChannel(fp, gamma, Xnt);  % modulate+combine recvd signals

% figure;
% pspectrum(Yt(1,:)')
% figure;
% pwelch(Yt')


%% Separate Single Channel into Baseband Sideband Signals, Y(nt)
Ynt = Yt;           % using 'harmonic recovery' and 'compressed sensing'

% figure;
% pspectrum(Ynt(1,:)')
% figure;
% pwelch(Ynt')


%% Equation 21: Recover Array Signals, Xhat
Xhat = inv(gamma'*gamma)\gamma'*Ynt;


%% Generate Covariance Matrix 
xcov = Xhat*Xhat'/Nt;
% xcov = Xnt*Xnt'/Nt;                     % For non-TMA DOA


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

















