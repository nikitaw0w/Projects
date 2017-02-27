/**
 * 1.cpp -- Метод рассечения-разнесения данных.
 * Bazhenov Nikita (c) 2016
 */

#include <iostream>
#include <fstream>
#include <stdlib.h>
#include <cstring>
#include <iterator>
#include <sstream>

using namespace std;

//Строка для чтения из файла
string line;
//Количество столбцов, строк (3 по условию), длина строки
int col = 3, row = 3, len = 0;
//Количество строк и столбцов в полученной таблице
int x = 0, y = 0;
//Переменная для оставшихся неполных строк (столбцов)
int fold = 0;
//Двумерный массив для заполнения таблицы
char A[1000][1000];
//Текущий элемент
int cur = 0;
//Массив ключей столбцов
int ckey[3] = {2, 1, 3};
//Массив ключей строк
int rkey[3] = {3, 1, 2};
//Массив финального ключа, рассчитаного по формуле K = n(ri-1)+sj (по условию)
int final_key[9];
//Двумерный массив зашифрованных блоков
char block[9][1000];
//Значение текущего ключа
int cur_key = 0;
//Значение текущего столбца
int cur_col = 0;
//Количество символов в тексте
int total = 0;

/*
 * Получить информацию
 * @param len длина строки
 * @param line строка для чтения файла
 */

void get_information()
{
    len = line.size();
    cout << "Текст:\n" << line << endl;
    cout << "Длина текста:\n" << len << endl;
    cout << "Таблица с текстом:\n";
    for (int i = 0; i < x; i++)
    {
        for (int j = 0; j < y; j++)
        {
            cout << A[i][j];
        }
        cout << endl;
    }
    cout << "Текущий финальный ключ:" << endl;
    for (int i = 0; i < 9; i++) cout << final_key[i] + 1;
    cout << endl;
}

/*
 * Получить финальную строку
 * @param cur текущий элемент
 * @param row кол-во строк
 * @param col кол-во столбцов
 * @param rkey массив ключей строк
 * @param ckey массив ключей столбцов
 * @param final_key массив финального ключа
 * @param ri ключ строки
 * @param sj ключ столбца
 */

void get_final()
{
    cur = 0;
    for (int i = 0; i < row; i++)
    {
        int ri = rkey[i];
        for (int j = 0; j < col; j++)
        {
            int sj = ckey[j];
            final_key[cur] = (((col*ri) - col) + sj);
            cur++;
        }
    }
    for (int i = 0; i < 9; i++) final_key[i]--;
}

/*
 * Ввести ключи
 * @param rkey массив ключей строк
 * @param ckey массив ключей столбцов
 * @param final_key массив финального ключа
 * @param en текущий массив строки (столбца), введенного с клавиатуры
 */

void enter_keys()
{
    int en[3];
    cout << "Введите ключ по столбцам (1, 2, 3 без повторений в любом порядке):" << endl;
    cin >> en[0]; if (en[0] != 1 && en[0] != 2 && en[0] != 3) { cout << "Вводите правильные значения!" << endl; return; }
    cin >> en[1]; if (en[1] != 1 && en[1] != 2 && en[1] != 3) { cout << "Вводите правильные значения!" << endl; return; }
    cin >> en[2]; if (en[2] != 1 && en[2] != 2 && en[2] != 3) { cout << "Вводите правильные значения!" << endl; return; }
    if (en[0] == en[1] || en[0] == en[2] || en[1] == en[2]) { cout << "Значения не могут повторяться!" << endl; return; }
    for (int i = 0; i < 3; i++) ckey[i] = en[i];

    cout << "Введите ключ по строкам (1, 2, 3 без повторений в любом порядке):" << endl;
    cin >> en[0]; if (en[0] != 1 && en[0] != 2 && en[0] != 3) { cout << "Вводите правильные значения!" << endl; return; }
    cin >> en[1]; if (en[1] != 1 && en[1] != 2 && en[1] != 3) { cout << "Вводите правильные значения!" << endl; return; }
    cin >> en[2]; if (en[2] != 1 && en[2] != 2 && en[2] != 3) { cout << "Вводите правильные значения!" << endl; return; }
    if (en[0] == en[1] || en[0] == en[2] || en[1] == en[2]) { cout << "Значения не могут повторяться!" << endl; return; }

    for (int i = 0; i < 3; i++) rkey[i] = en[i];
    get_final();
    cout << "Финальная строка:" << endl;
    for (int i = 0; i < 9; i++) cout << final_key[i] + 1;
    cout << endl;
}

