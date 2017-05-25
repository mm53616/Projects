// POP_2015_12_10_projekt_1_Magdalena_Manthey_IBM_2_160491.cpp

#include <iostream>
#include <iomanip>
#include <ctime>
#include <cstdlib>
#include <string>
#include <conio.h>

using namespace std;

const int L_MIN = 10;
const int L_KOL = 10;
const int L_WRS = 10;

const int MAX_MIN = 20;
const int MAX_KOL = 15;
const int MAX_WRS = 15;

const int SZER_POLA = 6;
const int WYS_POLA = 2;

const int KOD_PUSTY = 0; // pole puste
const int KOD_KROK  = 1; // pole odwiedzone
const int KOD_MINA  = 2; // pole wyświetlone jako puste z ukrytą miną
const int KOD_POZ   = 3; // pole aktualnej pozycji #
const int KOD_DEAD  = 4; // pole detonacji &
const int KOD_WYKR  = 5; // pole skąd wykryto minę !
const int KOD_DET   = 6; // pole skad wykrywamy minę #!
const int KOD_END   = 7; // pole wyświetlające po przegranej miny *             

bool mina;
bool szukaj = true;

struct s_gra {
    int T[L_KOL][L_WRS];
    int ile_krokow;
    bool skan;                                         
    int poz_x_obecn;
    int poz_y_obecn;
    int poz_x_stop;
    int poz_y_stop;
};
s_gra gra;

// ----- DEKLARACJA PODPROGRAMÓW -----
void inicjalizacja(s_gra *l_gra);
void czysc_ekran();
void instrukcja(s_gra *l_gra);
int  ruch(s_gra *l_gra);
void rysowanie(s_gra *l_gra);
void gen_min(s_gra *l_gra);
bool skanowanie_old(s_gra *l_gra);
int sprawdzenie(s_gra *l_gra, bool *l_szukaj);
void podsumowanie(s_gra *l_gra);

int main () {
    inicjalizacja(&gra); // Przygotowanie pustej tablicy z wyzerowanymi wartościami
    gen_min (&gra);
    sprawdzenie(&gra, &szukaj);
    mina = skanowanie_old(&gra);
    czysc_ekran();
    instrukcja(&gra);
    rysowanie(&gra);
    while (szukaj) {
        ruch(&gra);
        sprawdzenie(&gra, &szukaj);
        if (!szukaj)
            break;
        mina = skanowanie_old(&gra);
        czysc_ekran();
        instrukcja(&gra);
        rysowanie(&gra);
    }
        czysc_ekran();
        podsumowanie(&gra);
        rysowanie(&gra);
    return 0;
}

// ------ DZIAŁAJĄCE FUNKCJE -------
void czysc_ekran()
{
  system( "cls" );
  return;
}

void inicjalizacja(s_gra *l_gra)
{
    // czyszczenie tablicy jedną komendą
    // memset(&gra, KOD_PUSTY, L_KOL*L_WRS*sizeof(int))
    for (int i=0; i < L_WRS; i++) {
        for (int j=0; j < L_KOL; j++)
            l_gra->T[i][j] = KOD_PUSTY;
    }
    l_gra->ile_krokow  = 0;
    l_gra->skan = false;
    l_gra->poz_x_obecn = 0;
    l_gra->poz_y_obecn = L_WRS-1;
    l_gra->poz_x_stop  = L_KOL-1;
    l_gra->poz_y_stop  = 0;
    return;
}


void gen_min (s_gra *l_gra) {
    int miny_do_postawienia = L_MIN;
    int i, j;
    srand(time(NULL));
    gra.T[l_gra->poz_x_obecn][l_gra->poz_y_obecn] = KOD_POZ;
    while (miny_do_postawienia) {
        i = rand()%(L_KOL);
        j = rand()%(L_WRS);
        if ((i==L_KOL-1) && (j==0))
            continue;
        if (l_gra->T[i][j] == KOD_PUSTY) {
            l_gra->T[i][j] = KOD_MINA;
            miny_do_postawienia--;
        }
    }
}

bool skanowanie_old(s_gra *l_gra)
{
    int i, j;
    l_gra->T[l_gra->poz_x_obecn][l_gra->poz_y_obecn] = KOD_POZ;
    for (i=-1; i < 2; i++) {
        if (((l_gra->poz_x_obecn+i) <0 ) or (( l_gra->poz_x_obecn+i)>=L_KOL))
            continue;
        for ( j=-1; j < 2; j++) {
            if (((l_gra->poz_y_obecn+j) <0) or ((l_gra->poz_y_obecn+j>=L_WRS)))
                continue;
            if (l_gra->T[l_gra->poz_x_obecn+i][l_gra->poz_y_obecn+j] == KOD_MINA){
                l_gra->T[l_gra->poz_x_obecn][l_gra->poz_y_obecn] = KOD_DET;
                return true;
            }
        }
    }
    return false;
}


