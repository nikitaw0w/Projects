/**
 * 3.cpp -- Генерация псевдослучайных чисел.
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
time_t start, end, m_start, m_end;
//Время (time_t)
time_t rawtime;
//Текущее время (число)
int cur_time;
//Счетчик длины генерируемой послед-ти
int count = 10000;
//Начальный элемент послед-ти, массив послед-ти
int c0, c[10000];
//Элементы формулы послед-ти
int a, b, n = 24, m = pow(2, n);
//Массив для дополнительной работы программы
int M[200][150];
//Длина распределения послед-ти
int distr_length = m / 100;
//Массив распределений для гистограммы
double distr[100] = {0};
//Процент для подсчета эл-тов
double per = 0;
//Поток для записи
ofstream fout("output.txt");

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

/*
 * Показать гистограмму
 * @param c[] массив послед-ти
 * @param distr[] массив распределения
 * @param distr_length длина рпспределения
 * @param per процент подсчета эл-тов
 */

void show_chart()
{
    //Обнуление распределения
    for (int i = 0; i < 100; i++) distr[i] = 0;
    //Запись в массив, исходя из равномерного разбития на 100 эл-тов
    for (int i = 0; i < 100; i++)
    {
        for (int j = 0; j < count; j++)
        {
            if ((c[j] > i * distr_length) && (c[j] < (i + 1) * distr_length)) distr[i]++;
        }
    }

    //Вывод гистограммы
    for (int i = 0; i < 100; i++)
    {
        cout << i + 1 << ": ";
        for (int j = 0; j < distr[i]; j++) cout << "*";
        cout << " ";
        per = (distr[i] / count);
        cout << setprecision(4) << per;
        cout << "(" << distr[i] << ")" << endl;
    }
}

/*
 * Получить информацию
 * @param count длина генерируемой послед-ти
 * @param n эл-т формулы послед-ти
 * @param c[] массив послед-ти
 * @param a элемент расчета послед-ти
 * @param b элемент расчета послед-ти
 * @param m элемент расчета послед-ти
 * @param c0 начальный эл-т послед-ти
 */

void get_info()
{
    cout << "Длина сгенерированных чисел: " << count << endl;
    cout << "Начальный элемент c0: " << c0 << endl;
    cout << "a: " << a << endl;
    cout << "b: " << b << endl;
    cout << "n: " << n << endl;
    cout << "m (2^n): " << m << endl;
    cout << "Длина последовательности: " << distr_length << endl;
}

int main()
{
    generate(count);

    int el = 0;
    bool flag = true;
    char action;
    while (flag)
    {
        cout << "Меню: " << endl;
        cout << "1. Сгенерировать последовательность" << endl;
        cout << "2. Вывести число последовательности" << endl;
        cout << "3. Вывести n-чисел последовательности" << endl;
        cout << "4. Вывести всю последовательность на экран" << endl;
        cout << "5. Записать последовательность в файл" << endl;
        cout << "6. Вывести гистограмму на экран" << endl;
        cout << "7. Получить информацию о данных" << endl;
        cout << "8. Выход" << endl;

        cin >> action;

        switch(action)
        {
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
            cout << "Сколько записать в файл?" << endl;
            cin >> el;
            if (el > count)
            {
                cout << "Невозоможно записать чисел больше, чем в последовательности!" << endl;
                break;
            }
            for (int i = 0; i < el; i++) fout << c[i] << " ";
            break;
        case '6':
            show_chart();
            break;
        case '7':
            get_info();
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
