// POP_2016_01_15_projekt_2_Magdalena_Manthey_IBM_2_160491.cpp  Code::Blocks 13.12 GNU GCC Compiler

#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cstring>

using namespace std;

const char MAX = 50;
const int MAX_LICZBA = 100;

struct osoba {
    int id;
    string imie;
    int znajomi;
    };
osoba tablica_osob[MAX_LICZBA];

struct para {
    int id_para;
    int id_imie1;
    int id_imie2;
    };
para tablica_par[MAX_LICZBA];

void inicjalizacja_tabel(int liczba_osob, int liczba_par, osoba *tablica_osob, para *tablica_par);
void czyszczenie_tabel(osoba *tablica_osob, para *tablica_par);
int dodaj_osobe(string imie, int *ile_osob_juz_w_tablicy, osoba *tablica_osob);
void wczytywanie (int *ile_osob, int *ile_par);
int dodaj_pare(int id1, int id2, int *ile_par_juz_w_tablicy, osoba *tablica_osob, para *tablica_par);
string wyniki (int id, int liczba_osob, int liczba_par);
void analiza_danych(int liczba_osob, int liczba_par, osoba *tablica_osob);
int zamykanie ();

int main () {

int opcja;
char wybor;
int ile_osob;
int ile_par;

    do {
        cout << " ------------------------------------" << endl;
        cout << " 1 - Otwieranie nowego pliku " << endl;
        cout << " 2 - Czyszczenie ekranu " << endl;
        cout << " 3 - Zamykanie programu " << endl;
        cout << " ------------------------------------" << endl;
        cin >> wybor;

        switch( wybor ) {

            case '1': {
                wczytywanie (&ile_osob, &ile_par);
                analiza_danych(ile_osob, ile_par, tablica_osob);
                czyszczenie_tabel(tablica_osob, tablica_par);
                break;
            }

            case '2': {
                system ( "cls" );
                break;
            }

            case '3': {
                opcja = zamykanie ();
                break;
            }

            default: {
                cout << "Nie ma takiej opcji!" << endl;
                break;
            }
        }
	}
	while ( !opcja );
    return 0;
}


// -------DZIALAJACE FUNKCJE ----------

void inicjalizacja_tabel (int liczba_osob, int liczba_par, osoba *tabela_osob, para *tabela_par) {


    for (int i=0; i<liczba_osob; i++) {
        tabela_osob[i].id = -1;
        tabela_osob[i].imie = "";
        tabela_osob[i].znajomi = 0;
    }

    for (int i=0; i<liczba_par; i++) {
        tabela_par[i].id_para = -1;
        tabela_par[i].id_imie1 = -1;
        tabela_par[i].id_imie2 = -1;
    }

}


void czyszczenie_tabel(osoba *tablica_osob, para *tablica_par){

//    delete [] tablica_osob;
//    delete [] tablica_par;
}


void wczytywanie (int *liczba_osob, int *liczba_par){

	string linia;
    char nazwa_pliku[MAX];
	fstream plik;

    cout << "Jaki plik chcesz otworzyc? " ;
	cin >> nazwa_pliku;
	cout << endl;
	plik.open ( nazwa_pliku, ios::in );

	while ( (plik.good()==false ) ){
    cout << "Nie ma pliku o takiej nazwie. Wpierw musisz go utworzyc!" << endl ;
    cout << "Jaki plik chcesz otworzyc? ";
	cin >> nazwa_pliku;
	plik.open ( nazwa_pliku, ios::in );
	}
    cout << endl;

    plik >> *liczba_osob;
    plik >> *liczba_par;
    cout << *liczba_osob<<endl;
    cout << *liczba_par<<endl;

    inicjalizacja_tabel ( *liczba_osob, *liczba_par, tablica_osob, tablica_par);

    int id1, id2;
    int id_pary;
    int ile_juz_osob = 0;
    int ile_juz_par = 0;
    string imie;
    string imie1;
    string imie2;
    bool flaga = 1;

    while (plik>>imie){

    if (flaga){
        imie1 = imie;
        id1 = dodaj_osobe(imie1, &ile_juz_osob, tablica_osob);
    }
    else {
        imie2 = imie;
        id2 = dodaj_osobe(imie2, &ile_juz_osob, tablica_osob);
        id_pary = dodaj_pare(id1, id2, &ile_juz_par, tablica_osob, tablica_par);
        cout << imie1 << "   " << imie2 << endl;
    }
    flaga = flaga ^ 1;
    }
    cout << endl << endl;

    plik.close();
}


// Funkcja zwraca identyfikator osoby o podanym imieniu
// - nowy = ile_osob_juz_w tablicy+1
// - jakis juz istniejacy gdy imie juz w tablicy

int dodaj_osobe (string imie, int *ile_osob_juz_w_tablicy, osoba *tabela_osob){
    int i; // zmienna petli wykorzystamy tez po jej zakonczeniu/przerwaniu
    for(i=0; i < *ile_osob_juz_w_tablicy;i++) {
//        if (imie.compare(tabela_osob[i].imie) != 0) {
        if (imie == tabela_osob[i].imie) //juz jest w tablicy
            break;
    }
    if (i == *ile_osob_juz_w_tablicy) { // petla doszla do konca => nowe imie
        tabela_osob[i].id = i;
        tabela_osob[i].imie = imie;
        (*ile_osob_juz_w_tablicy)++;
    }
    return i;
}


