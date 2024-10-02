clear; 

% Расстояние в метрах (для всех моделей)
d = linspace(1, 5000, 5000); 

PL_FSPM = FSPM(d);
PL_UMiNLOS = UMiNLOS(d);

[PLOkomuraHata_DU, PLOkomuraHata_U] = OkomuraHata(d); 
PL_WalfishIkegamiLOS = WalfishIkegamiLOS(d); 
PL_WalfishIkegamiNLOS = WalfishIkegamiNLOS(d);

% Построение графика
figure;
    plot(d, PL_FSPM, 'b--', 'LineWidth', 2); 
    hold on;
    plot(d, PL_UMiNLOS, 'r-', 'LineWidth', 2);
    plot(d, PLOkomuraHata_DU, 'g-', 'LineWidth', 2);
    plot(d, PLOkomuraHata_U, 'c--', 'LineWidth', 2);
    plot(d, PL_WalfishIkegamiLOS, 'm-', 'LineWidth', 2);
    plot(d, PL_WalfishIkegamiNLOS, 'k-', 'LineWidth', 2);
    hold off;
    
    % Настройка графика
    xlabel('Расстояние d (м)', 'FontSize', 12);
    ylabel('Потери PL (дБ)', 'FontSize', 12);
    title('Сравнение моделей потери сигнала (1.8GHz)', 'FontSize', 14);
    legend({'FSPM', 'UMiNLOS', "Okomuro-Hata DU", "Okomuro-Hata U", "Walfish-Ikegami LOS", " Walfish-Ikegami NLOS"}, 'FontSize', 12);
    grid on;