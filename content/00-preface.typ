#import "../template/info-boxes.typ": *
#import "../template/template.typ": *

#heading(level: 1, numbering: none)[Předmluva]

#h(1.5em) Budeme rádi, pokud nám zašlete své podněty, úpravy anebo připomínky k textu. Velmi oceníme 
konstruktivní kritiku a nápady na změny. Dejte nám také prosím vědět, pokud v textu objevíte překlepy, chyby faktické i
typografické, a jiné.

*Poděkování.* Text je vysázen v jazyce #link("https://github.com/typst/typst")[Typst] Martina Hauga a Laurenze Mädje.

#heading(level: 2, numbering: none)[Stručné informace o textu]
V textu se objevuje několik různých elementů, které pomáhají s jeho čitelností, čtivostí a přínosností. 

Všechny #text(fill: rgb("#85144b"), [fialové texty]) jsou hypertextové odkazy, které vedou na externí zdroje.

Zároveň se v textu objevují barevné obdelníky, v různých provedeních. Ty neslouží jako shrnutí daného textu, ale pro
zamyšlení, zvážení a zpřehlednění tématu.

#info-box(
  [Tímto způsobem upozorňujeme na důležitou informaci.], kind:"info"
)

#info-box(
  [Zde nabádáme čtenáře k zamyšlení a procvičení.], kind:"question"
)

#info-box(
  [Takto označujeme závěr myšlenky, _heureku_.], kind:"conclusion"
)
