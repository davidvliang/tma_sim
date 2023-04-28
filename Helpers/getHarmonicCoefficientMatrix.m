function gamma = getHarmonicCoefficientMatrix(Q,N,L)
%%% harmonic coefficient matrix corresponding to the modulation function
%%% equation 18 of Ni et. al. 2021
%%% 
%%% Q - harmonic number
%%% N - number of antenna elements
%%% L - "ON" time of phase
   
% fp = 2e6;                       % modulation frequency of RF switches [Hz]
q = -Q:1:Q;                     % range of harmonic values
n = 1:1:N;                      % range of antenna elements
gamma = zeros(length(q),N);     % init gamma
    
%% Ni 2021 (eq5)
for qdx = 1:1:length(q)
    for ndx = 1:1:length(n)
        if q(qdx) == 0
            gamma(qdx,ndx) = 2*L/N-1;
        else
            gamma(qdx,ndx) = (2*sin(pi*q(qdx)*L/N)/(pi*q(qdx)))*exp(-1i*pi*q(qdx)*((2*n(ndx)-2+L)/N));
        end
    end
end 














%% Ni 2021 Modified-1
% for q_idx = 1:1:length(q)
%     for n_idx = 1:1:length(n)
%         if q_idx == 0
%             gamma(q_idx,n_idx) = exp(-1i*2*pi*q_idx*fp)*2*L/N-1;
%         else
%             gamma(q_idx,n_idx) = exp(-1i*2*pi*q_idx*fp)*(2*sin(pi*q_idx*L/N)/(pi*q_idx))*exp(-1i*pi*q_idx*((2*n_idx-2+L)/N));
%         end
%     end
% end  


%% Ni 2021 Modified-2
% for q_idx = 1:1:length(q)
%     for n_idx = 1:1:length(n)
%         if q_idx == 0
%             gamma(q_idx,n_idx) = fp*2*L/N-1;
%         else
%             gamma(q_idx,n_idx) = (2*sin(fp*pi*q_idx*L/N)/(pi*q_idx))*exp(-1i*fp*pi*q_idx*((2*n_idx-2+L)/N));
%         end
%     end
% end


%% He 2018 (eq5)
% for q_idx = 1:1:length(q)
%     for n_idx = 1:1:length(n)
%         fp = (30+0.5*(n_idx-1))*10^6;
%         if q_idx == 0
%             gamma(q_idx,n_idx) = fp*(L/N);
%         else
%             gamma(q_idx,n_idx) = (sin(pi*q_idx*fp*L)/(pi*q_idx))*exp(-1i*pi*fp*(L));
%         end
%     end
% end




