#include <iostream>
#include <vector>
#include <iomanip>

// Функция для вычисления следующего бита
int getNextValue(std::vector<int>& reg, const std::vector<int>& taps) {
    int new_bit = 0;
    for (int tap : taps) {
        new_bit ^= reg[tap - 1]; // taps use 1-based indexing
    }
    reg.pop_back();
    reg.insert(reg.begin(), new_bit);
    return reg.back();
}

// Генерация Голд-последовательности
std::vector<int> GENERATEGOLENSEQUENCE(std::vector<int> regX, std::vector<int> regY, int length = 31) {
    std::vector<int> goldSequence;
    for (int i = 0; i < length; ++i) {
        int bitX = getNextValue(regX, {5, 2});
        int bitY = getNextValue(regY, {5, 4, 3, 1});
        goldSequence.push_back(bitX ^ bitY);
    }
    return goldSequence;
}

// Циклический сдвиг последовательности
std::vector<int> REG_CYCLE_SHIFTING(const std::vector<int>& sequence, int shift) {
    int size = sequence.size();
    std::vector<int> shiftedSequence(size);
    for (int i = 0; i < size; ++i) {
        shiftedSequence[i] = sequence[(i + shift) % size];
    }
    return shiftedSequence;
}

// Функция для вычисления нормированной корреляции
double calculateNormalizedCorrelation(const std::vector<int>& seq1, const std::vector<int>& seq2) {
    int matches = 0;
    for (size_t i = 0; i < seq1.size(); ++i) {
        matches += (seq1[i] == seq2[i]) ? 1 : -1;
    }
    return static_cast<double>(matches) / seq1.size();
}

// Печать таблицы автокорреляции
void printAutocorrelationTable(const std::vector<int>& sequence) {
    std::cout << "Shift | Sequence | Autocorrelation" << std::endl;
    std::cout << "----------------------------------" << std::endl;

    for (int shift = 0; shift < sequence.size(); ++shift) {
        auto shiftedSeq = REG_CYCLE_SHIFTING(sequence, shift);
        double autocorr = calculateNormalizedCorrelation(sequence, shiftedSeq);
        
        std::cout << std::setw(5) << shift << " | ";
        for (int bit : shiftedSeq) {
            std::cout << bit << " ";
        }
        std::cout << "| " << std::fixed << std::setw(9) << std::setprecision(7) << autocorr << std::endl;
    }
}

int main() {
    // Начальная конфигурация регистров
    std::vector<int> regX = {0, 1, 0, 1, 1};
    std::vector<int> regY = {1, 0, 0, 1, 0};

    auto goldSequence = GENERATEGOLENSEQUENCE(regX, regY);

    std::cout << "Gold's original sequence:" << std::endl;
    for (int bit : goldSequence) {
        std::cout << bit << " ";
    }
    std::cout << std::endl << std::endl;

    std::cout << "Autocorrelation table:" << std::endl;
    printAutocorrelationTable(goldSequence);

    // Новая конфигурация регистров
    std::vector<int> newRegX = {0, 1, 1, 0, 0};
    std::vector<int> newRegY = {0, 1, 1, 0, 1};

    auto newGoldSequence = GENERATEGOLENSEQUENCE(newRegX, newRegY);

    std::cout << "\nNew Gold Sequence:" << std::endl;
    for (int bit : newGoldSequence) {
        std::cout << bit << " ";
    }
    std::cout << std::endl;

    // Вычисление взаимной корреляции
    double mutualCorrelation = calculateNormalizedCorrelation(goldSequence, newGoldSequence);

    std::cout << "\nCross-correlation between original and new sequences: " << mutualCorrelation << std::endl;

    return 0;
}
