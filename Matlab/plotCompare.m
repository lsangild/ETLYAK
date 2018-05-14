load Measurements.mat

% Normalized frequency
Y0 = fft(PG_closed);
Y1 = fft(PK_closed);

% To dB_SPL
Y0 = 20*log10(Y0./20e-6);
Y1 = 20*log10(Y1./20e-6);

figure
xlabel('Frequency (Hz)');
semilogx(f(1:end/2), abs(Y0(1:end/2)))
hold on
semilogx(f(1:end/2), abs(Y1(1:end/2)))
grid on
xlabel('Frequency (Hz)');
ylabel('dB_{SPL}');
xlim([40, 1000]);
legend('PG Closed', 'PK Closed');