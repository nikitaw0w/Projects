/**
 * 3.cpp -- ��������� ��������������� �����.
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

//��������� ��� ������� �������
time_t start, end, m_start, m_end;
//����� (time_t)
time_t rawtime;
//������� ����� (�����)
int cur_time;
//������� ����� ������������ ������-��
int count = 10000;
//��������� ������� ������-��, ������ ������-��
int c0, c[10000];
//�������� ������� ������-��
int a, b, n = 24, m = pow(2, n);
//������ ��� �������������� ������ ���������
int M[200][150];
//����� ������������� ������-��
int distr_length = m / 100;
//������ ������������� ��� �����������
double distr[100] = {0};
//������� ��� �������� ��-���
double per = 0;
//����� ��� ������
ofstream fout("output.txt");

/*
 * ������������� ������-��
 * @param count ����� ������������ ������-��
 * @param start ������ ������� �������
 * @param end ����� ������� �������
 * @param M[][] ������ ��� ���. ������
 * @param c[] ������ ������-��
 * @param a ������� ������� ������-��
 * @param b ������� ������� ������-��
 * @param m ������� ������� ������-��
 * @param c0 ��������� ��-� ������-��
 */

void generate(int count)
{
    //������ ������� (����������)
    start = clock();

    //������ ������� (������)
    m_start = clock();
    for (int i = 0; i < 200; i++)
        for (int j = 0; j < 150; j++)
            M[i][j] = M[j][i];
    //����� �������
    m_end = clock();
    int m_search = m_end - m_start;
    m_search %= 200;

    end = clock();

    int search = end - start;
    search %= 200;

    //������ ��������������� �������� � �������������� ��� �������
    cur_time = time(&rawtime);
    c0 = search;
    a = m_search;
    b = (rawtime % 200);

    if (a % 4 == 0) a++;
    if (a % 4 == 2) a += 3;
    if (a % 4 == 3) a += 2;
    if (b % 2 == 0) b++;

    //���������� ����. ��-�� ������-��
    for (int i = 0; i < count; i++)
    {
        if (i == 0) c[i] = (a * c0 + b) % m;
        else c[i] = (a * c[i - 1] + b) % m;
    }

    cout << "������������������ �������������! " << "(" << "c0: " << c0
         << " " << "a: " << a << " " << "b: " << b << ")" << endl;
}

/*
 * �������� �����������
 * @param c[] ������ ������-��
 * @param distr[] ������ �������������
 * @param distr_length ����� �������������
 * @param per ������� �������� ��-���
 */

void show_chart()
{
    //��������� �������������
    for (int i = 0; i < 100; i++) distr[i] = 0;
    //������ � ������, ������ �� ������������ �������� �� 100 ��-���
    for (int i = 0; i < 100; i++)
    {
        for (int j = 0; j < count; j++)
        {
            if ((c[j] > i * distr_length) && (c[j] < (i + 1) * distr_length)) distr[i]++;
        }
    }

    //����� �����������
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
 * �������� ����������
 * @param count ����� ������������ ������-��
 * @param n ��-� ������� ������-��
 * @param c[] ������ ������-��
 * @param a ������� ������� ������-��
 * @param b ������� ������� ������-��
 * @param m ������� ������� ������-��
 * @param c0 ��������� ��-� ������-��
 */

void get_info()
{
    cout << "����� ��������������� �����: " << count << endl;
    cout << "��������� ������� c0: " << c0 << endl;
    cout << "a: " << a << endl;
    cout << "b: " << b << endl;
    cout << "n: " << n << endl;
    cout << "m (2^n): " << m << endl;
    cout << "����� ������������������: " << distr_length << endl;
}

int main()
{
    generate(count);

    int el = 0;
    bool flag = true;
    char action;
    while (flag)
    {
        cout << "����: " << endl;
        cout << "1. ������������� ������������������" << endl;
        cout << "2. ������� ����� ������������������" << endl;
        cout << "3. ������� n-����� ������������������" << endl;
        cout << "4. ������� ��� ������������������ �� �����" << endl;
        cout << "5. �������� ������������������ � ����" << endl;
        cout << "6. ������� ����������� �� �����" << endl;
        cout << "7. �������� ���������� � ������" << endl;
        cout << "8. �����" << endl;

        cin >> action;

        switch(action)
        {
        case '1':
            cout << "������� ����� ������������ ������������������" << endl;
            cin >> count;
            if (count > 10000)
            {
                cout << "����������� ������� ����� ������� ������������������!" << endl;
                break;
            }
            generate(count);
            break;
        case '2':
            cout << "����� ������� �������?" << endl;
            cin >> el;
            if (el > count)
            {
                cout << "����������� ������� �������������� �������!" << endl;
                break;
            }
            cout << "������� " << el << ": " << c[el - 1] << endl;
            break;
        case '3':
            cout << "������� ����� �������?" << endl;
            cin >> el;
            if (el > count)
            {
                cout << "����������� ������� ����� ������, ��� � ������������������!" << endl;
                break;
            }
            for (int i = 0; i < el; i++) cout << c[i] << " "; cout << endl;
            break;
        case '4':
            for (int i = 0; i < count; i++) cout << c[i] << " "; cout << endl;
            break;
        case '5':
            cout << "������� �������� � ����?" << endl;
            cin >> el;
            if (el > count)
            {
                cout << "����������� �������� ����� ������, ��� � ������������������!" << endl;
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
            cout << "������� ����� ������ ����!" << endl;
            break;
        }
    }

    return 0;
}
