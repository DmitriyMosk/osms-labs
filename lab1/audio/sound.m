[y_orig, Fs] = audioread('voice.wav');
N = length(y_orig); % длина сигнала

fprintf('Частота дискретизации рассчётная: %.2f\n', length(y) / 6.609);
fprintf('Частота дискретизации фактическая: %.2f\n', Fs); 

y_10 = downsample(y_orig, 10);
Fs_10 = Fs / 10;

% Выполнение преобразования Фурье
discrete_samples_y_orig = fft(y_orig);
discrete_samples_y_10 = fft(y_10);

% Частотная ось для оригинального сигнала
f_orig = (0:N-1)*(Fs/N); 
amplitude_y_orig = abs(discrete_samples_y_orig)/N;

% Частотная ось для downsample сигнала
N_10 = length(y_10); % новая длина сигнала
f_10 = (0:N_10-1)*(Fs_10/N_10); 
amplitude_y_10 = abs(discrete_samples_y_10)/N_10;


figure;
    plot(f_orig, amplitude_y_orig, 'b', 'DisplayName', 'Оригинальный сигнал y(t)');
    hold on;
        plot(f_10, amplitude_y_10, 'r', 'DisplayName', 'Downsampled сигнал y_{10}(t)');
    hold off;

legend('show');
title('Сравнение спектров сигналов y(t) и y_{10}(t)');
xlabel('Частота (Гц)');
ylabel('Амплитуда');
xlim([0 max_f]);
