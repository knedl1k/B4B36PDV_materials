#import "../../template/info-boxes.typ": *
= Úvod



== Motivace
_Proč chceme paralelizovat?_

Podívejme se na následující obrázek:
#figure(
  image("../../assets/images/50-years-processor-trend.png"),
  caption: [@rupp_trend],
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
  "Vytvořme si nový procesor se 4 jádry, kde každé jádro bude mít poloviční výkon oproti našemu původnímu procesoru s 1 jádrem. Jaký bude mít náš nový procesor teoretický výkon? Kolik spotřebuje tento nový procesor energie?",
  kind:"question",footer:"Bude mít zhruba dvojnásobný výkon a stejnou spotřebu.")