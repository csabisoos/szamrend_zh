# Számrend gyakorlat anyag jegyzet

**Hasznos oldalak:**  
- http://mokus.web.elte.hu  
- http://www.freeos.com/guides/lsst/  
- https://bash.cyberciti.biz  
- http://www.szabilinux.hu/vi/index.html  
- https://linuxvilag.hu/content/files/cikk/36/cikk_36_78_80.pdf  
- https://explainshell.com (nem tudom lehet-e használni, mert igazából választ ad vissza, szóval nem statikus)  

## 1Hardware

### A tantárggyal kapcsolatos információk közlése, követelmények ismertetése, hardware ismeretek. 

## 2Unix

## 3Unix
### **A Linux könyvtárszerkezete, fontosabb könyvtárak:**  
- / A főkönyvtár, a könyvtárfa kiindulópontja  
- /home Ehhez csatlakoznak a felhasználók könyvtárai  
- /dev A hardvereszközöket reprezentáló fájlok  
- /etc A legfontosabb konfigurációs fájlok  
- /usr/bin Közhasználatú parancsok  
- /sbin A superuser és a rendszerindító parancsok  
- /usr/doc Dokumentációs fájlok  
- /usr/local/man Kézikönyv oldalak  
- /tmp Ideiglenes fájlok  
- /var Konfigurációs fájlok (Linkek az /usr-ből)  
- /lib Megosztott programkönyvtárak  
- /proc A processzek fájlrendszere  

### **Alap unix parancsok:**  
a. passwd helyett kpasswd, who, whoami  
b. shell fogalma, aktuális shell: bash, felfele nyíl, tabulátor  
c. pwd, ls és legfontosabb paraméterei ls –l, ls -al, parancsok értelmezése, unix filerendszer alapok, /, /etc, /var stb. könyvtárak, cd, mkdir, rmdir.  
    i. Másolás, cp, mozgatás, mv, tartalom megnézés, cat  
d. I/O átirányítás, ennek segítségével file létrehozása. File törlés, rm, nincs ezután „undelete”   
e. touch parancs   
f. Feladat: hozzon létre a könyvtárszerkezetet: foci/nb1, foci/nb2, majd ezalatt, utána töröljük, rm –r   
g. Link ln parancs.   
h. Irassuk ki egy nagy könyvtár tartalmát a képernyőre. Majd egy fájlba és azt a more vagy less paranccsal megjeleníteni.( ls /bin > /lsbin majd   
i. more /lsbin). Ezután tegyük ugyanezt pipeline használatával (ls /bin | more)   
j. Csomagoljuk össze könyvtárunk tartalmát zip illetve tar fájlokban.    
k. Felhasználó keresése: finger. „Beszélgetés” másik felhasználóval: talk.  

### **Jogosítványok:**  
a. Az alábbi parancsok „normál” unix fájlrendszer alatt működnek. Jelen inf-es kiszolgálón a home könyvtár AFS rendszerű. Ezen is van látszólag chmod, de AFS rendszeren az fs parancson keresztül lehet a jogosítványokat állítani. fs setacl illetve fs listacl a legfontosabb 2 parancs. Ezekről és más AFS jogosítványokról bővebben előadáson lesz szó, illetve manual, és egyéb internetes dokumentációkban találhatunk leírást, mintákat. Gyakorlaton csak az fs listacl fájlnév forma használata szerepeljen!   
b. ls –l, rwx-ek, módosításuk, UNIX fájlrendszer alatt!    
c. chmod:  
    chmod u+x file név: Végrehajtási jogosultságot ad a file tulajdonosának   
    chmod go-rx file nevek: Visszavonja az olvasási és végrehajtási   
    jogosultságokat a csoport- és az egyéb felhasználóktól 
    chmod 644 file név: Olvasási és írási jogosultságot ad a tulajdonos, csak   
    olvasási jogosultságot ad  minden egyéb felhasználó számára   
d. Állomány alapjogok, umask   
e. Tulajdonjog megváltoztatása: chown  

