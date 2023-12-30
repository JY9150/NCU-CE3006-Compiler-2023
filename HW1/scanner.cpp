/*
CE3006-* HW1-2 ScannerTest
110504514
*/

#include <iostream>
#include <string>
#include <vector>

using namespace std;

void myScanner(string in_line);

int main()
{
    vector<string> str_list;
    string line;
    string input_line = "";
    

    while (cin >> line)
    {
        input_line += line;
    }

    myScanner(input_line);

    return 0;
}

void myScanner(string in_line)
{
    string num_temp;
    string NUMBERS = "0123456789";
    for (size_t i = 0; i < in_line.size(); i++)
    {
        char c = in_line[i];
        size_t j = NUMBERS.find(c, 0);
        if (NUMBERS.find(c) != string::npos)
        {
            num_temp += c;
            continue;
        }
        else
        {
            if (num_temp != "")
            {
                cout << "NUM " << num_temp << endl;
                num_temp = "";
            }
            switch (c)
            {
            case '+':
                cout << "PLUS" << endl;
                break;
                continue;
            case '-':
                cout << "MINUS" << endl;
                break;
                continue;
            case '*':
                cout << "MUL" << endl;
                break;
                continue;
            case '/':
                cout << "DIV" << endl;
                break;
                continue;
            case '(':
                cout << "LPR" << endl;
                break;
                continue;
            case ')':
                cout << "RPR" << endl;
                break;
                continue;
            }
        }
    }
    if (num_temp != "")
    {
        cout << "NUM " << num_temp << endl;
        num_temp = "";
    }
}