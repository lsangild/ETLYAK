clear all

k = DriveUnit();
l = DriveUnit();
% setParameters(Qts, Bl, Rms, Mms, Cms, Sd, Re, Rnom, fs)
%k.setParameters(0.66, 5.1, 0.6, 7e-3, 1.45e-3, 5.4, 5.6, 8, 50);
k.setParameters(0.397, 8.2, 1.3036, 14.7e-3, 0.821e-3, 119, 7.2, 8, 45); % See-through speaker
l.setParameters(0.4, 3.8, (1/2.2)*sqrt(4.9/0.997), 4.9e-3, 0.997e-3, 55, 3.2, 4, 72); % Wooden
H = k.plotResponse(logspace(1,4,1000));
l.plotResponse(logspace(1,4,1000), H);
legend('ST', 'Wood', 'location', 'southeast');

%%
% 26.8cm x 20.2cm x 33.0cm
% V = (26.8e-2*20.2e-2*33.0e-2);
V = 1.5e-4;

u = Cabinet(V);
u.setDriveUnit(k);
u.plotResponse(logspace(1,4,100));

load Measurements.mat
Y0 = fft(PG_closed);
Y0 = 20*log10(Y0./20e-6);
semilogx(f(1:end/2), abs(Y0(1:end/2)))
xlim([10, 10e3]);
