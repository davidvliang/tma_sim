function alpha = getFourierCoefficient(n,q,N,L)



if q == 0
    alpha = 2*L/N-1;
else
    alpha = (2*sin(pi*q*L/N)/(pi*q))*exp(-1i*pi*q*((2*n-2+L)/N));
end

