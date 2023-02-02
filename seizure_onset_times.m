function [T2] = seizure_onset_times(h,c)
N=5;
% phases differences are kept to 0
phi = zeros(1,N);


% starting point to solve implicit equation 
% the onset of the first node is defined to be 0.
t0      =   rand(1,N);
t0(1)   =   0;

% define implicit function
fun=@(t0)onset_T_h_phi(t0,h,phi,N);

% define MaxIterations

options = optimoptions('fsolve');
options.MaxIterations = 2000;
options.MaxFunctionEvaluations = 1000.*N;

[t,fval,exitflag] = fsolve(fun,t0,options);

if exitflag==1
    T2=t;
    
else
    T2=t0;
end


T2(1) = 0;

T2 = T2.*c;
% F will give the onset of the nodes
function F = onset_T_h_phi(t0,h,phi,N)

for i=2:N
    s=0;
    for j=1:N
        
       s = s - h(i,j).*cos(phi(i)-phi(j)).*(t0(i)./2+0.5.*log(cosh(t0(i)-t0(j)))-0.5.*log(cosh(t0(j))));
    end
    

F(i) = s + 1;

end

F(1) = 0;

end

end