### **Írassuk ki az aktuális könyvtárban lévő összes html kiterjesztésű file utolsó 2 sorát.**  
a. find . -name "*.html" -exec tail -2 {} \;  

### **Töröljük le a munkakönyvtárból az összes fájlt és a könyvtárat is.**  
a. rm *   
b. cd ..   
c. rmdir temp/  

## 4Unix

### ***Téma:** Processzek: ps, kill, trap, bg, fg, wait. Szövegszerkesztés: vi, pico, joe. Midnigth Commander: mc., Sorok manipulációja.* 

### Futó folyamatok lekérése  
A futó folyamatokat a ps paranccsal kérhetjük le.  
Az egyes mezők jelentése:  
PID -  a folyamat azonosítója   
TTY - a vezérlõ terminál azonosítója, jelen esetben ez a ttyp0   
STAT - a folyamat állapota  
TIME - a processz által eddig elhasznált processzor idő  
A rendszerben futó összes folyamatot, a legbővebb információkkal Linux alatt a "ps -aux" opciókkal kérhetjük le. Ekkor a processzekről megtudjuk még tulajdonosukat, az időpontot amikor elindultak, valamint különféle erőforrás használati információkat (CPU, memória használat, a program mérete a memóriában).   
 
top: Információk a processzekről és egyéb statisztikák a rendszerről. A top folyamatosan fut, és 5 másodpercenként frissíti a megjelenített információkat. Kilépni a "q" megnyomásával lehet.  

### Programok indtása  
**Programok indítása előtérben:** A program az előtérben fut, amíg nem fejezi be futását addig a felhasználó az adott héjban (shell, burok) nem indíthat újabb programot. Az előtérben futó program birtokolja a billentyűzetet. A hagyományos elindítással, tehát alapértelmezés szerint a programok az előtérben futnak. Vagy az fg <parancsnév> használatával.  
**Programok indítása háttérben:** Háttérben úgy tudunk futtatni programot, hogy ’&’ jelet kell gépelni a parancs után.  
1. `sleep 20`  
    20 másodpercig vár, előtérben futtatva. A vezérlést 20 másodperc múlva kapjuk vissza.   
2. `sleep 20&`   
    20 másodpercig vár a háttérben. Két számot ír ki, pl.: [1] 532 majd visszaadja a vezérlést. Az első szám az adott burok feladatazonosítója, a második a rendszeren érvényes egyedi feladatazonosító, PID. Majd 20 másodperc múlva, amikor a folyamat végzett, a burok üzenetet küld a felhasználónak pl.: [1] + Done. A felhasználó csak akkor kap értesítést, amikor a következő ENTER-t megnyomja.
3. `nohup <parancsnév>`: (no hangup): Ha egy parancs elé a nohup kulcsszót tesszük, az adott program futása nem szakad meg a felhasználó kijelentkezésekor. Kimenete hozzáfűződik a nohup.out állományhoz. 
`nohup ls`  
`more nohup.out`  

### Processzek kezelése  
Az előtérben futó folyamatot be kell fagyasztani ahhoz, hogy később a háttérben, kívülről lehessen irányítani. ctrl + z.   
Pl.: `sleep 100`, majd ctrl + z, továbbá kapunk egy folyamatazonosítót is, későbbi felhasználásra. Ezt követően a ps-t kiadva láthatjuk a még futó folyamatot.  
- `fg`: Egy háttérben futó vagy befagyasztott folyamatot az előtérbe helyezhetünk vele.  `fg %1` vagy `fg sleep` 
- `bc`: Egy befagyasztott programot a háttérben folytathatunk.  
- `jobs`: belső feladatazonosítók lekérdezése. Kiírja továbbá a futó folyamatok állapotát is  (Running, Stopped, stb.)  
- `kill`: Folyamat bezárása. „Normál” felhasználó csak a saját folyamatait állíthatja le, a rendszergazda bárkiét. A kill parancs, paramétere lehet a folyamat száma vagy pedig a processz azonosítója (PID).  
    Hagyományos leállítás:  
    `kill %1`  
    `kill 3954`  
    Példa: A `yes` parancs y karakterek végtelen sorozatát küldi a kimenetére. Hogy ne kelljen az y-ok végtelen sorát látni irányítsuk át a kimenetet egy alkalmas helyre:  
    /dev/null - egy un. fekete lyuk: a beleirányított összes információt elnyeli: `yes > /dev/null`  
    Így kaptunk egy előtérben futó jobot. Hogy a háttérbe tegyuk, a "&" jelet kell alkalmaznunk: `yes > /dev/null &`  
    Feladat: a `kill` paranccsal állítsuk le a futó folyamatot.  
