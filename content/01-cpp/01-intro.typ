#import "../../template/info-boxes.typ": *
#import "../../template/template.typ": *

// #import "@preview/lilaq:0.4.0" as lq
= Úvod



== Motivace
_Proč chceme paralelizovat?_

Podívejme se na následující graf:
#figure(
  image("../../assets/images/50-years-processor-trend.png"),
  caption: [Vývoj různých vlastností mikroprocesorů od roku 1970 do 2021 @rupp_trend.],
)
Zaměřme se nejdříve na rok 2000. Máme pouze jedno jádro a každým rokem se přibližně $2 times$ zvyšuje jeho výpočetní 
výkon. Výhody paralelního přístupu nebyly tak zřejmé; přeci jen, stačilo si počkat pár let pro ohromný nárost výkonu. 

Všimněme si, že po roce 2000 se ale lineární nárůst frekvence jádra zpomaluje. Jednojádrový výkon i po roce 2000 rostl 
spíše díky architektonickým trikům:
- *Delší pipeline* - více kroků zpracování instrukce umožňuje zrychlit takt jednotlivých fází.
- *Širší datové cesty* - více bitů zpracovaných najednou (dnes 64 bitů, dříve 16 a 32 bitů) znamená, že procesor přenese a zpracuje více dat na cyklus.
- *Paralelismus uvnitř pipeline* - několik výpočetních jednotek vedle sebe v jednom jádru, na které se snažíme inteligentně rozložit instrukce.

Tedy znatelného nárustu výkonu nedocílíme pouhým čekáním, ale je potřeba dělat složité a drahé postupy. Navíc se nám 
postupně zvyšuje příkon samotného procesoru. Tím pádem se nám začíná objevovat problém nejen se zvyšujícími se 
provozními náklady, ale i nutností procesory chladit.

Narážíme na fyzikální limity procesorů a je potřeba začít vymýšlet, jak jinak zrychlit výpočty. Nabízí se naprosto 
triviální úvaha: prostě spojme více jader na jednom chipsetu. Dejme jim sdílenou paměť a nechme je pracovat paralelně.

#info-box(
  [Vytvořme si nový procesor se 4 jádry, kde každé jádro bude mít poloviční výkon oproti našemu původnímu procesoru s 1 
  jádrem. Jaký bude mít náš nový procesor teoretický výkon? Kolik spotřebuje tento nový procesor energie?],
  kind:"question",footer:[Bude mít zhruba dvojnásobný výkon a stejnou spotřebu.])

To vypadá jako velmi výhodný přístup. I díky zmenšování velikosti tranzistorů 
#footnote[https://en.wikipedia.org/wiki/Moores_law] dává smysl využít nově získané místo na čipu k přidání dalších 
funkčních bloků.

Přístup navyšování počtu jader si můžeme všimat i v dnešní době, kdy lze grafické karty považovat za hloupé procesory s
velkým množstvím výpočetních jednotek a jednoduchou kontrolní částí.

//? TODO: konkrétní příklady s notebooky (Mac, Surface); 15 min 1. přednáška

Postupem času si začínáme taky všímat výhody dávat jádrům jejich účel - například Tensor jádra v grafických kartách, 
výkonostní a efektivní jádra v procesorech... Výhodou takového přístupu je efektivita. Dokážeme delegovat specifické 
požadavky na jádra, která jsou na dané výpočty určená. Ušetříme tím energii a zvýšíme výkon. Příkladem v moderní době
jsou mobilní telefony. Skládají se z mnoha koprocesorů, kde každý má svoje specifické použití. Jeden z nich slouží
na Machine Learning, druhý obstarává 5G datové připojení, třetí slouží jako grafická vykreslovací jednotka a další. Když
uživatel vypne datové připojení, celá jednotka obstarávající 5G připojení, spolu s příslušným koprocesorem, se 
deaktivuje a zbytečně nespotřebovává energii.

Další možností, jak zvýšit jednojádrový výkon, by mohlo být využití efektivnějších kompilátorů. Logika je jasná: pokud
program přeložíme úsporněji, poběží rychleji — a tím se výkon zvýší. To platí když tímto způsobem chceme optimalizovat 
běh na jednom jádře. Kdybychom ale tento požadavek vznesli na vícejádrovou aplikaci, zjistíme, že žádný produkční 
compiler neumí pracovat s více jádry. Compiler sám o sobě neví kdy a co, případně jak, paralelizovat. Tuto práci musí
stále zajistit člověk.

S tímto nám mohou pomoci různé specializované knihovny, které metody paralelismu již v sobě mají zakomponované. 
Například pro práci s maticemi máme v Pythonu NumPy, pro operace lineární algebry zas třeba SciPy. Nevýhodou tohoto 
přístupu je, že funguje jen se specifickými operacemi. Další velkou nevýhodou je, že tyto knihovny jsou často blackbox,
u kterého nemáme možnost ovlivnit, kolik vláken si výpočet vytvoří.

