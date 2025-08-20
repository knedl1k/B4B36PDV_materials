#import "../template/info-boxes.typ": *
#import "../template/template.typ": *

#heading(level: 1, numbering: none)[Předmluva]

Předmět paralelních a distribuovaných výpočtů se na FEL ČVUT vyučoval v mnoha různých iteracích a variantách. 
Tento text vznikl jako snaha všechny důležité informace sjednotit na jednom místě, aby studenti předmětu, ale i zbytek 
veřejnosti, měl v rukách ucelený text, který je provede nejen motivacemi a úplnými základy použitých metod a strategií, 
ale dá jim především praktické znalosti.

Přese vše je nutné dodat, že je text především cílen pro studující, kteří již absolvovali předměty 
Architektura počítačů, Operační systémy a Algoritmizace. Bez těchto znalostí je stále možné náš text pochopit, velmi ale 
doporučujeme prerekvzity doplnit.

Budeme rádi, pokud nám zašlete své podněty, úpravy anebo připomínky k textu. Velmi oceníme 
konstruktivní kritiku a nápady na změny. Dejte nám také prosím vědět, pokud v textu objevíte překlepy, chyby faktické i
typografické, a jiné.

#h(1.5em) *Poděkování.* Text je vysázen v jazyce #link("https://github.com/typst/typst")[Typst] Martina Hauga a Laurenze 
Mädje.

#heading(level: 2, numbering: none)[Stručné informace o textu]
V textu se objevuje několik různých elementů, které pomáhají s jeho čitelností, čtivostí a přínosností. 

Všechny #link("https://example.org/")[fialové texty] jsou hypertextové odkazy, které vedou na externí zdroje. Taky 
využíváme poznámek pod čarou#footnote([vypadají takto]), které často odkazují na další bonusové zdroje a informace.

Zároveň se v textu objevují barevné obdelníky, v různých provedeních. Ty neslouží jako shrnutí daného textu, ale pro
zamyšlení, zvážení a zpřehlednění tématu.

#info-box(
  [Tímto způsobem poukazujeme na / doplňujeme důležitou informaci.], kind:"info"
)

#info-box(
  [Zde nabádáme čtenáře k zamyšlení a procvičení.], footer:[Zde je odpověď na otázku.], kind:"question"
)

#info-box(
  [Takto označujeme závěr myšlenky, _heureku_.], kind:"conclusion"
)