- Jelek: 0-15 közti számok, valójában egy eseményt jelöl egy szám  
    - Egy jel küldése egy processznek: kill –jel PID  
    - PL: 2 – ctrl+c, 9- kill ,feltétel nélküli befejezés  
    - 15 jel az alapértelmezés, ez a szoftver befejezés  

### Szignálok  
A Unix rendszer a folyamatok vezérlését a folyamatoknak küldött ún. szignálok (signals) segítségével végzi: a ^Z billentyû például egy STOP szignált küld az előtérben futó processznek. Processzt kiölni szintén szignál(ok) segítségével lehet: az előtérben futó program a ^C (Ctrl-c) megnyomására egy INT szignált kap, amely rendszerint a program elhalálozását vonja maga után. Háttérben futó folyamatainkat a "kill" paranccsal irthatjuk ki: alapértelmezés szerint a "kill" egy TERM (terminate) szignált küld a megadott folyamatnak.  
Ha más (nem TERM) szignált akarunk küldeni, a kill parancsot megfelelően paraméterezni kell, például a STOP szignálhoz: "kill -STOP pid". Ennek ugyanolyan hatása van, mintha az a folyamat az előtérben futna, és a ^Z-t nyomtuk volna meg: a folyamat felfüggesztett állapotba kerül. Folyamatot megölni még a HUP (hangup) és a KILL szignálokkal is lehet. (Az előbb látott nohup parancs ezen HUP szignál ellen teszi immunissá a folyamatot.) A sokféle látszólag azonos hatású szignál oka, hogy korántsem azonos hatásúak: például a HUP és a TERM szignálokat a folyamat felülbírálhatja, saját szignál-kezelő rutint állíthat be (így van ez az INT szignálnál is). Ezeket a szignálokat a folyamat kapja meg, és alapértelmezés szerinti kezelő rutinjuk lép ki. A KILL szignál hatására viszont a kernel öli meg a folyamatot, annak megkérdezése nélkül. Ezért nem probléma Unixban, ha egy folyamat "lefagy", végtelen ciklusba kerül: egy KILL szignál mindig megoldja a problémát.  
Szignált csak saját processzeinknek küldhetünk (kivéve a root-ot, aki bármely processzel rendelkezhet). Az eddig felsoroltakon kívül még számos egyéb szignál van, megemlítjük még az ALARM szignált: a rendszert megkérhetjük, hogy megadott idő múlva küldjön egyet. Ezt használják időzítési célokra, többek között a "sleep" utasítás is így mûködik. De szignálokat használ a rendszer sok más egyéb, a folyamatot érintő rendszerinformáció közlésére is, de ezek főleg programozók számára érdekesek.  

### Processz erőforrás-felhasználás  
- `time <parancsnév>`: Ha egy parancs elé a time kulcsszót írjuk, akkor a burok az indított program befejezése után statisztikai adatokat ad a feladat által használt erőforrásokról, kiírja, hogy mennyi idő alatt futott le és mekkora terhelést jelentett a rendszer számára.   pl.: `time ls`   
- `strace <parancsnév>`: Hibakereséshez használatos parancs. Az indított program minden rendszerhívását kiírja.   pl.: `strace ls`   pl: `strace –p 16543` - a figyelt folyamat azonosítója   

