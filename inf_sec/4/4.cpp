/**
 * 4.cpp -- ����� ������������ ������.
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
time_t start, end, m_start, m_end, g_start, g_end;
//����� (time_t)
time_t rawtime;
//������� ����� (�����)
int cur_time;
//������� ����� ������������ ������-��
int count = 10000;
//��������� ������� ������-��, ������ ������-��
int c0, c[10000];
//�������� ������� ������-��
int a, b, n = 24, m = 2;
//������ ��� �������������� ������ ���������
int M[200][150];
//����� ������������� ������-��
int distr_length = m / 100;
//������ ������������� ��� �����������
double distr[100] = {0};
//������� ��� �������� ��-���
double per = 0;
//����� ��� ������
ifstream fin("prev.txt");
ofstream fout("key.txt");
//������������
int g[10000] = {0}, g_length = 0, final[10000] = {0};
//����� ������������
double g_time = 0;

bool file_use = false;
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
    cout << "������� ����� ������-�� ������������:" << endl;
    cin >> g_length;
    if (g_length > 10000 || g_length > count)
    {
        cout << "������� ������� ������!" << endl;
        goto t1;
    }


    cout << "������� �������� ������������:" << endl;
t2:
    for (int i = 0; i < g_length; i++)
    {
        cin >> g[i];
        if (g[i] != 0 && g[i] != 1)
        {
            cout << "������� ������ 0 ��� 1!" << endl;
            goto t2;
        }
    }

    cout << "������ ��� ������������:" << endl;
    for (int i = 0; i < g_length; i++) cout << g[i] << " "; cout << endl;
    cout << "�������������� ���������� ������:" << endl;
    for (int i = 0; i < g_length; i++) cout << c[i] << " "; cout << endl;

    g_start = clock();

    for (int i = 0; i < g_length; i++)
    {
        final[i] = g[i] ^ c[i];
    }

    g_end = clock();
    g_time = g_end - g_start;

    cout << "������������ ������:" << endl;
    for (int i = 0; i < g_length; i++) cout << final[i] << " "; cout << endl;
    cout << "����� ������������:" << endl;
    cout << setprecision(10) << g_time/1000.0 << endl;
}

int main()
{
    int el = 0;
    bool flag = true;
    char action;
    while (flag)
    {
        cout << "����: " << endl;
        cout << "0. ������������� ����� ������������������" << endl;
        cout << "1. ������������� ������������������" << endl;
        cout << "2. ������� ����� ������������������" << endl;
        cout << "3. ������� n-����� ������������������" << endl;
        cout << "4. ������� ��� ������������������ �� �����" << endl;
        cout << "5. �������� ������������������ � ����" << endl;
        cout << "6. ������������" << endl;
        cout << "7. ����� ������������" << endl;
        cout << "8. �����" << endl;

        cin >> action;

        switch(action)
        {
        case '0':
            cout << "������� ����� ������������ ������������������" << endl;
            cin >> count;
            if (count > 10000)
            {
                cout << "����������� ������� ����� ������� ������������������!" << endl;
                break;
            }
            new_generate(count);
            break;
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
            cin >> el;
            if (el > count)
            {
                cout << "�������� �� ����� ��������� ����� ������������������!" << endl;
                break;
            }
            for (int i = 0; i < el; i++) fout << c[i] << " ";
            break;
        case '6':
            gam();
            break;
        case '7':
            cout << setprecision(4) << "����� ������ ������������: " << g_time << endl;
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
