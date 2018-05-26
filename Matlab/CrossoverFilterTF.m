s = tf('s');  
Q = 0.3;
f0 = 500;
w0 = 2*pi*f0;
d = 1/(2*Q);

%% Tweeter (highpass filter)
a = [1, 0, 0];
b = [1, 2*d*w0, w0^2];
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

%% Woofer (lowpass filter)
a = [0, 0, w0^2];
b = [1, 2*d*w0, w0^2];
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