### Csapdák (eseménykezelés)  
`trap` parancs. Bizonyos jeleket lehet, címzés nélkül küldeni, ctrl+c, ctrl+\ (3, quit)  
Feladat: A ctrl+c leütésére írjuk ki: Hajrá ELTE!  
Megoldás: `trap ’echo Hajrá ELTE!’ 2`   
Feladat: Szüntessük meg ezt a csapdát, „eseménykézelést”!:   
Megoldás: `trap ’’ 2`  

### Szövegszerkesztés  
Parancsmód: esc bill.  
1. mentés:  
    a. :w, :x – kilépés mentéssel  
    b. :wq – mentés, bezárás  
    c. :q! – kilépés mentés nélkül  
2. karakter törlés: x  
3. sortörlés: dd, 3 sor törlés: 3dd  
4. Beillesztés: p  
5. Keresés: /mit  
Szerkesztőmód: i, a, o

### Sorok manipulációja  
A szűrők később visszatérnek a scriptes részben! Elegendő arra utalni, hogy milyen fontos feladatot látnak el. Nem kell ezeket a feladatokat megoldani, elég egy-két példa! Parancsként és szűrőként is működnek pl. wc, grep, cut, sort   
**Feladat:**  
1.  Számoljuk meg az aktuális könyvtárban lévő bejegyzések számát. Készítsük el a megoldást parancsként és szűrőként is a megoldást!   
2.  Listázzuk ki az aktuális könyvtár alkönyvtárait! (A könyvtáraknál d az első karakter – grep ^d, cut )  
3.  Listázzuk ki a bejelentkezett felhasználók azonosítóját és csak azt! (who, cut)  
4.  Listázzuk ki egy tetszőleges szöveges fájl sorait abc sorba rendezve!  
5.  Cseréljük ki egy fájlban lévő karaktereket a nagybetűs párjukra!  
6.  Számoljuk meg, hogy egy fájlban hány olyan sor van, amelyik az alma szót tartalmazza és semmi mást! (tr, grep ^alma$, wc)  
7.  Csak az egészeket tartalmazó sorokat engedje át a szűrő (grep ^[\+-]?[1-9][0-9]*$)  

## 5Sh  
### 1. Shell script parancsfájlok:  
    a. Parancsfájl készítés  
        i. Szöveges fájl, x jog, chmod parancs  
        ii. # megjegyzés  
        iii. egy sorba több parancs is írható, a ; az elválasztó  
        iv. echo almafa; echo alatt # ez az első program (echo –n)  
    b. Parancsfájl futtatás  
        i. ./parancsnév  
        ii. bash parancsnév  
        iii. Script első sora gyakran ilyen: #!/bin/sh  
            1. Jelentés: Ki értelmezze a fájlt.  
    c. .profile állomány  
        i. Belépéskor lefut. Alapból ezen a gépen nincs.  
        ii. Feladat: Készíts magadnak egy .profile állományt, ami üdvözöl belépéskor!  

### 2. Változók, paraméterek, beolvasás (read):  
    a. Környezeti változók, env parancs  
        i. PS1 változó, prompt értéke, bash-ban, \u= usernév, \h=hostnév  
            1. PS2, másodlagos prompt  
        ii. Egy változó értéke: $név  
        iii. PATH változó  
            1. Feladat: Bővítsük a PATH változót a . könyvtárral! (PATH=$PATH:. ) Miért a .profile állományba írjuk a módosítást?  
    b. Összes változó, set parancs  
        i. Saját változó definiálás: n=alma  
        ii. Shellben látjuk, de scriptben nem. export n , ettől n környezeti változó lesz, látszik scriptben.  
        iii. Változó megszüntetése: unset n   
    c. Script paraméterek  
        i. $0 parancs neve, $1 első, $2, ...$9 kilencedik paraméter  
            1. Feladat: állapítsuk meg, mi a shell program neve, amiben éppen dolgozunk, illetve milyen paraméterekkel van indítva.  
        ii. $# paraméterek száma  
        iii. $* összes paraméter  
    d. Feladat: Írjon shell parancsot ami kiíja a paramétereinek számát és az összes paramétert!  
    e. Feladat: Írjon shell parancsot, ami a paraméter értékénél eggyel nagyobbat ad meg! Írja ki a paraméter kétszeresét is! expr   
    f. Feladat: Írjunk shell parancsot, ami bekéri a hallgató nevét, és életkorát, majd megjeleníti azt!  

