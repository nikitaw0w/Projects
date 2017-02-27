/**
 * 4.cpp -- Метод гаммирования данных.
 * Bazhenov Nikita (c) 2016
 */

#include <iostream>
#include <cstring>
#include <fstream>
#include <ctime>
#include <cmath>
#include <iomanip>
#include <stdlib.h>

using namespace std;

//Перемнные для задания времени
time_t start, end, m_start, m_end, g_start, g_end;
//Время (time_t)
time_t rawtime;
//Текущее время (число)
int cur_time;
//Счетчик длины генерируемой послед-ти
int count = 10000;
//Начальный элемент послед-ти, массив послед-ти
int c0, c[10000];
//Элементы формулы послед-ти
int a, b, n = 24, m = 2;
//Массив для дополнительной работы программы
int M[200][150];
//Длина распределения послед-ти
int distr_length = m / 100;
//Массив распределений для гистограммы
double distr[100] = {0};
//Процент для подсчета эл-тов
double per = 0;
//Поток для записи
ifstream fin("prev.txt");
ofstream fout("key.txt");
//Гаммирование
int g[10000] = {0}, g_length = 0, final[10000] = {0};
//Время гаммирования
double g_time = 0;

bool file_use = false;
/*
 * Сгенерировать послед-ть
 * @param count длина генерируемой послед-ти
 * @param start начало отсчета времени
 * @param end конец отсчета времени
 * @param M[][] массив для доп. работы
 * @param c[] массив послед-ти
 * @param a элемент расчета послед-ти
 * @param b элемент расчета послед-ти
 * @param m элемент расчета послед-ти
 * @param c0 начальный эл-т послед-ти
 */

void generate(int count)
{
    //Отсчет времени (глобальный)
    start = clock();

    //Отсчет времени (массив)
    m_start = clock();
    for (int i = 0; i < 200; i++)
        for (int j = 0; j < 150; j++)
            M[i][j] = M[j][i];
    //Конец отсчета
    m_end = clock();
    int m_search = m_end - m_start;
    m_search %= 200;

    end = clock();

    int search = end - start;
    search %= 200;

    //Запись сгенерированных значений с корректировкой под условия
    cur_time = time(&rawtime);
    c0 = search;
    a = m_search;
    b = (rawtime % 200);

    if (a % 4 == 0) a++;
    if (a % 4 == 2) a += 3;
    if (a % 4 == 3) a += 2;
    if (b % 2 == 0) b++;

    //Вычисление след. эл-та послед-ти
    for (int i = 0; i < count; i++)
    {
        if (i == 0) c[i] = (a * c0 + b) % m;
        else c[i] = (a * c[i - 1] + b) % m;
    }

    cout << "Последовательность сгенерирована! " << "(" << "c0: " << c0
         << " " << "a: " << a << " " << "b: " << b << ")" << endl;
}

void new_generate(int count)
{
    start = clock();
    for (int i = 0; i < 200; i++)
        for (int j = 0; j < 150; j++)
            M[i][j] = M[j][i];

    for (int i = 0; i < count; i++)
    {
        //start = clock();
        for (int k = 0; k < 100; k++)
            for (int j = 0; j < 100; j++)
                M[k][j] = M[j][k];
        end = clock();
        int search = end - start;
        //if ((i % 10) == 1) c[i] = 1;
        //else c[i] = (search % 2);
        c[i] = (search % 2);
    }

}

void gam()
{

t1:
    cout << "Введите длину послед-ти гаммирования:" << endl;
    cin >> g_length;
    if (g_length > 10000 || g_length > count)
    {
        cout << "Слишком длинная строка!" << endl;
        goto t1;
    }


    cout << "Введите элементы гаммирования:" << endl;
t2:
    for (int i = 0; i < g_length; i++)
    {
        cin >> g[i];
        if (g[i] != 0 && g[i] != 1)
        {
            cout << "Вводите только 0 или 1!" << endl;
            goto t2;
        }
    }

    cout << "Строка для гаммирования:" << endl;
    for (int i = 0; i < g_length; i++) cout << g[i] << " "; cout << endl;
    cout << "Первоначальная рандоманая строка:" << endl;
    for (int i = 0; i < g_length; i++) cout << c[i] << " "; cout << endl;

    g_start = clock();

    for (int i = 0; i < g_length; i++)
    {
        final[i] = g[i] ^ c[i];
    }

    g_end = clock();
    g_time = g_end - g_start;

    cout << "Получившаяся строка:" << endl;
    for (int i = 0; i < g_length; i++) cout << final[i] << " "; cout << endl;
    cout << "Время гаммирования:" << endl;
    cout << setprecision(10) << g_time/1000.0 << endl;
}

int main()
{
    int el = 0;
    bool flag = true;
    char action;
    while (flag)
    {
        cout << "Меню: " << endl;
        cout << "0. Сгенерировать новую последовательность" << endl;
        cout << "1. Сгенерировать последовательность" << endl;
        cout << "2. Вывести число последовательности" << endl;
        cout << "3. Вывести n-чисел последовательности" << endl;
        cout << "4. Вывести всю последовательность на экран" << endl;
        cout << "5. Записать последовательность в файл" << endl;
        cout << "6. Гаммирование" << endl;
        cout << "7. Время гаммирования" << endl;
        cout << "8. Выход" << endl;

        cin >> action;

        switch(action)
        {
        case '0':
            cout << "Введите длину генерируемой последовательности" << endl;
            cin >> count;
            if (count > 10000)
            {
                cout << "Невозоможно создать такую длинную последовательность!" << endl;
                break;
            }
            new_generate(count);
            break;
        case '1':
            cout << "Введите длину генерируемой последовательности" << endl;
            cin >> count;
            if (count > 10000)
            {
                cout << "Невозоможно создать такую длинную последовательность!" << endl;
                break;
            }
            generate(count);
            break;
        case '2':
            cout << "Какой элемент вывести?" << endl;
            cin >> el;
            if (el > count)
            {
                cout << "Невозоможно вывести несуществующий элемент!" << endl;
                break;
            }
            cout << "Элемент " << el << ": " << c[el - 1] << endl;
            break;
        case '3':
            cout << "Сколько чисел вывести?" << endl;
            cin >> el;
            if (el > count)
            {
                cout << "Невозоможно вывести чисел больше, чем в последовательности!" << endl;
                break;
            }
            for (int i = 0; i < el; i++) cout << c[i] << " "; cout << endl;
            break;
        case '4':
            for (int i = 0; i < count; i++) cout << c[i] << " "; cout << endl;
            break;
        case '5':
            cin >> el;
            if (el > count)
            {
                cout << "Значение не может превышать длины последовательности!" << endl;
                break;
            }
            for (int i = 0; i < el; i++) fout << c[i] << " ";
            break;
        case '6':
            gam();
            break;
        case '7':
            cout << setprecision(4) << "Время работы гаммирования: " << g_time << endl;
            break;
        case '8':
            exit(1);
            break;
        default:
            cout << "Введите номер пункта меню!" << endl;
            break;
        }
    }


    return 0;
}