void instrukcja (s_gra *l_gra)
{
    cout << "GRA ZWIADOWCA" << endl;
	cout << "Sprobuj bezpiecznie doprowadzic zwiadowce do mety (prawy, gorny rog) unikajac bomb *" << endl;
    cout << "Detektor min #! wskarze ci, jesli wokol jest niebezpieczenstwo" << endl;
    cout << "Twoja aktualna pozycja to #, a odwiedzone pola to ." << endl;
    cout << "Odwiedzone pola w poblizu ktorych znajdowaly sie miny to !." << endl;
	cout << "Przegrasz stajac na bombe - twoja ostatnia pozycja to &" << endl;
    cout << "Jesli chcesz pojsc w gore,  wybierz W " << endl;
    cout << "Jesli chcesz pojsc w dol,   wybierz S " << endl;
    cout << "Jesli chcesz pojsc w lewo,  wybierz A " << endl;
    cout << "Jesli chcesz pojsc w prawo, wybierz D " << endl;
    cout << "Wybierz " ;
    if (l_gra->poz_y_obecn > 0) cout << "W ";
    if (l_gra->poz_y_obecn < L_WRS-1) cout << "S ";
    if (l_gra->poz_x_obecn > 0) cout << "A ";
    if (l_gra->poz_x_obecn < L_KOL-1) cout << "D ";
    cout << endl;
}

void podsumowanie (s_gra *l_gra) {
    cout << "GRA ZWIADOWCA" << endl;
    cout << "Gra zakonczona" << endl;
    cout << "Liczba ruchow wykonanych: " << setw(5) << l_gra->ile_krokow << endl;
    cout << endl << endl << endl;
}
int sprawdzenie (s_gra *l_gra, bool *l_szukaj)
{
    if (l_gra->T[l_gra->poz_x_obecn][l_gra->poz_y_obecn] == KOD_MINA) {
        *l_szukaj = false;
        l_gra->T[l_gra->poz_x_obecn][l_gra->poz_y_obecn] = KOD_DEAD;
    }

    if ( (l_gra->poz_x_obecn == l_gra->poz_x_stop) && (l_gra->poz_y_obecn == l_gra->poz_y_stop) ) {
        *l_szukaj = false;
        gra.T[l_gra->poz_x_obecn][l_gra->poz_y_obecn] = KOD_POZ;
    }

    if (*l_szukaj == false) {
        for (int i=0; i < L_WRS; i++)
            for (int j=0; j< L_KOL; j++) {
                if (l_gra->T[i][j] == KOD_MINA)
                    l_gra->T[i][j] = KOD_END;
            }
    }
}


int ruch (s_gra *l_gra)
{
    int kod_ruchu=0;
    char kod_cin;
    int flaga=true;

    if (l_gra->T[l_gra->poz_x_obecn][l_gra->poz_y_obecn] == KOD_POZ)
        l_gra->T[l_gra->poz_x_obecn][l_gra->poz_y_obecn] = KOD_KROK;
    if (l_gra->T[l_gra->poz_x_obecn][l_gra->poz_y_obecn] == KOD_DET)
        l_gra->T[l_gra->poz_x_obecn][l_gra->poz_y_obecn] = KOD_WYKR;

    while(flaga) {
        // Tu sprawdzenie kodów znaków
//            cin >> kod_cin;
//            kod_ruchu = (int)kod_cin;
        kod_ruchu = getch();
        switch (kod_ruchu) {
        case 'W' :
        case 'w' : if (l_gra->poz_y_obecn > 0) { l_gra->poz_y_obecn--; flaga = false; }
        break;
        case 'S' :
        case 's' : if (l_gra->poz_y_obecn < L_WRS-1) { l_gra->poz_y_obecn++; flaga = false; }
        break;
        case 'A' :
        case 'a' : if (l_gra->poz_x_obecn > 0) { l_gra->poz_x_obecn--; flaga = false; }
        break;
        case 'D' :
        case 'd' : if (l_gra->poz_x_obecn < L_KOL-1) { l_gra->poz_x_obecn++; flaga = false; }
        break;
        default : flaga=true; break;
        }
    }
    l_gra->ile_krokow++;
    return 0;
}

void rysowanie (s_gra *l_gra)
// Rysujemy tekstowo wierszami pól
// Każdy wiersz pól składa się z linii ramki i linii póls_gra *l_gra
// Na końcu pojedynczy wiersz ramki
// Podobnie w ramach wierszy rysujemy pola kolejno w kolumnach
// za pomocą 4-znakowych stringów i wiersz kończymy pojedynczym znakiem prawej ramki
{
    string pole_ramka  = "------";
    string pole_pusty  = "|     ";
    string pole_krok   = "|  .  ";
    string pole_mina   = "|  !  ";
    string pole_poz    = "|  #  ";
    string pole_dead   = "|  &  ";
    string pole_det    = "|  #! ";
    string pole_end    = "|  *  ";

    for (int i=0; i < L_WRS; i++) {
        for (int k=0; k< L_KOL; k++)
            cout << pole_ramka;
        cout << "|" << endl;
        for (int j=0; j< L_KOL; j++) {
            switch (gra.T[j][i]) {
                case KOD_PUSTY : cout << pole_pusty; break;
                case KOD_KROK  : cout << pole_krok ; break;
                case KOD_MINA  : cout << pole_pusty; break;
                case KOD_POZ   : cout << pole_poz  ; break;
                case KOD_DEAD  : cout << pole_dead ; break;
                case KOD_WYKR  : cout << pole_mina ; break;
                case KOD_DET   : cout << pole_det  ; break;
                case KOD_END   : cout << pole_end  ; break;
                }
            }
        cout << "|" << endl;
    }
    for (int k=0; k< L_KOL; k++)
        cout << pole_ramka;
    cout << "|" << endl;
}
