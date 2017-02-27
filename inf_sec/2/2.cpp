/**
 * 2.cpp -- Защитное кодирование по методу Хэмминга.
 * Bazhenov Nikita (c) 2016
 */

#include <iostream>
#include <cstring>
#include <cmath>
#include <stdlib.h>

using namespace std;

//Вводимая последовательность
char s[12] = {'0'};
//Закодированная последовательность
char c[17] = {'0'};
//k-ая строка матрицы при кодировании
char a1[17] = {'1', '0', '1', '0', '1', '0', '1', '0',
               '1', '0', '1', '0', '1', '0', '1', '0',
               '1'};
char a2[17] = {'0', '1', '1', '0', '0', '1', '1', '0',
               '0', '1', '1', '0', '0', '1', '1', '0',
               '0'};
char a3[17] = {'0', '0', '0', '1', '1', '1', '1', '0',
               '0', '0', '0', '1', '1', '1', '1', '0',
               '0'};
char a4[17] = {'0', '0', '0', '0', '0', '0', '0', '1',
               '1', '1', '1', '1', '1', '1', '1', '0',
               '0'};
char a5[17] = {'0', '0', '0', '0', '0', '0', '0', '0',
               '0', '0', '0', '0', '0', '0', '0', '1',
               '1'};
//Массив логических выражений для инвертирования
bool inv[5] = {false};
//Запоминание кол-ва единиц в массиве (неконтрольные биты)
int count[5] = {0};
//Элемент массива (12)
int k = 0;
//Передаваемая последовательность
char n[17] = {'0'};
//Запоминание кол-ва единиц в новом масиве (n)
int ncount[5] = {0};
//Массив логических выражений (n)
int ninv[5] = {false};
//Количество расхождений
int mismatches = 0;
//Исправленная последовательность (начальная)
char nfixed[12] = {'0'};

/* Ввод начальной последовательности
 *
 */

void enter_first()
{
    //Обнуление значений
    for (int i = 0; i < 5; i++) count[i] = 0;
    for (int i = 0; i < 5; i++) inv[i] = false;
    for (int i = 0; i < 12; i++) s[i] = '0';
    for (int i = 0; i < 17; i++) c[i] = '0';
    k = 0;

m1:
    cout << "Вводите последовательность:" << endl;
    for (int i = 0; i < 12; i++)
    {
        cin >> s[i];
        //Если элемент не равен 0 или 1, вернуться к шагу m1
        if (s[i] != '0' && s[i] != '1') goto m1;
    }

    cout << "Начальная последовательность:" << endl;
    for (int i = 0; i < 12; i++) cout << s[i] << " ";
    cout << endl;

    cout << "k-ые строки матрицы (a1, a2, a3, a4, a5):" << endl;
    for (int i = 0; i < 17; i++) cout << a1[i] << " "; cout << endl;
    for (int i = 0; i < 17; i++) cout << a2[i] << " "; cout << endl;
    for (int i = 0; i < 17; i++) cout << a3[i] << " "; cout << endl;
    for (int i = 0; i < 17; i++) cout << a4[i] << " "; cout << endl;
    for (int i = 0; i < 17; i++) cout << a5[i] << " "; cout << endl;

    cout << "Вектор шифрования" << endl;
    for (int i = 0; i < 5; i++) cout << inv[i] << " "; cout << endl;

    //Незакодированная послед-ть с контрольными битами
    for (int i = 0; i < 17; i++)
    {
        if (i == 0 || i == 1 || i == 3 || i == 7 || i == 15) c[i] = '0';
        else
        {
            c[i] = s[k];
            k++;
        }
    }

    //Вычисление на возможную замену контрольных битов
    for (int i = 0; i < 17; i++)
    {
        //Если контрольные биты
        if (i != 0 && i != 1 && i != 3 && i != 7 && i != 15)
        {
            //Если нужно менять (n через N), и если эл-т равен 1
            if (a1[i] == '1' && c[i] == '1') count[0]++;
            if (a2[i] == '1' && c[i] == '1') count[1]++;
            if (a3[i] == '1' && c[i] == '1') count[2]++;
            if (a4[i] == '1' && c[i] == '1') count[3]++;
            if (a5[i] == '1' && c[i] == '1') count[4]++;
        }
    }

    //Установка необходимых флагов и замена контрольных битов
    for (int i = 0; i < 5; i++) if ((count[i] % 2) == 1) inv[i] = true;
    if (inv[0] == true) c[0] = '1';
    if (inv[1] == true) c[1] = '1';
    if (inv[2] == true) c[3] = '1';
    if (inv[3] == true) c[7] = '1';
    if (inv[4] == true) c[15] = '1';

    cout << "Закодированная последовательность:" << endl;
    for (int i = 0; i < 17; i++) cout << c[i] << " "; cout << endl;

    //Контрольные биты подсвечены *
    for (int i = 0; i < 17; i++)
    {
        if (i == 0 || i == 1 || i == 3 || i == 7 || i == 15) cout << "*" << " ";
        else cout << "  ";
    }
    cout << endl;
}

