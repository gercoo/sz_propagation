% function T = propagation_time(dphi,g,h,s)
clear all
g=0.01;
h=2.*g.*0.5;
s=1;
dphi = 0.0*pi;
%% PARAMETERS
 
change =    1;
%% coefficients of current-to-current coupling polynomial (B)

% stationary points 0,1,2,3,4
N = 1;
for i=1:2*N
    a(i) = i/1;
end

b=1;

for j=1:length(a)
    b=b*a(j)*a(j);
end

for i=1:2*N
Br(i) = b.*power(-1,2*N-i);
end


for i=1:N*2
P=nchoosek(1:2*N,i);
D=0;
for l=1:size(P,1)
    ad=1;
    for ii=1:size(P,2)
    ad=ad*a(P(l,ii)).^2;
    end
    
    D = D + 1/ad;
end


Br(i) = Br(i).*D;


clear P
end
Br=-Br;
Br0 = -b;
Br = cat(2,Br0,Br);


for i=1:length(Br)
    B(i) = Br(i).*power(2,2.*i-1).*factorial(i).*factorial(i-1)./factorial(2.*i-1);
end

%% change coefficients
if change ==1
B(2) = 10.5;
end
%% estimate potential
dR=0.01;
R=0:dR:2.1;
Ug=0.*R;
Uh = Ug;
c=1;

for i=1:length(B)
    Ug = Ug -  B(i).*power(2,-2.*i)./i./factorial(i)./factorial(i-1).*factorial(2.*i-1).*power(R,2.*i);
end

Uh = c.*cos(dphi).*R;

U = g.*Ug-h.*Uh;

hold on
plot(R,U)

%% estimate Kramers escape time

% find border between state 1 and 2


t1 = find(R==0.5);
t2 = find(R==1.5);

[A,I]=max(U(1,t1:t2));

R_max = t1+I-1;

% find 1st minima, 
[A,I]=min(U(1,1:R_max));

R_min = I;


% estimate mean duration of state 1

U_max = U(1,R_max);
U_min = U(1,R_min);

% kramers escape rate
ddU = diff(diff(U));

ddU_min = ddU(R_min);
ddU_max = ddU(R_max);

exp(2.*(U_max-U_min)./s.^2)
dR.^2./(2.*pi.*power(-ddU_min.*ddU_max,0.5))

t1_2 = dR.^2./(2.*pi.*power(-ddU_min.*ddU_max,0.5)).*exp(2.*(U_max-U_min)./s.^2);

t1_2

