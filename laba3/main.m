f1 = 11;
f2 = 15;
f3 = 23;

t = 0:0.01:1;

s1 = cos(2*pi*f1*t);
s2 = cos(2*pi*f2*t);
s3 = cos(2*pi*f3*t);

a = 2*s1 + 4*s2 + s3;
b = s1 + s2 + s3;

figure;
subplot(2,1,1);
plot(t, a);
title('Сигнал a(t)');
subplot(2,1,2);
plot(t, b);
title('Сигнал b(t)');

corr_ab = sum(a .* b);
norm_corr_ab = sum(a .* b) / (sqrt(sum(a.^2)) * sqrt(sum(b.^2)));

disp(['Корреляция между сигналами a(t) и b(t): ', num2str(corr_ab)]);
disp(['Нормализованная корреляция между сигналами a(t) и b(t): ', num2str(norm_corr_ab)]);

t = 0:0.01:1;

a = [0.3 0.2 -0.1 4.2 -2 1.5 0];
b = [0.3 4 -2.2 1.6 0.1 0.1 0.2];

figure;
subplot(2,1,1);
stem(a, '-o');
title('Array a');

subplot(2,1,2);
stem(b, '-o');
title('Array b');

corr_ab = xcorr(a, b);

figure;
plot(corr_ab);
title('Взаимная корреляция a и b');

n = length(a);
corr_vals = zeros(1, n);

for i = 0:n-1
    b_shifted = circshift(b, i);
    
    corr_vals(i+1) = sum(a .* b_shifted);
end

figure;
plot(0:n-1, corr_vals, '-o');
title('Зависимость корреляции от величины сдвига');
xlabel('Сдвиг');
ylabel('Корреляция');

[max_corr, max_shift] = max(corr_vals);

disp(['Максимальная корреляция: ', num2str(max_corr)]);
disp(['Сдвиг, при котором достигается максимальная корреляция: ', num2str(max_shift-1)]);

b_best_shift = circshift(b, max_shift-1);

figure;
subplot(2,1,1);
plot(a, '-o');
title('Сигнал a');

subplot(2,1,2);
plot(b_best_shift, '-o');
title('Сигнал b, сдвинутый на величину максимальной корреляции');