#info-box(
  [Mějme procesor s $n$ jádry. Když při běhu programu vytvoříme $n$ vláken, kde každé z nich zavolá třeba násobení matic 
  v NumPy, které si také vytvoří $n$ vláken, vznikne celkově $n^2$ vláken.]
)

Zde už cítíme, že procesor bude nejspíše velmi saturovaný a proces se nám nezrychlí, ba se dokonce může zpomalit. Je 
očividné, že musíme tedy inteligentně paralelisovat na správných místech, aby se nevytvářel zbytečný overhead.
#pagebreak()
== Jak paralelizovat?
Ukažme si jak paralelizovat součet mnoha prvků:
#codeblock("../assets/code/cpp/01/demo-vector-exp/src/main.cpp")
Vyrobme vektor #footnote([https://en.cppreference.com/w/cpp/container/vector.html]) s mnoha prvky. A pro každý z nich 
chceme spočítat $e^i$, $i in$ `vec`; nejdříve sekvenčně a po té paralelně.

U paralelního přístupu se před hlavičkou `for`-loopu objevila deklarace
```cpp
#pragma omp parallel for
```
Tou se snažíme použít knihovnu OpenMP, tak, abychom `for` vykonávali paralelně na všech jádrech, která máme k dispozici.

Když daný kód spustíme (`assets/code/cpp/01`), dostaneme na 4 jádrech zhruba tento výsledek:
```
  Sum vector (scalar): 99.17 ms  (speedup: 1.00x, 10 iterations) 
Sum vecotr (parallel): 25.85 ms  (speedup: 3.84x, 10 iterations)
```
Jedním řádkem jsme docílili skoro $4 times$ zrychlení pouze tím, že jsme pro výpočet použili více jader. 

== Amdahlův zákon
$
S = 1/(s + (1-s)/P),
$
kde $S$ je očekávaný speedup(zrychlení), $s$ podíl sekvenční části a $P$ počet jader.

Když $s$ bude 0.5, znamená to, že $50%$ kódu nelze paralelizovat a zbytek paralelizovat jde.

Rychlost paralelního výpočtu se *neškáluje* "čím více jader, tím rychlejší výpočet". Když budeme chtít sečíst 
posloupnost čísel, jedno z vláken bude muset řídit tento součet a spojit mezisoučty. Tím nám vzniká neefektivita při 
čekání na mezisoučty jednotlivých vláken a při managementu vláken.

#link("https://www.desmos.com/calculator/7hday0d3ne")[Vymodelujme si] jak se tato křivka chová. Na ose x máme počet 
jader, na y je speedup. Zaměrme se na 4 jádra, dostáváme $3 times$ speedup. Když máme 8 jader, tak $4,7 times$ speedup. 
Při $96$, dostaneme $9,1 times$ speedup. To je už poměrně nevýhodné, že? A tyto všechny hodnoty máme za předpokladu, že 
máme pouhých $10 %$ sekvenční části. Pokud bychom dělali nějak organizačně náročnější výpočet, speedup by byl ještě 
mnohem menší.

Povšimněme si také, že malé změny poměru sekvenční části dělají velké změny speedupu. Ale i při $1 %$ sekvenční části se 
s 96 jádry dostáváme zhruba na $49 times$ zrychlení.

#info-box(
  [Při tvorbě algoritmů je důležité minimalizovat sekvenční část --- režii. Čím menší bude, tím mohutnějšího zrychlení 
  dosáhneme. Zároveň nemůžeme očekávat, že při 96 jádrech dosáhneme $96 times$ zrychlení.], kind:"conclusion"
)

Toto všechno počítá pouze s CPU-bound problémy. Tedy, že nejsme blokováni ničím jiným, jen samotnou výpočetní 
rychlostí procesoru. V reálném světě se setkáváme i s I/O-bound problémy, kde se například čeká na komunikaci s jiným
počítačem na síti, případně se čeká na disk a jiné periférie.

Princip paralelismu, známý z vícejádrových procesorů, se dnes efektivně uplatňuje i u I/O-bound úloh, aby se 
minimalizovaly prostoje způsobené čekáním. Operační systém může posílat I/O požadavky (čtení/zápis) do několika front 
současně. Interní řadič SSD disku si pak může tyto požadavky inteligentně vyzvedávat a zpracovávat je paralelně. 

== Opakování CPU architektury
Mějme sekvenční příklad násobení matice s vektorem.
```c
float x[SIZE];
float y[SIZE];
float A[SIZE * SIZE];

// VERSION 1
for (size_t i = 0; i < SIZE; ++i)
    for (size_t j = 0; j < SIZE; ++j)
        y[i] += A[i * SIZE + j] * x[j];

// VERSION 2
for (size_t j = 0; j < SIZE; ++j)
    for (size_t i = 0; i < SIZE; ++i)
        y[i] += A[i * SIZE + j] * x[j];
```
Která z verzí bude rychlejší?

