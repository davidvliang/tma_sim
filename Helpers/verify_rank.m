function verify_rank(A, N)
% gamma_rank = verify_rank(gamma);   % gamma is full column rank and rank(gamma)=N


if rank(A) == N+1
    disp(['rank(' inputname(1) ') = N = ' num2str(N)])
else
    disp(['rank(' inputname(1) ') does not equal N'])

end
if size(A,2) == N+1
    disp(['and ' inputname(1) ' is column full rank.'])
else
    disp(['but ' inputname(1) ' is not column full rank.'])

end