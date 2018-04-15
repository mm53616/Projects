#include <iostream>
#include <cstdlib>
#include <windows.h>
#include <conio.h>
#include <fstream>


using namespace std;

void powitanie();
bool sprawdzenie_pinu();
char opcje();
void wplacanie ();
void wyplacanie ();
float saldo();


int main()
{
    powitanie();
    sprawdzenie_pinu();
    opcje();
    wplacanie ();
    wyplacanie ();
    saldo();

    return 0;
}

//Definicje wykonywanych funkcji
void powitanie()
{
cout.width( 50 );
cout << internal << "WITAJ W APLIKACJI BANKOMATOWEJ!"<< endl;
}

bool sprawdzenie_pinu()
{
    int pin;
    cout<<"Podaj numer PIN: ";
    cin>>pin;

    for (int proba=3; proba>=0; proba--)
    {   if (pin!=1025)
        {
        cout<<endl<<"Podales zly PIN. Sprobuj jeszcze raz:"<<endl<<endl;
        cin>>pin;
        Sleep(500);
        system("cls");
        cout<<"Pozostale proby: "<<proba;
        }
    }
    if (pin!=1025)
    {
        cout<<endl<<"Zablokowales swoje konto :("<<endl;
        exit(0);
    }
    else  cout<<endl<<"Udalo ci sie zalogowac!"<<endl;
    Sleep(1000);
    system("cls");
}

char opcje()
    {
    while (true)
    {
    cout.width( 50 );
    cout << internal << "OPCJE"<< endl;
    cout<<"1 - Wplac pieniadze"<< endl;
    cout<<"2 - Wyplac pieniadze"<< endl;
    cout<<"3 - Pokaz saldo"<< endl;
    cout<<"4 - Pokaz 5 ostatnich transakcji"<< endl;
    cout<<"5 - Wyjscie"<< endl<<endl;

    char wybor;
    wybor=getch();

        switch(wybor)
        {
            case '1': wplacanie(); break;
            case '2': wyplacanie(); ;break;
            case '3': saldo(); ;break;
            case '4': cout<<"Do zrobienia"; ;break;
            case '5': cout<<"Zegnaj";exit(0); break;
            default: cout<<"Nie ma takiej opcji";
        }
        Sleep(500);
        system("cls");
        cout<<endl<<endl;
    }
}

void wplacanie ()
{
    double wartosc;
    fstream plik;
    plik.open("Saldo.txt", ios::out |ios::app );
    cout<<endl<<"Jaka chcesz wplacic wartosc?:    ";
    cin>> wartosc;
    plik<<wartosc<<endl;
    plik.close();
    system("cls");
}

void wyplacanie ()
{
    double wartosc;
    fstream plik;
    plik.open("Saldo.txt", ios::out |ios::app );
    if (plik.good()==false)
    {
        cout<<"Twoje konto jest puste";
        exit(0);
    }
    cout<<endl<<"Jaka chcesz wyplacic wartosc?:    ";
    cin>> wartosc;

    plik<<wartosc<<endl;
    plik.close();
    system("cls");
}

float saldo()
{
//USUNAC FLOAT SUMA
    float suma;
    fstream plik;
    int nr_linii=1;
    string linia;
    plik.open("Saldo.txt", ios::in );
    if (plik.good()==false)
    {
        cout<<"Twoje konto jest puste";
        exit(0);
    }
    while(getline(plik,linia))
    {
        cout<<linia<<endl;
        suma=suma+atoi(linia.c_str());
    }
    cout<<plik;
    int wyjscie;
    while(wyjscie!=0)
        {   cout<<endl<<endl<<"wartosc calosci: "<<suma;
            cout<<endl<<endl<<"Wybierz 0, by wyjsc do menu: ";
            cin>>wyjscie;
        }

//   return suma;
    plik.close();
}