### 3. Szűrők, csövek (pipe):  
    a. Parancs kimenet egy másik parancs bemeneteként jelenik meg: | jel  
        i. more, head, tail, sort parancs: cat nagyfile|more 
            i. Feladat: Írjunk parancsot, ami rendezve kiírja egy fájl első és utolsó n sorát. n legyen paraméter!  
        ii. wc parancs, példa: cat .profile|wc   
            i. Feladat: mondjuk meg, hány bejegyzés van a könyvtárunkban!  
        iii. cut parancs  
            i. Feladat: Írjunk shell programot, ami az első és utolsó paramétert kiírja, majd összeadja őket! (utolsó=`echo $*|cut –f$# -d” ”`)  
            ii. Feladat Kérdezzük le a rendszer összes felhasználójának adatait a getent passwd parancs segítségével és tegyük bele felhasznalok.txt állományba, hány felhasználóról kapunk információt?  
        iv. grep parancs  
            i. Feladat: Határozzuk meg, hogy hány z betűvel kezdődő felhasználó van bejelentkezve! (who|grep ^i|wc -l)  
            ii. Feladat: Írjuk bele a torolt_felhasznalok.txt állományba a rendszerből ideiglenesen törölt felhasználók nevét!  
            Segítség: az ideiglenesen törölt felhasználók a 666-os felhasználó-azonosítót kapják. (grep ':666:' < felhasznalok.txt | cut -f1 -d: > torolt_felhasznalok.txt)  

### 4. Input-Output átirányítás  
    a. > output átirányítás  
        i. Feladat: Mit jelent: echo alma >&2 ? (Kimenet, a hibakimenetre megy.)  
        ii. Feladat: Irányítsuk a kimenetet a ’feneketlen kukába’! (echo kukába >/dev/null )  
    b. >> hozzáfűzés  
    c. < input átirányítás  
    d. << here input  
        i. Feladat: Mit jelent?  
            cat <<alma  
            <title> Shell script 1. </title>  
            <body>  Programjaim: </body>  
            </html>  
            alma  
            (cat paramétere lesz a cat <<alma, alma közti sorok)  
    e. 2> hiba kimenet átirányítás („2>&1” a hiba kimenet és az egyszerű kimenet összefűzése, kukába a hibával: 2>/dev/null)  

## 6Sh  
### Elágazások, ciklusok
### 1. Ismétlés, aritmetikai műveletek  
    a. expr utasítás, használati forma: expr kif1 op kif2, az operandus alapműveleti jel lehet: +,-,*,/, %(mod),<,>,<=,>=, = (egyenlő), !=(nemegyenlő), figyeljünk a paraméterek közti kötelező helyközre!  
        i. Példa: a=expr 2 + 3 #hiba, mert ez egy értékadás!  
        ii. Helyesen: a=`expr 2 + 3`; echo $a # 5  
        iii. A *, / stb. speciális jelentéssel is bírnak, ezért ilyenkor használni kell a \ karaktert: expr 3 \* 4  
        iv. Feladat: Egy fájlban tárolunk egy számot. Növeljük egyel az értékét! (n=`cat file`; expr $n + 1>file )  
    b. Beolvasás, read utasítás  
        i. Feladat: Írjon masol névre hallgató programot, ami felhasználói felületet ad a cp (copy) parancshoz! (Bekérjük read-del a másolandó és a célfájl nevét.)   
    c. Minta keresés, grep.  
        i. Feladat: Írjunk scriptet, aminek segítségével keressük meg azokat a fájlokat egy könyvtárban és az alkönyvtáraiban, amikben a paraméterül adott szó megtalálható. (grep –l –r $1 $2 $1 a szó, $2 a könyvtár)   
        ii. Feladat: Válasszuk ki azokat a sorokat egy fájlból, amelyek a bor szót önállóan tartalmazzák! Legyen a szó paraméterként megadható! (cat file| grep –w bor )   
    d. Csere, tr parancs  
        i. Feladat: Cseréljük ki egy szó betűit csupa nagybetűkre! (echo $szo|tr [a-z] [A-Z])  

