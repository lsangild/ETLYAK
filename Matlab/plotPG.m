load Measurements.mat

% Normalized frequency
Y0 = fft(PG_closed);
%Y1 = fft(PG_hole_bot);
%Y2 = fft(PG_BR_bot);
%Y1 = fft(PK_closed);

% To dB_SPL
Y0 = 20*log10(Y0./20e-6);
%Y1 = 20*log10(Y1./20e-6);
%Y2 = 20*log10(Y2./20e-6);

figure
semilogx(f(1:end/2), abs(Y0(1:end/2)))
hold on
%semilogx(f(1:end/2), abs(Y1(1:end/2)))
%semilogx(f(1:end/2), abs(Y2(1:end/2)))
grid on
xlabel('Frequency (Hz)');
ylabel('dB_{SPL}');
xlim([10, 10e3]);
ylim([40, 120]);
%legend('Closed', 'Hole bot', 'BR bot', "location", "southeast");
%legend('See-through closed', 'Wooden closed', "location", "southeast");