int dodaj_pare(int id1, int id2, int *ile_par_juz_w_tablicy, osoba *tabela_osob, para *tabela_par) {

    int i=0; // zmienna petli wykorzystamy tez po jej zakonczeniu/przerwaniu
    for(i=0; i < *ile_par_juz_w_tablicy; i++) {
        if (id1 == tabela_par[i].id_imie1) // imie1 ju¿ jest w tablicy
            if (id2 == tabela_par[i].id_imie2) // imie2 tez => taka para ju¿ by³a
                break;
    }
    if (i == *ile_par_juz_w_tablicy) { // petla doszla do konca => nowa para
        tabela_par[i].id_para = i;
        tabela_par[i].id_imie1 = id1;
        tabela_par[i].id_imie2 = id2;
        tabela_osob[id1].znajomi = tabela_osob[id1].znajomi + 1; // powieksz_liczbe_znajomych(id1);
        tabela_osob[id2].znajomi = tabela_osob[id2].znajomi + 1; // powieksz_liczbe_znajomych(id2);
        (*ile_par_juz_w_tablicy)++;
    }
    return i;
}


string wyniki (int id, int liczba_osob, int liczba_par){
    string wyn;
    int kod;
    kod = liczba_osob%10;
    switch(kod) {
        case 1: {if (liczba_osob <=4) wyn="sa"; else wyn="jest"; break;}
        case 2: {if (liczba_osob <=4) wyn="osoby"; else wyn="osob"; break;}
        default:break;
    }
    kod = liczba_par%10;
    switch(kod) {
        case 3: {if (liczba_par <=4) wyn="relacje"; else wyn="relacji"; break;}
        default:break;
    }
}

void analiza_danych(int liczba_osob, int liczba_par, osoba *tabela_osob) {
    int max_znaj=0;
    int min_znaj=0;
    string tekst;
    // znajdujemy maksymalna liczbe znajomych
    for (int i=0; i<liczba_osob; i++)
        if (tabela_osob[i].znajomi > max_znaj)
            max_znaj = tabela_osob[i].znajomi;
    // Teraz max_znaj zawiera max liczbê znajomych, ale to mo¿e byæ wiêcej ni¿ jedna osoba.
    // znajdujemy minimaln¹ liczbê znajomych
    min_znaj = max_znaj; // szukamy liczb mniejszych od max_znaj
    for (int i=0; i<liczba_osob; i++)
        if (tabela_osob[i].znajomi < min_znaj)
            min_znaj = tabela_osob[i].znajomi;
    // Teraz min_znaj zawiera min liczbê znajomych, ale to mo¿e byæ wiêcej ni¿ jedna osoba.

    cout << "Dla powyzszej sieci, w ktorej:" << endl;
    cout << "Liczba osob = " << liczba_osob << endl;
    cout << "Liczba par = " << liczba_par  << endl;
    cout << "liczby znajomych wynosza odpowiednio: " << endl;
    for (int i=0; i<liczba_osob; i++) {
        cout << tabela_osob[i].imie << ": " << tabela_osob[i].znajomi;
        if (i < liczba_osob-1)
            cout << ", ";
        else
            cout << ".";
    }
    cout << endl;

    cout << "W tej sieci najwiecej znajomych ( " << max_znaj << " ) ma ";
    for (int i=0; i<liczba_osob; i++){
        if (tabela_osob[i].znajomi == max_znaj){
            cout << tabela_osob[i].imie ;
            if (i < liczba_osob-1)
                cout << ", ";
            else
                cout << ".";
        }
    }
    cout << endl;
    cout << "            a najmniej znajomych (" << min_znaj << ") ma ";
    for (int i=0; i<liczba_osob; i++){
        if (tabela_osob[i].znajomi == min_znaj){
            cout << " " << tabela_osob[i].imie;
            if (i < liczba_osob-1)
                cout << ",";
            else
                cout << ".";
        }
    }
    cout << endl;

if (false) {
    cout << "Dla powyzszej sieci, w ktorej ";
    tekst = wyniki(1, liczba_osob, liczba_par);
    cout << tekst;
    cout << liczba_osob;
    tekst = wyniki(2, liczba_osob, liczba_par);
    cout << tekst;
    cout << liczba_par;
    tekst = wyniki(3, liczba_osob, liczba_par);
    cout << tekst;
    cout << "liczby znajomych wynosza odpowiednio: " << endl;
    for (int i=0; i<liczba_osob; i++) {
        cout << tabela_osob[i].imie << ": " << tabela_osob[i].znajomi;
        if (i < liczba_osob-1)
            cout << ",";
        else
            cout << ".";
    }
    cout << endl ;
}
}


int zamykanie () {
	char odp;
        cout << "Czy na pewno chcesz zamknac program?" <<endl;
        cout << "Jesli tak, wybierz T" << endl;
        cout << "Jesli sie pomyliles, wybierz N" << endl;
        cin >> odp;
        switch (odp) {
        	case 'n':
			case 'N' : return false;
			case 't' :
			case 'T' : return true;
				default : return false;
        }
}