### 2. Elágazások  
    a. test utasítás, logikai értékkel tér vissza, használata: test kif1 op kif2, vagy  [ kif1 op kif2 ]  
        i. Számok összehasonlítása (-lt, -gt, -le, -ge, -eq, -ne)  
            1. Feladat: Döntsük el, hogy egy szám nagyobb-e mint 10?  
            (test 6 –gt 10; echo $?)  
        ii. Szövegek összehasonlítása ( =, !=)  
            1. Feladat: Egy a változóba írjunk be egy szót. Döntsük el, hogy ez a fradi volt-e?  
        iii. Összetett kifejezés (-o, vagy, -a és)  
            1. Feladat: Döntsük el, hogy egy szám 0 és 5 között van-e?  
    b. if utasítás  
        i. Feladat: Olvassunk be egy számot, írjuk ki válaszként, hogy 10-nél nagyobb, kisebb vagy egyenlő-e a beolvasott szám!  
        ii. Feladat: Írj scriptet, ami kiírja, hogy délelőtt vagy délután vagy este van-e?  
        iii. Feladat (opcionálisan): Módosítsd a .profile állományt ami a napszaknak megfelelően köszönt!  
    c. case elágazás  
        i. Feladat: Írjunk futtat parancsot, ami a paraméterektől függően más és más programot futtat! Ha –d a paraméter, akkor futtassuk a date parancsot, ha –w akkor írjuk ki a bejelentkezett felhasználók nevét, ha –l akkor a könyvtár tartalmát írja ki! Ha nem egy paraméterrel, vagy rossz paraméterrel futtatjuk a programot, írjon ki mini segítséget!  

### 3. Ciklusok: 
    a. for ciklus 
        i. Feladat: Írjuk 5-ször a képernyőre: Hajrá Fradi! 
        ii. Feladat: Írjunk programot, ami kiírja a bejelentkezett felhasználókat! (Figyeljünk a többszörös bejelentkezésre!) 
        (for i in `who|cut –f1 –d” ”|sort -u`  
        do 
          echo $i bejelentkezett! 
        done) 
    b. while ciklus 
        i. Feladat: Oldjuk meg a for első feladatát while ciklus segítségével! 
        ii. Feladat: Olvassunk be egymás után 5 számot és adjuk össze őket! 
    c. until ciklus 
        i. Feladat: Oldjuk meg a for első feladatát until ciklus segítségével! 
        ii. Feladat: Írjon menürendszerű programot until segítségével! Ha az 1 számot választjuk, akkor meghívjuk a bejelentkezett felhasználókat kiíró programunkat, ha a 2-es számot választjuk, akkor meghívjuk az 5 számot összeadó programunkat, ha a 3 számot adjuk meg, akkor kilépünk a programból! 
```sh
#!/bin/sh 
# Menu untillal 
# 
# 
until 
 clear 
 echo 
 echo Válasszon programot! 
 echo 
 echo 1 Bejelentkezett felhasználók 
 echo 2 5 szám összeadása 
 echo 3 Vége 
 echo 
 echo -n Adja meg a megfelelő számot: 
 read szam 
 [ $szam -eq 3 ] 
do 
  case $szam in 
   1)  echo Most csinálom az elsőt 
       ;; 
   2)  echo Ez a masik. 
       ;; 
   *)  echo Rossz opciót adott meg! 
       ;; 
  esac 
  sleep 5 
 done 
echo Örültem, hogy engem választott!
```

