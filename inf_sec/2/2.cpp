/**
 * 2.cpp -- �������� ����������� �� ������ ��������.
 * Bazhenov Nikita (c) 2016
 */

#include <iostream>
#include <cstring>
#include <cmath>
#include <stdlib.h>

using namespace std;

//�������� ������������������
char s[12] = {'0'};
//�������������� ������������������
char c[17] = {'0'};
//k-�� ������ ������� ��� �����������
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
//������ ���������� ��������� ��� ��������������
bool inv[5] = {false};
//����������� ���-�� ������ � ������� (������������� ����)
int count[5] = {0};
//������� ������� (12)
int k = 0;
//������������ ������������������
char n[17] = {'0'};
//����������� ���-�� ������ � ����� ������ (n)
int ncount[5] = {0};
//������ ���������� ��������� (n)
int ninv[5] = {false};
//���������� �����������
int mismatches = 0;
//������������ ������������������ (���������)
char nfixed[12] = {'0'};

/* ���� ��������� ������������������
 *
 */

void enter_first()
{
    //��������� ��������
    for (int i = 0; i < 5; i++) count[i] = 0;
    for (int i = 0; i < 5; i++) inv[i] = false;
    for (int i = 0; i < 12; i++) s[i] = '0';
    for (int i = 0; i < 17; i++) c[i] = '0';
    k = 0;

m1:
    cout << "������� ������������������:" << endl;
    for (int i = 0; i < 12; i++)
    {
        cin >> s[i];
        //���� ������� �� ����� 0 ��� 1, ��������� � ���� m1
        if (s[i] != '0' && s[i] != '1') goto m1;
    }

    cout << "��������� ������������������:" << endl;
    for (int i = 0; i < 12; i++) cout << s[i] << " ";
    cout << endl;

    cout << "k-�� ������ ������� (a1, a2, a3, a4, a5):" << endl;
    for (int i = 0; i < 17; i++) cout << a1[i] << " "; cout << endl;
    for (int i = 0; i < 17; i++) cout << a2[i] << " "; cout << endl;
    for (int i = 0; i < 17; i++) cout << a3[i] << " "; cout << endl;
    for (int i = 0; i < 17; i++) cout << a4[i] << " "; cout << endl;
    for (int i = 0; i < 17; i++) cout << a5[i] << " "; cout << endl;

    cout << "������ ����������" << endl;
    for (int i = 0; i < 5; i++) cout << inv[i] << " "; cout << endl;

    //���������������� ������-�� � ������������ ������
    for (int i = 0; i < 17; i++)
    {
        if (i == 0 || i == 1 || i == 3 || i == 7 || i == 15) c[i] = '0';
        else
        {
            c[i] = s[k];
            k++;
        }
    }

    //���������� �� ��������� ������ ����������� �����
    for (int i = 0; i < 17; i++)
    {
        //���� ����������� ����
        if (i != 0 && i != 1 && i != 3 && i != 7 && i != 15)
        {
            //���� ����� ������ (n ����� N), � ���� ��-� ����� 1
            if (a1[i] == '1' && c[i] == '1') count[0]++;
            if (a2[i] == '1' && c[i] == '1') count[1]++;
            if (a3[i] == '1' && c[i] == '1') count[2]++;
            if (a4[i] == '1' && c[i] == '1') count[3]++;
            if (a5[i] == '1' && c[i] == '1') count[4]++;
        }
    }

    //��������� ����������� ������ � ������ ����������� �����
    for (int i = 0; i < 5; i++) if ((count[i] % 2) == 1) inv[i] = true;
    if (inv[0] == true) c[0] = '1';
    if (inv[1] == true) c[1] = '1';
    if (inv[2] == true) c[3] = '1';
    if (inv[3] == true) c[7] = '1';
    if (inv[4] == true) c[15] = '1';

    cout << "�������������� ������������������:" << endl;
    for (int i = 0; i < 17; i++) cout << c[i] << " "; cout << endl;

    //����������� ���� ���������� *
    for (int i = 0; i < 17; i++)
    {
        if (i == 0 || i == 1 || i == 3 || i == 7 || i == 15) cout << "*" << " ";
        else cout << "  ";
    }
    cout << endl;
}

