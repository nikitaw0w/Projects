/**
 * 1.cpp -- ����� ����������-���������� ������.
 * Bazhenov Nikita (c) 2016
 */

#include <iostream>
#include <fstream>
#include <stdlib.h>
#include <cstring>
#include <iterator>
#include <sstream>

using namespace std;

//������ ��� ������ �� �����
string line;
//���������� ��������, ����� (3 �� �������), ����� ������
int col = 3, row = 3, len = 0;
//���������� ����� � �������� � ���������� �������
int x = 0, y = 0;
//���������� ��� ���������� �������� ����� (��������)
int fold = 0;
//��������� ������ ��� ���������� �������
char A[1000][1000];
//������� �������
int cur = 0;
//������ ������ ��������
int ckey[3] = {2, 1, 3};
//������ ������ �����
int rkey[3] = {3, 1, 2};
//������ ���������� �����, ������������ �� ������� K = n(ri-1)+sj (�� �������)
int final_key[9];
//��������� ������ ������������� ������
char block[9][1000];
//�������� �������� �����
int cur_key = 0;
//�������� �������� �������
int cur_col = 0;
//���������� �������� � ������
int total = 0;

/*
 * �������� ����������
 * @param len ����� ������
 * @param line ������ ��� ������ �����
 */

void get_information()
{
    len = line.size();
    cout << "�����:\n" << line << endl;
    cout << "����� ������:\n" << len << endl;
    cout << "������� � �������:\n";
    for (int i = 0; i < x; i++)
    {
        for (int j = 0; j < y; j++)
        {
            cout << A[i][j];
        }
        cout << endl;
    }
    cout << "������� ��������� ����:" << endl;
    for (int i = 0; i < 9; i++) cout << final_key[i] + 1;
    cout << endl;
}

/*
 * �������� ��������� ������
 * @param cur ������� �������
 * @param row ���-�� �����
 * @param col ���-�� ��������
 * @param rkey ������ ������ �����
 * @param ckey ������ ������ ��������
 * @param final_key ������ ���������� �����
 * @param ri ���� ������
 * @param sj ���� �������
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
 * ������ �����
 * @param rkey ������ ������ �����
 * @param ckey ������ ������ ��������
 * @param final_key ������ ���������� �����
 * @param en ������� ������ ������ (�������), ���������� � ����������
 */

void enter_keys()
{
    int en[3];
    cout << "������� ���� �� �������� (1, 2, 3 ��� ���������� � ����� �������):" << endl;
    cin >> en[0]; if (en[0] != 1 && en[0] != 2 && en[0] != 3) { cout << "������� ���������� ��������!" << endl; return; }
    cin >> en[1]; if (en[1] != 1 && en[1] != 2 && en[1] != 3) { cout << "������� ���������� ��������!" << endl; return; }
    cin >> en[2]; if (en[2] != 1 && en[2] != 2 && en[2] != 3) { cout << "������� ���������� ��������!" << endl; return; }
    if (en[0] == en[1] || en[0] == en[2] || en[1] == en[2]) { cout << "�������� �� ����� �����������!" << endl; return; }
    for (int i = 0; i < 3; i++) ckey[i] = en[i];

    cout << "������� ���� �� ������� (1, 2, 3 ��� ���������� � ����� �������):" << endl;
    cin >> en[0]; if (en[0] != 1 && en[0] != 2 && en[0] != 3) { cout << "������� ���������� ��������!" << endl; return; }
    cin >> en[1]; if (en[1] != 1 && en[1] != 2 && en[1] != 3) { cout << "������� ���������� ��������!" << endl; return; }
    cin >> en[2]; if (en[2] != 1 && en[2] != 2 && en[2] != 3) { cout << "������� ���������� ��������!" << endl; return; }
    if (en[0] == en[1] || en[0] == en[2] || en[1] == en[2]) { cout << "�������� �� ����� �����������!" << endl; return; }

    for (int i = 0; i < 3; i++) rkey[i] = en[i];
    get_final();
    cout << "��������� ������:" << endl;
    for (int i = 0; i < 9; i++) cout << final_key[i] + 1;
    cout << endl;
}

/*
 * ����������� �����
 * @param total ���-�� �������� � ������
 * @param cur ������� �������
 * @param cur_col �������� �������� �������
 * @param cur_key �������� ������� �����
 * @param len ����� ������
 * @param row ���-�� �����
 * @param col ���-�� ��������
 * @block ��������� ������ ������������� ������
 * @param final_key ������ ���������� �����
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
    cout << "������������� �����:" << endl;
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
 * ������������ �����
 * @param line ������ ��� ������ �� �����
 * @param total ���-�� �������� � ������
 * @param cur ������� �������
 * @param cur_col �������� �������� �������
 * @param cur_key �������� ������� �����
 * @param len ����� ������
 * @block ��������� ������ ������������� ������
 * @param final_key ������ ���������� �����
 * @param decr �������������� ������
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
    cout << "�������������� �����:\n" << decr << endl;
    cout << "��������: " << total << endl;
}

int main()
{
    //�������� ����� � �������� �������
    ifstream fin("input.txt");

    if (!fin.is_open()) cout << "���� �� ����� ���� ������." << endl;
    //�������� ����������� ����� � ������ line � ��������� � ��������� �� ����� ������
    else line.assign((istreambuf_iterator<char>(fin.rdbuf())), istreambuf_iterator<char>());

    fin.close();

    //��������� ����� ������
    len = line.size();
    //���������� ���-�� ������ �����
    x = len / row;
    //���-�� �������� ������ ����� 3
    y = col;

    //���� �������� ������ ������� (�� �������� ���� �������, ����������� �������)
    fold = len % row;
    if (fold) x++;

    //��������� ������ � ��������� ������, ������� �������
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
        cout << "����: " << endl;
        cout << "1. ������ ���������� � ������" << endl;
        cout << "2. ������ ����� ��������" << endl;
        cout << "3. ����������� �����" << endl;
        cout << "4. ������������ �����" << endl;
        cout << "5. �����" << endl;

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
            cout << "������� ����� ������ ����!" << endl;
            break;
        }
    }

    return 0;
}
