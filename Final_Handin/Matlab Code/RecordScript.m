%% Create chirp
fs = 48000;
T = 2;

t = 0:1/fs:T - 1/fs;
ch = chirp(t, 10, t(end), 10000);

%% Create recording
rec1 = audiorecorder(48000,24,1);
% Målt V_rms ved 1 kHz: 
%P = V^2/R;

disp('Playing...');
sound(ch*0.95, fs);

disp('Recording...');
recordblocking(rec1, T);
disp('Recording done');

%% Get data
y = getaudiodata(rec1);

% Normalized frequency
Y = fft(y);

% To dB_SPL
Y = 20*log10(Y./20e-6);

save('TEST.mat', 'y');
%% Plot
f = (0:1:length(Y)-1)*fs/(fs*T);
figure
semilogx(f(1:end/2), abs(Y(1:end/2)))
hold on
grid on
xlabel('Frequency (Hz)');
ylabel('dB_{SPL}');