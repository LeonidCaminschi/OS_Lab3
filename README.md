Lab3 project Team-1

Collaborators:
Rotaru Ion
Georgeana Globa
Hariton Dan
Caminschi Leonid

1. În primul și în ultimul sector al blocului fiecărui student (pe dischetă), trebuie înscrisă informația textuală după următorul format (fără ghilimele): ”@@@FAF-21* Prenume NUME###”.
Acest șir de text trebuie dublat de 10 ori fără caractere adiționale de delimitare.

2. Creați un program în limbajul de asamblare care va avea următoarele funcții:
2.1 (KEYBOARD ==> FLOPPY) : Citirea de la tastatură a unui string cu lungimea maximală de 256 caracetre (corectarea cu backspace trebuie să funcționeze) și scrierea acestui șir pe dischetă de "N" ori, începând cu adresa {Head, Track, Sector}. După detectarea tastei ENTER, dacă lungimea șirului este mai mare ca 0 (zero), trebuie afișată o linie goală și apoi șirul recent introdus. Variabilele "N", "Head", "Track" și "Sector" trebuie citite vizibil de la tastatură. După finisarea operației de scriere pe dischetă, trebuie de afișat la ecran codul de eroare

2.2 (FLOPPY ==> RAM) : Citirea de pe dischetă a "N" sectoare începând cu adresa {Head, Track, Sector} și transferul acestor date în memoria RAM începând cu adresa {XXXX:YYYY}. După finisarea operației de citire de pe dischetă, trebuie de afișat la ecran codul de eraore. După codul de eroare, trebuie de afișat la ecran tot volumul de date aflat la adresa {XXXX:YYYY} care a fost citit de pe dischetă. Dacă volumul de date afișat este mai mare decât o pagină video atunci este necesar de implementat paginație prin apăsarea tastei ”SPACE”. Variabilele "N", "Head", "Track" și "Sector" precum și adresa {XXXX:YYYY}, la fel trebuie citite de la tastatură.

2.3 (RAM ==> FLOPPY) : Scrierea pe dischetă începând cu adresa {Head, Track, Sector} a unui volum de "Q" bytes, din memoria RAM începând de la adreasa {XXXX:YYYY}. Blocul de date de "Q" bytes trebuie afișat la ecran, iar după finisarea operației de scriere pe dischetă, trebuie de afișat la ecran codul de eroare.

3. Raport
