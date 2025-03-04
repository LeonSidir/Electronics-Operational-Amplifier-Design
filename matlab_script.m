%AEM = 9818 so i = 18
i = 18;
%=============
%==Constants==
%=============
L = 10^(-6);
Vop = 180.2 * 10^(-4);
Kp = 2.9352 * 10^(-5);
Kn = 9.6379 * 10^(-5);
Cox = Kp / Vop;
lp = 0.05;
ln = 0.04;
Vin_MAX = 0.1;
Vin_MIN = -0.1;
Vtop = -0.9056;
Vton = 0.786;
%=========================
%==Values depending on i==
%=========================
CL = (2 + 0.01*i) * 10^(-12);
SR = (18 + 0.01*i) * 10^6;
Vdd = 1.8 + 0.003*i;
Vss = -(1.8 + 0.003*i);
GB = (7 + 0.01*i) * 10^6;
A = (20 + 0.01*i);
P = (50 + 0.01*i) * 10^(-3);
%================
%==Calculations==
%================
Cc = 0.22 * CL;
I5 = Cc * SR;
S3 = I5 / (Kp * (Vdd - Vin_MAX - abs(Vtop) -0.15 + Vton -0.15)^2);
fprintf('Current S3 = %f\n', S3);

if S3 < 1
	fprintf('S3 < 1 so S3 = 1\n');
	S3 = 1;
end

S4 = S3;
p3 = sqrt(2 * Kp * S3 * I5/2)/(2 * 0.667 * S3 * (L^2) * Cox);
gm1 = 2 * pi * GB * Cc;
gm2 = gm1;
S1 = gm1^2 / (Kn * I5);
fprintf('Current S1 = %f\n', S1);

if S1 < 1
	fprintf('S1 < 1 so S1 = 1\n');
	S1 = 1;
end

S2 = S1;
Vds5 = Vin_MIN - Vss - sqrt(I5 / (S1*Kn)) - Vton -0.15;
S5 = 2 * I5 / (Kn * Vds5^2);
fprintf('Current S5 = %f\n', S5);

if S5 < 1
	fprintf('S5 < 1 so S5 = 1\n');
	S5 = 1;
end

S8 = S5;
gm6 = 2.2 * gm2 * CL/Cc;
gm4 = sqrt(2 * Kp * S4 * I5/2);
S6 = S4 * gm6 / gm4;
fprintf('Current S6 = %f\n', S6);

if S6 < 1
	fprintf('S6 < 1 so S6 = 1\n');
	S6 = 1;
end

I6 = gm6^2 / (2 * Kp * S6);
S7 = I6 * S5 / I5;
fprintf('Current S7 = %f\n', S7);

if S7 < 1
fprintf('S7 < 1 so S7 = 1\n');
S7 = 1;
end

Av = 2 * gm2 * gm6 / (I5 * (ln + lp) * I6 * (ln + lp));
Pdiss = (I5 + I6) * (Vdd + abs(Vss));
%===============
%==Find each W==
%===============
W1 = S1 * L;
W2 = S2 * L;
W3 = S3 * L;
W4 = S4 * L;
W5 = S5 * L;
W6 = S6 * L;
W7 = S7 * L;
W8 = S8 * L;
%=====================
%==Print the results==
%=====================
fprintf('==========================================\n');
fprintf('==========================================\n');
fprintf('Final Results:\n');
fprintf('CL = %fpF\n', CL*10^(12));
fprintf('SR = %fV/microsec\n', SR*10^(-6));
fprintf('Vdd = %fV\n', Vdd);
fprintf('Vss = %fV\n', Vss);
fprintf('GB = %fMHz\n', GB*10^(-6));
fprintf('A = %fdB\n', A);
fprintf('P = %fmW\n', P*10^(3));
fprintf('==========================================\n');
fprintf('Cc = %.20f\n', Cc);
fprintf('I5 = %.20f\n', I5);
fprintf('S3 = %f\n', S3);
fprintf('S4 = %f\n', S4);
fprintf('p3 = %f rad/sec or %fHz\n', p3, p3/(2*pi));
fprintf('gm1 = %.20f\n', gm1);
fprintf('gm2 = %.20f\n', gm2);
fprintf('S1 = %f\n', S1);
fprintf('S2 = %f\n', S2);
fprintf('Vds5 = %f\n', Vds5);
fprintf('S5 = %f\n', S5);
fprintf('S8 = %f\n', S5);
fprintf('gm6 = %.20f\n', gm6);
fprintf('gm4 = %.20f\n', gm4);
fprintf('S6 = %f\n', S6);
fprintf('I6 = %.20f\n', I6);
fprintf('S7 = %f\n', S7);
fprintf('Av = %f V/V or %fdB\n', Av, 20*log10(Av));
fprintf('Pdiss = %f\n', Pdiss);
fprintf('W1 = %.20f\n', W1);
fprintf('W2 = %.20f\n', W2);
fprintf('W3 = %.20f\n', W3);
fprintf('W4 = %.20f\n', W4);
fprintf('W5 = %.20f\n', W5);
fprintf('W6 = %.20f\n', W6);
fprintf('W7 = %.20f\n', W7);
fprintf('W8 = %.20f\n', W8);
fprintf('==========================================');