/*
 * Зашифровать текст
 * @param total кол-во символов в тексте
 * @param cur текущий элемент
 * @param cur_col значение текущего столбца
 * @param cur_key значение ткущего ключа
 * @param len длина строки
 * @param row кол-во строк
 * @param col кол-во столбцов
 * @block двумерный массив зашифрованных блоков
 * @param final_key массив финального ключа
 */

void encrypt()
{
    total = 0;
    cur_col = 0;
    cur_key = 0;
    for (int i = 0; i < x; i++)
    {
        for (int j = 0; j < y; j++)
        {
            if (total == len) break;
            int p = final_key[cur_key];

            block[p][cur_col] = A[i][j];

            cur_key++;
            total++;
            if (cur_key > 8) { cur_key = 0; cur_col++; }
        }
    }

    if (!cur_col) cur_col++;
    cout << "Зашифрованный текст:" << endl;
    for (int i = 0; i < (row*col); i++)
    {
        for (int j = 0; j < cur_col; j++)
        {
            cout << block[i][j] << " ";
        }
        cout << endl;
    }
}

/*
 * Расшифровать текст
 * @param line строка для чтения из файла
 * @param total кол-во символов в тексте
 * @param cur текущий элемент
 * @param cur_col значение текущего столбца
 * @param cur_key значение ткущего ключа
 * @param len длина строки
 * @block двумерный массив зашифрованных блоков
 * @param final_key массив финального ключа
 * @param decr расшифрованная строка
 */

void decrypt()
{
    len = line.size();
    total = 0;
    cur = 0;
    char decr[len];
    for (int i = 0; i < cur_col; i++)
    {
        for (int j = 0; j < 9; j++)
        {
            if (total == len) break;
            decr[cur] = block[final_key[j]][i];
            cur++;
            total++;
        }
    }
    cout << "Расшифрованный текст:\n" << decr << endl;
    cout << "Символов: " << total << endl;
}

int main()
{
    //Открытие файла с исходным текстом
    ifstream fin("input.txt");

    if (!fin.is_open()) cout << "Файл не может быть открыт." << endl;
    //Копируем считываемый текст в строку line с пробелами и переходом на новую строку
    else line.assign((istreambuf_iterator<char>(fin.rdbuf())), istreambuf_iterator<char>());

    fin.close();

    //Вычисляем длину строки
    len = line.size();
    //Определяем кол-во полных строк
    x = len / row;
    //Кол-во столбцов всегда равно 3
    y = col;

    //Если остались лишние символы (не заполнен весь столбик, увеличиваем счетчик)
    fold = len % row;
    if (fold) x++;

    //Считываем строку в двумерный массив, получая таблицу
    for (int i = 0; i < x; i++)
    {
        for (int j = 0; j < y; j++)
        {
            A[i][j] = line[cur];
            cur++;
        }
    }

    cur = 0;
    get_final();

    bool flag = true;
    char action;
    while (flag)
    {
        cout << "Меню: " << endl;
        cout << "1. Узнать информацию о тексте" << endl;
        cout << "2. Ввести ключи шифровки" << endl;
        cout << "3. Зашифровать текст" << endl;
        cout << "4. Восстановить текст" << endl;
        cout << "5. Выйти" << endl;

        cin >> action;

        switch(action)
        {
        case '1':
            get_information();
            break;
        case '2':
            enter_keys();
            break;
        case '3':
            encrypt();
            break;
        case '4':
            decrypt();
            break;
        case '5':
            exit(1);
            break;
        default:
            cout << "Введите номер пункта меню!" << endl;
            break;
        }
    }

    return 0;
}