## 7Sh  
### I/O átirányítás, szűrők, csövek,: wc, grep, sort, cut, tee, sed, reguláris kifejezések  
### **Ismétlés, scriptek, szerkezetek**  
a) Feladat: Írjunk shell script programot, ami kiszámolja egy szám (n) faktoriálisát! (Pl. while ciklus, i 2-től n-ig, majd a ciklusmagban f=`expr $f \* $i`. A feladatmegoldásoknál ne használjunk let utasítást, elég használni, megtanulni az expr-t, és használjuk a normál parancsbehelyettesítést! `  parancs `) Ellenőrizzük, hogy kaptunk-e paramétert!  
b) Feladat: Írjunk script programot, ami szavakat olvas be egészen addig, míg a vége szót nem írjuk be, majd sorba rendezve kiírja a képernyőre azokat! (Használjunk ideiglenes fájlt!)  
c) Feladat: Írjunk programot, amelyik a paraméterül kapott számokat összeadja és az összeget a szabványos kimenetre írja! A program maximum 10 számot tudjon összeadni! A paraméterül megadott számok helyett megadhatjuk a –help kapcsolót, aminek hatására írjunk ki rövid ismertetőt a programról!  
d) Feladat: Írjunk programot, ami szétválogat egy paraméterben megadott fájlt páros és páratlan sorokra, majd ezeket új fájlokban elhelyezi! (dióhéjban: counter=0; while read line; do if [ $( expr $counter % 2) ]; echo $line > file_even; else echo $line > file_odd; fi; (( counter ++ )); done < bemeneti_file) vagy (cat file | while ...)   
e) Feladat: Írjunk shell script programot, ami a háttérben fut és fél percenként ellenőrzi, hogy egy felhasználó bejelentkezett-e a rendszerbe! A felhasználó nevét paraméterként kell megadni!   
f) Feladat: Jelentkezzünk be egyszerre két terminálon. Ha az egyik ablakban elindítjuk az uzenet nevű most megírandó script programot, akkor az egy percen keresztül 5 másodpercenként írjon egy üzenetet a másik terminálablakunkba! (Megoldás kulcsa: echo üzenet >/dev/pts/2, ha pts/2 a másik terminál azonosítója, vagy használjuk a 'write <felhasznalonev>' parancsot)   

### **Szűrők:**  
    a) Feladat: Telefonregiszter program, amely kapcsolók segítségével a következőket tudja: -a kapcsoló megadása esetén felvesz egy nevet és egy telefonszámot a listába (ügyeljünk a dupla elemekre), -d kapcsoló megadása esetén törölje a paraméterként megadott nevet és a hozzá tartozó telefonszámot, kapcsoló nélkül pedig keresse meg az illeszkedő neveket és írja ki hozzá a telefonszámokat. A –c kapcsolóra adja meg a regiszterben tárolt telefonszámok darabszámát. Az –o kapcsolóra rendezve írja ki a neveket – egyszeresen. (A tároláshoz használt szövegfájl formája szabadon meghatározható, segítségképp: a vesszővel vagy kettősponttal elválasztott mezők használata javasolt)  
    b) Feladat: Módosítsuk az 1/a (faktoriális számoló programot) úgy, hogy szűrőként is tudjuk használni! (Ha nincs paraméter, n= `cat`....)  
    c) Feladat: Módosítsuk az 1/c (paraméterek összeadását végző programot) úgy, hogy szűrőként is tudjuk használni! (Ha nincs paraméter, for i in `cat`....)  
    d) Feladat: Írjunk programot, ami a paraméterben megadott fájlokat átnevezi csupa kisbetűsre! (segítség: echo $*|tr '[A-Z]' '[a-z]')  
    e) Feladat: Bővítsük az előző programot úgy, hogy kapcsolóval megadható legyen, hogy kisbetűsíteni vagy nagybetűsíteni akarunk!  
    f) Feladat: Írjunk programot, ami egy paraméterben megadott állományban az összes elkódolt email címből valódit készít, majd azokat listázza a kimeneten. Egyúttal kerüljenek ki egy fájlba is az eredmények. (tee) Elkódolt email címek például (minden esetben gipsz@jakab.hu cím az eredeti): gipsz kukac jakab pont hu, gipsz at jakab dot hu, gipsz_nospam_jakab.hu, stb.  

