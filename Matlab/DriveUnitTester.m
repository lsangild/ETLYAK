clear all

load Measurements.mat

k = DriveUnit();
% setParameters(Qts, Bl, Rms, Mms, Cms, Sd, Re, Rnom, fs)
%k.setParameters(0.66, 5.1, 0.6, 7e-3, 1.45e-3, 5.4, 5.6, 8, 50);
k.setParameters(0.397, 8.2, 1.3036, 14.7e-3, 0.821e-3, 119, 7.2, 8, 45); % See-through speaker


k.plotResponse(logspace(1,4,1000));

%%
% 26.8cm x 20.2cm x 33.0cm
V = (26.8e-2*20.2e-2*33.0e-2); 
u = Cabinet(V);
u.setDriveUnit(k);
u.plotResponse(logspace(1,4,100));

%%
cf = CrossoverFilter();
% setBehaviour(f1, f2, Q, type)
cf.setBehaviour(500, 0.7, 'low');
cf.plotResponse(logspace(1, 4, 100));

%%
sp = Speaker();
set(sp, 'filter', cf);
set(sp, 'cabinet', u);
sp.plotResponse(logspace(0, 3, 100));

%% 
pg = load('PG_closed.mat');

% Normalized frequency
Y = fft(pg.y);

% To dB_SPL
Y = 20*log10(Y./20e-6);

fs = 48000;
T = 2;
f = (0:1:length(Y)-1)*fs/(fs*T);

figure
semilogx(f(1:end/2), abs(Y(1:end/2)))
hold on
grid on
xlabel('Frequency (Hz)');
ylabel('dB_{SPL}');