Z pohledu procesorové cache je RAM na většině x86-64 procesorů série 64 bajtových bloků. Na Apple ARM čipech je 128 
bajtových. Cache v takovém případě nikdy neadresuje nic menšího. Cache je mnohem rychlejší jak RAM, proto je v našem 
zájmu co nejefektivněji využít hodnoty načtené v ní. V 1. verzi procházíme postupně čísla tak, jak jsou za sebou v RAM 
uložená. Ve 2. verzi naopak přistupujeme k datům na přeskáčku --- tedy do cache se neustále musí loadovat další a další 
bloky paměti. 

1\. verze bude rychlejší. 
// TODO: dodělat celou sekci, 1:09:00
#figure(
    image("../../assets/images/cache_diagram.svg", width:100%),
    caption: [Zjednodušený nákres CPU],
)

Když pro data půjdeme přímo do registrů, potrvá to 0-1 cyklus. Když data budeme načítat z L1 paměti, pohybujeme se 1-4 
cykly. U L2 paměti nízké desítky, zhruba 7-20 cyklů. U L3 řekněme 40 cyklů procesoru. A finálně u RAM to potrvá zhruba 
400 cyklů. Tedy pokud pro data půjdeme až do RAM, prakticky jsme prohráli a nedocílíme velkého zrychlení.

// Hardwarová vlákna (MIMD)
// Multiple Instruction, Multiple Data. Což znamená, že máme možnost vykonávat různé instrukce na jednotlivých jádrech 
// procesoru s různými daty.

// SIMD
// Single Instruction, Multiple Data. 

Proč je pro nás architektura procesoru důležitá? Mějme příklad:
```cpp
float array[SIZE];
float sum = 0.0f;

// rozděl části for loopy
// mezi několik vláken
#pragma omp parallel for
for (size_t i = 0; i < SIZE; ++i){
    sum += array[i];
}
```
Na první pohled to vypadá jako drobná nepříjemnost. Stačí přece přidat zámek nebo použít atomickou operaci a problém 
zmizí. Jenže v realitě jde o architektonický úzký profil. Každá jádrová cache uchovává kopii příslušných dat. Pokud dvě 
různá jádra upravují stejnou cache line (tedy fyzický blok paměti, typicky 64 bajtů), musejí si neustále posílat zprávy 
přes tzv. cache coherence protokol (MESI, MOESI aj.). \
To znamená:
- Vlákno A změní `sum` $->$ označí svou cache line jako modifikovanou.
- Vlákno B chce `sum` přečíst nebo změnit $->$ jeho cache kopie se invaliduje a musí se načíst nová verze.
Tento ping-pong probíhá při každém zápisu, takže efektivně všechna vlákna čekají na to, až si navzájem předají data.
I když máme N vláken, celá smyčka se fakticky provádí _sekvenčně_ skrz bottleneck sdílené proměnné.

#info-box([Jedná se o tzv. true sharing --- více vláken aktivně čte a _zapisuje_ stejnou proměnnou.])

Pokusme se tedy problém vyřešit:
```cpp
float array[SIZE];
float sum[THREAD_COUNT] = {0.0f};

// rozděl části for loopy
// mezi několik vláken
#pragma omp parallel for
for (size_t i = 0; i < SIZE; ++i){
    sums[THREAD_ID] += array[i];
}
```
Zde jsme eliminovali nutnost zámků, protože vlákna si teoreticky nepřekážejí. Co problém s bottleneckem?

Problém je, že CPU cache nepracuje s jednotlivými `float` proměnnými, ale s celými bloky, cache lines, obvykle 64 bajtů 
velkými. `float` má velikost 4 bajty, takže na jednu cache line se vejde 16 `float` hodnot. Pokud máme 8 vláken a pole 
`sum` je uloženo sekvenčně v paměti, je vysoce pravděpodobné, že několik vláken zapisuje do různých prvků, které ale 
leží na té *samé cache line*. A co se stane? To samé, co v prvním případě:
- Vlákno A změní svůj prvek $->$ invaliduje celou cache line u všech ostatních jader.
- Vlákno B změní _jiný_ prvek na stejné cache line $->$ invaliduje ji zpět.

#info-box([Tento efekt se nazývá false sharing --- více vláken zapisuje do různých proměnných, které ale fyzicky leží 
na stejné cache line. Data jsou logicky oddělená, ale fyzicky sdílená na úrovni cache. I když invalidace není logicky 
potřebná, je nutná kvůli rozložení dat v paměti.])

== Další zdroje
- https://www.cs.cmu.edu/~15418/schedule.html. Kurz z Carnegie Mellon University s podobnými tématy, zpracovaný více do hloubky.
- https://www.youtube.com/watch?v=eanvgGt-D1o. Stará nahrávka první přednášky výše uvedeného kurzu.
- https://curiouscoding.nl/posts/cpu-benchmarks/. Benchmarky CPU cache odezvy.
- http://gotw.ca/publications/concurrency-ddj.htm. "The Free Lunch Is Over" od Herba Suttera. Článek vysvětlující proč je paralelismus dnes odpovědí na otázku zvyšeování výkonu.