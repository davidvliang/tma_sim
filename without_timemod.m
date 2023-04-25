%% Clear Workspace
close all;
clear;
clc;


%% Source Signals
K = [5, 15];        % broadside angles of signal sources [degrees]


%% Initialize Phased Array
N = 8;      % number of antenna elements
d = 0.5;    % wavelength spacing between elements [wavelengths]

element = phased.IsotropicAntennaElement;
sULA = phased.ULA('Element',element, ...
                  'NumElements', N, ...
                  'ElementSpacing', d, ...
                  'ArrayAxis','y');


%% Generate Received Signal Xnt
Nt = 1024;                              % number of Nt snapshots
fc = 300e6;                             % center frequency of array [Hz]
lambda = physconst('LightSpeed')/fc;    % carrier wavelength
pos = getElementPosition(sULA)/lambda;  % element position in wavelengths

Xnt = sensorsig(pos, Nt, K);


%% DF w/ MUSIC + w/o Time Modulation
musicangle = phased.MUSICEstimator('SensorArray',sULA,...
             'OperatingFrequency',fc,'ForwardBackwardAveraging',true,...
             'NumSignalsSource','Property','NumSignals',2,...
             'DOAOutputPort',true);
[~, m_doas] = musicangle(Xnt); display(m_doas);
plotSpectrum(musicangle)


%% DF w/ ESPRIT + w/o Time Modulation 
espritangle = phased.ESPRITEstimator('SensorArray',sULA,...
             'OperatingFrequency',fc,'ForwardBackwardAveraging',true,...
             'NumSignalsSource','Property','NumSignals',2);
e_doas_2 = espritangle(Xnt); display(e_doas_2);





