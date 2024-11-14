#include <iostream>
#include <vector>
#include <bitset>
#include <ctime>
#include <cstdlib>

using namespace std;

const uint8_t POLYNOM = 0b10011011; // x^7 + x^5 + x^4 + x^3 + x + 1

class Packet {
public:
    Packet(const vector<uint8_t>& data) : data(data) {}

    void CRCWrite() {
        uint8_t crc = calculateCRC(data);
        for (int i = 7; i >= 0; --i) {
            data.push_back((crc >> i) & 1);
        }
        cout << "CRC added: " << bitset<8>(crc) << endl;
    }

    bool CRCValidate() const {
        return calculateCRC(data) == 0;
    }

    void toggleBit(size_t pos) {
        if (pos < data.size()) {
            data[pos] = !data[pos];
        }
    }

    void printData() const {
        for (const auto& bit : data) {
            cout << static_cast<int>(bit);
        }
        cout << endl;
    }

    static vector<uint8_t> generateData(size_t N) {
        vector<uint8_t> data(N);
        for (size_t i = 0; i < N; ++i) {
            data[i] = rand() % 2;
        }
        return data;
    }

private:
    vector<uint8_t> data;

    uint8_t calculateCRC(const vector<uint8_t>& inputData) const {
        uint32_t temp = 0;
        for (size_t i = 0; i < inputData.size(); ++i) {
            temp = (temp << 1) | inputData[i];
            if (temp & (1 << 7)) {
                temp ^= POLYNOM;
            }
        }
        return temp;
    }
};

int main() {
    srand(static_cast<unsigned int>(time(0)));

    vector<uint8_t> initialData = {1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0};

    Packet packet31(initialData);

    packet31.CRCWrite();
    packet31.CRCValidate(); 

    vector<uint8_t> randomData = Packet::generateData(250);
    Packet largePacket(randomData);

    largePacket.CRCWrite();

    int errorsDetected = 0, errorsMissed = 0;
    size_t totalBits = randomData.size() + 8;
    for (size_t i = 0; i < totalBits; ++i) {
        largePacket.toggleBit(i);
        if (!largePacket.CRCValidate()) {
            errorsDetected++;
        } else {
            errorsMissed++;
        }
        largePacket.toggleBit(i);
    }

    cout << "Errors count: " << errorsDetected << endl;
    cout << "No errors count: " << errorsMissed << endl;

    return 0;
}
