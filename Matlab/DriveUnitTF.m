s = tf('s');  
Qts = 0.397;
w = 2*pi*45;

a = 4.912*[1, 0, 0];
b = [1, w/Qts, w^2];
H = tf(a, b);

figure()
bode(H);
grid on

[mag, ~, omega, ~, ~] = bode(H);
mag = squeeze(mag);
magdB = 20*log10(mag/20e-6);
f = omega/(2*pi);

figure()
semilogx(f,magdB)
grid on
xlabel('Frequency / Hz');
ylabel('Amplitude / dB_{SPL}');

