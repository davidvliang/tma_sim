c = physconst('LightSpeed');

lambda = 1; % carrier wavelength

f_c = 2.4e9; % center frequency (Hz)
f_p = 2e6; % modulation frequency (Hz)


myAnt1 = phased.IsotropicAntennaElement; 
myArray1 = phased.ULA('NumElements',8,'ElementSpacing',lambda/2,'Element',myAnt1); 


N = getNumElements(myArray1);
pos = getElementPosition(myArray1);
viewArray(myArray1,'showTaper',true,'ShowIndex','All');