## 8Sh  
### Reguláris kifejezések, soron belüli mintaillesztés (grep), soron belüli csere (sed) esetleg awk – gyakorlás a korábbi órákon fel nem dolgozott feladatokkal.  
### Reguláris kifejezések, grep, sed, awk  
1. Feladat: Készítsünk scriptet, amelyik a paraméterében megadott fájlból a csak számokat tartalmazó sorokat írja ki! (valós számokra is gondoljunk)  
2. Feladat: Készítsünk scriptet, amelyik megszámolja, hogy hány csak karaktereket tartalmazó sor van a fileban! Megoldások: s=0; while read ...< file  vagy grep –c ...   
3. Feladat: Készítsünk scriptet, amelyik egy adott szót (paraméterként megadott) tartalmazó sorokat nem másolja át egy másik fájlba! grep –v     
4. Feladat: Készítsünk scriptet, amelyik a paraméterében megadott fájlból a csak azokat a sorokat írja ki, amelyikben sem az alma sem a korte szó nem szerepel megadott szó sem szerepel!  cat file | grep –v „[alma\|korte]” vagy  cat file | sed „/alma\|korte/d” vagy cat file | awk ’$1 !~ /alma|korte/ {print $1}’   
5. Feladat: Cseréljük ki egy fájlban szereplő minden adott szót (paraméterben) egy másikra! sed „s/$1/$2/”   
6. Feladat: Egy fájlban kétjegyű számok vannak – írjuk ki fordított sorrendben a számjegyeket! sed "s/\([0-9]\)\([0-9]\)/\2\1/"   
7. Feladat: Egy fájlban soronként két szó van. Cseréljük meg a szavak sorrendjét a sorokban! cat file |sed „s/\([a-zA-Z]\+\)\( \+\)\([a-zA-Z\)/\3\2\1/”  vagy  cat file | awk ’{print $2,$1}’   
8. Feladat: Egy fájlban számokat találunk soronként egyet-egyet. Adjuk össze ezeket! Megoldás while read .... < file vagy cat file | awk ’BEGIN {s=0} {s+=$1} END{print s}’   
9. Feladat: Egy fájlban számokat és szövegeket tárolunk vegyesen. A nemcsak számokat tartalmazó sorokat másoljuk át egy új fájlba! Megoldások: grep –v  regkif vagy  awk ’$1 !~ /regkif/  {print $1}’    
10. Feladat: Írjunk programot, ami beolvas egy számot a bemenetről, majd kiírja azt fordítva! (dióhéjban: while [ $szam -gt 0]do $aktualis=$(( $szam % 10 )); $szam=$(( $szam / 10 )); forditva=$( echo ${forditva}${aktualis}); done) Az alábbi megoldás nem használja a let utasítást, helyette expr-t használ, és normál parancsbehelyettesítést használ (` parancs`).   
```sh
#!/bin/sh 
# 
echo -n Irjon be egyszamot: 
read szam 
forditva="" 
while 
 [ $szam -gt 0 ] 
 do 
   akt=`expr $szam \% 10` 
# echo $akt 
   szam=`expr $szam \/ 10` 
# echo $szam 
   forditva=`echo "${forditva}$akt"` 
 done 
echo -n A forditott szamsorrend: 
echo $forditva 
```  

11. Feladat: Írjunk programot, ami beolvas egy számot a bemenetről, majd kiírja a számjegyek összegét! (hasonló az előzőhöz, csak összegezni kell az értékeket)   
12. Feladat (sok-sok extra pontért): Írjunk programot, ami megfordítja soronként a paraméterben megadott fájl tartalmát! (segítség: átmeneti tárolásra egy tömböt használjunk)   