/* ���� ������������ ������������������
 *
 */

void enter_new()
{
    //��������� ��������
    for (int i = 0; i < 5; i++) ncount[i] = 0;
    for (int i = 0; i < 5; i++) ninv[i] = false;
    for (int i = 0; i < 17; i++) n[i] = '0';
    for (int i = 0; i < 12; i++) nfixed[i] = '0';
    mismatches = 0;
    k = 0;
    //������
    int lim = 0;

m2:
    //���� ������������ ������-��
    lim = 0;
    for (int i = 0; i < 17; i++)
    {
        cin >> n[i];
        if (n[i] != '0' && n[i] != '1')
        {
            cout << "������� �������� 0 ��� 1!" << endl;
            goto m2;
        }
        if (i == 0 || i == 1 || i == 3 || i == 7 || i == 15)
            if (c[i] != n[i])
            {
                cout << "�������� ���� ������ ���������!" << endl;
                goto m2;
            }
        if (c[i] != n[i])
        {
            lim++;
            if (lim > 1)
            {
                cout << "� ������������������ �� ����� ���� ������ 1 ������!" << endl;
                goto m2;
            }
        }
    }

    cout << "������������ ������������������:" << endl;
    for (int i = 0; i < 17; i++) cout << n[i] << " "; cout << endl;
    for (int i = 0; i < 17; i++)
    {
        if (i == 0 || i == 1 || i == 3 || i == 7 || i == 15) cout << "*" << " ";
        else cout << "  ";
    }
    cout << endl;

    //������� ������ � ����� ����������� ������
    for (int i = 0; i < 17; i++)
    {
        if (a1[i] == '1' && n[i] == '1') ncount[0]++;
        if (a2[i] == '1' && n[i] == '1') ncount[1]++;
        if (a3[i] == '1' && n[i] == '1') ncount[2]++;
        if (a4[i] == '1' && n[i] == '1') ncount[3]++;
        if (a5[i] == '1' && n[i] == '1') ncount[4]++;
    }

    //�������������� �������� ����������� �����
    for (int i = 0; i < 5; i++) if ((ncount[i] % 2) == 1) ninv[i] = true;
    if (ninv[0] == true) if (n[0] == '0') n[0] = '1'; else n[0] = '0';
    if (ninv[1] == true) if (n[1] == '0') n[1] = '1'; else n[1] = '0';
    if (ninv[2] == true) if (n[3] == '0') n[3] = '1'; else n[3] = '0';
    if (ninv[3] == true) if (n[7] == '0') n[7] = '1'; else n[7] = '0';
    if (ninv[4] == true) if (n[15] == '0') n[15] = '1'; else n[15] = '0';

    cout << "������ ����������� ����� ��� �������� " << endl;
    for (int i = 0; i < 5; i++) if (!false) cout << ninv[i] << " "; cout << endl;
    cout << "������������ ������-�� � ������� ����������� �����" << endl;
    for (int i = 0; i < 17; i++) cout << n[i] << " "; cout << endl;

    //���������� ������� ������������
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
        cout << "������������: " << mismatches << endl;
        cout << "�������������� ���������� ������-�� ��� �����. �����:" << endl;
        for (int i = 0; i < 12; i++) cout << nfixed[i] << " "; cout << endl;

        //��������������� ������-�� ��� �����. �����
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
    cout << "������������ ������������������:" << endl;
    for (int i = 0; i < 12; i++) cout << nfixed[i] << " "; cout << endl;
}


int main()
{
    bool flag = true;
    char action;
    while (flag)
    {
        cout << "����: " << endl;
        cout << "1. ������ ��������� ������������������" << endl;
        cout << "2. ������ ������������ ������������������" << endl;
        cout << "3. �����" << endl;

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
            cout << "������� ����� ������ ����!" << endl;
            break;
        }
    }

    return 0;
}
