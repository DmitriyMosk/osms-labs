#include <stdio.h>
#include <math.h>

// Функция для обычной корреляции
double correlation(int x[], int y[], int N) {
    double result = 0;
    for (int i = 0; i < N; i++) {
        result += x[i] * y[i];
    }
    return result;
}

// Функция для нормализованной корреляции
double normalized_correlation(int x[], int y[], int N) {
    double numerator = 0, sum_x_sq = 0, sum_y_sq = 0;
    
    for (int i = 0; i < N; i++) {
        numerator += x[i] * y[i];
        sum_x_sq += x[i] * x[i];
        sum_y_sq += y[i] * y[i];
    }
    
    return numerator / (sqrt(sum_x_sq) * sqrt(sum_y_sq));
}

int main() {
    int a[] = {7, 2, 8, 12, -4, -4, 1, 3};
    int b[] = {3, 6, 7, 10, -5, -2, 2, 5};
    int c[] = {-5, -1, 3, -9, 2, 3, 4, -4};
    int N = 8;

    printf("Корреляция a и b: %.2f\n", correlation(a, b, N));
    printf("Корреляция a и c: %.2f\n", correlation(a, c, N));
    printf("Корреляция b и c: %.2f\n", correlation(b, c, N));

    printf("Нормализованная корреляция a и b: %.2f\n", normalized_correlation(a, b, N));
    printf("Нормализованная корреляция a и c: %.2f\n", normalized_correlation(a, c, N));
    printf("Нормализованная корреляция b и c: %.2f\n", normalized_correlation(b, c, N));

    return 0;
}