/* Ввод передаваемой последовательности
 *
 */

void enter_new()
{
    //Обнуление значений
    for (int i = 0; i < 5; i++) ncount[i] = 0;
    for (int i = 0; i < 5; i++) ninv[i] = false;
    for (int i = 0; i < 17; i++) n[i] = '0';
    for (int i = 0; i < 12; i++) nfixed[i] = '0';
    mismatches = 0;
    k = 0;
    //Предел
    int lim = 0;

m2:
    //Ввод передаваемой послед-ти
    lim = 0;
    for (int i = 0; i < 17; i++)
    {
        cin >> n[i];
        if (n[i] != '0' && n[i] != '1')
        {
            cout << "Вводите значения 0 или 1!" << endl;
            goto m2;
        }
        if (i == 0 || i == 1 || i == 3 || i == 7 || i == 15)
            if (c[i] != n[i])
            {
                cout << "Ключевые биты должны совпадать!" << endl;
                goto m2;
            }
        if (c[i] != n[i])
        {
            lim++;
            if (lim > 1)
            {
                cout << "В последовательности не может быть больше 1 ошибки!" << endl;
                goto m2;
            }
        }
    }

    cout << "Передаваемая последовательность:" << endl;
    for (int i = 0; i < 17; i++) cout << n[i] << " "; cout << endl;
    for (int i = 0; i < 17; i++)
    {
        if (i == 0 || i == 1 || i == 3 || i == 7 || i == 15) cout << "*" << " ";
        else cout << "  ";
    }
    cout << endl;

    //Подсчет единиц с целью последующей замены
    for (int i = 0; i < 17; i++)
    {
        if (a1[i] == '1' && n[i] == '1') ncount[0]++;
        if (a2[i] == '1' && n[i] == '1') ncount[1]++;
        if (a3[i] == '1' && n[i] == '1') ncount[2]++;
        if (a4[i] == '1' && n[i] == '1') ncount[3]++;
        if (a5[i] == '1' && n[i] == '1') ncount[4]++;
    }

    //Перевычисление значений контрольных битов
    for (int i = 0; i < 5; i++) if ((ncount[i] % 2) == 1) ninv[i] = true;
    if (ninv[0] == true) if (n[0] == '0') n[0] = '1'; else n[0] = '0';
    if (ninv[1] == true) if (n[1] == '0') n[1] = '1'; else n[1] = '0';
    if (ninv[2] == true) if (n[3] == '0') n[3] = '1'; else n[3] = '0';
    if (ninv[3] == true) if (n[7] == '0') n[7] = '1'; else n[7] = '0';
    if (ninv[4] == true) if (n[15] == '0') n[15] = '1'; else n[15] = '0';

    cout << "Замена контрольных битов под номерами " << endl;
    for (int i = 0; i < 5; i++) if (!false) cout << ninv[i] << " "; cout << endl;
    cout << "Получившаяся послед-ть с заменой контрольных битов" << endl;
    for (int i = 0; i < 17; i++) cout << n[i] << " "; cout << endl;

    //Вычисление индекса несовпадения
    for (int i = 0; i < 17; i++)
    {
        if (i == 0 || i == 1 || i == 3 || i == 7 || i == 15)
        {
            if (n[i] != c[i]) mismatches += (i + 1);
        }
    }
    k = 0;

    for (int i = 0; i < 17; i++)
    {
        if (i != 0 && i != 1 && i != 3 && i != 7 && i != 15)
        {
            nfixed[k] = n[i];
            k++;
        }
    }
    if (mismatches)
    {
        cout << "Несовпадение: " << mismatches << endl;
        cout << "Неисправленная полученная послед-ть без контр. битов:" << endl;
        for (int i = 0; i < 12; i++) cout << nfixed[i] << " "; cout << endl;

        //Корректирование послед-ти без контр. битов
        if (mismatches > 2 && mismatches < 4) mismatches -= 2;
        if (mismatches > 4 && mismatches < 8) mismatches -= 3;
        if (mismatches > 8 && mismatches < 16) mismatches -= 4;
        if (mismatches > 16) mismatches -= 5;

        if (mismatches != 0)
        {
            if (nfixed[mismatches - 1] == '1') nfixed[mismatches - 1] = '0';
            else nfixed[mismatches - 1] = '1';
        }
    }
    cout << "Исправленная последовательность:" << endl;
    for (int i = 0; i < 12; i++) cout << nfixed[i] << " "; cout << endl;
}


int main()
{
    bool flag = true;
    char action;
    while (flag)
    {
        cout << "Меню: " << endl;
        cout << "1. Ввести начальную последовательность" << endl;
        cout << "2. Ввести передаваемую последовательность" << endl;
        cout << "3. Выход" << endl;

        cin >> action;

        switch(action)
        {
        case '1':
            enter_first();
            break;
        case '2':
            enter_new();
            break;
        case '3':
            exit(1);
            break;
        default:
            cout << "Введите номер пункта меню!" << endl;
            break;
        }
    }

    return 0;
}
