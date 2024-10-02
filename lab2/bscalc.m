clear; 

DL = MAPL_DL(); 
UL = MAPL_UL();

fprintf("Пороговое значение DownLink: %.2f\n", DL); 
fprintf("Пороговое значение UpLink: %.2f\n", UL);

MAX_LEVEL = min(DL, UL); 
MAX_LEVEL_2 = max(DL, UL); 

DISTANCE_KM = linspace(0.01, 100, 1000); % диапазон от 0.01 до 100 в km 

[PL_DU, PL_U] = OkomuraHata(DISTANCE_KM * 1e3);
PL_UMLS = UMiNLOS(DISTANCE_KM * 1e3); 


[Hata_DU_1x, Hata_DU_1y] = findIntersection(PL_DU, MAX_LEVEL, DISTANCE_KM);
[Hata_U_1x, Hata_U_1y] = findIntersection(PL_U, MAX_LEVEL, DISTANCE_KM);
[PL_UMLS_1x, PL_UMLS_1y] = findIntersection(PL_UMLS, MAX_LEVEL, DISTANCE_KM);

[Hata_DU_2x, Hata_DU_2y] = findIntersection(PL_DU, MAX_LEVEL_2, DISTANCE_KM);
[Hata_U_2x, Hata_U_2y] = findIntersection(PL_U, MAX_LEVEL_2, DISTANCE_KM);
[PL_UMLS_2x, PL_UMLS_2y] = findIntersection(PL_UMLS, MAX_LEVEL_2, DISTANCE_KM);


figure;
    hold on;
    
    plot(DISTANCE_KM, DL * ones(size(DISTANCE_KM)), 'y--', 'LineWidth', 1); % линия для DL
    plot(DISTANCE_KM, UL * ones(size(DISTANCE_KM)), 'g--', 'LineWidth', 1); % линия для UL
    
    plot(DISTANCE_KM, PL_U, 'g-', 'LineWidth', 1.5);
    %plot(DISTANCE_KM, PL_UMLS, 'm-', 'LineWidth', 1.5);

    xline(Hata_U_1x, 'k:', 'LineWidth', 1.5); % вертикальная линия для PL_U
    xline(Hata_U_2x, 'k:', 'LineWidth', 1.5); % вертикальная линия для PL_U

    %xline(PL_UMLS_1x, 'c:', 'LineWidth', 1.5); % вертикальная линия для PL_UMLS
    
    % Подписываем значения на вертикальных линиях
    text(Hata_U_1x, Hata_U_1y, sprintf('%.2f km', Hata_U_1x), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', 'black', 'FontSize', 10);
    text(Hata_U_2x, Hata_U_2y, sprintf('%.2f km', Hata_U_2x), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', 'black', 'FontSize', 10);
    %text(PL_UMLS_1x, PL_UMLS_1y, sprintf('%.2f km', PL_UMLS_1x), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', 'black', 'FontSize', 10);

    xlabel('Расстояние, км L_{clutter} = 0');
    ylabel('Потеря сигнала, dB'); 
    title('Зависимость потерь радиосигнала от расстояния (Hata, UMiNLOS)'); 
    grid on;
    legend('DL', 'UL', "Hata (Macrocells)"); 
    
    hold off;

area = 100; 

rBS_1 = min(Hata_U_1x, Hata_U_2x);
fprintf("Радиус базовой станции для 100кв.км: %.2f\n", rBS_1);
sBS_1 = 1.95*(rBS_1^2); 
fprintf("Площадь базовой станции кв.км: %.2f\n", sBS_1);
fprintf("Требуемое количество для покрытия: %d\n", ceil(area/sBS_1));

figure;
    hold on;
    
    plot(DISTANCE_KM, DL * ones(size(DISTANCE_KM)), 'y--', 'LineWidth', 1); % линия для DL
    plot(DISTANCE_KM, UL * ones(size(DISTANCE_KM)), 'g--', 'LineWidth', 1); % линия для UL
    
    plot(DISTANCE_KM, PL_UMLS, 'm-', 'LineWidth', 1.5);

    xline(PL_UMLS_1x, 'k:', 'LineWidth', 1.5); % вертикальная линия для PL_U
    xline(PL_UMLS_2x, 'k:', 'LineWidth', 1.5); % вертикальная линия для PL_U

    %xline(PL_UMLS_1x, 'c:', 'LineWidth', 1.5); % вертикальная линия для PL_UMLS
    
    % Подписываем значения на вертикальных линиях
    text(PL_UMLS_1x, PL_UMLS_1y, sprintf('%.2f km', PL_UMLS_1x), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', 'black', 'FontSize', 10);
    text(PL_UMLS_2x, PL_UMLS_2y, sprintf('%.2f km', PL_UMLS_2x), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'Color', 'black', 'FontSize', 10);

    xlabel('Расстояние, км');
    ylabel('Потеря сигнала, dB'); 
    title('Зависимость потерь радиосигнала от расстояния (UMiNLOS)'); 
    grid on;
    legend('DL', 'UL', "UMiNLOS (Femto- Micro- Cells)"); 
    
    hold off;

area = 4; 

rBS_1 = min(PL_UMLS_1x, PL_UMLS_2x);
fprintf("Радиус базовой станции для 4кв.км: %.2f\n", rBS_1);
sBS_1 = 1.95*(rBS_1^2); 
fprintf("Площадь базовой станции кв.км: %.2f\n", sBS_1);
fprintf("Требуемое количество для покрытия: %d\n", ceil(area/sBS_1));

function [x, y] = findIntersection(values, dot, ln)
    interX = find(values <= dot, 1, 'last');

    x = ln(interX);
    y = values(interX);
end 