#import "../../template/info-boxes.typ": *
#import "../../template/template.typ": *

= Multithreading v C++

== Základy C++
C++ je rozšířením jazyka C, dodnes je z velké části kompatibilní s C knihovnami. Nabízí vyšší úroveň abstrakce, 
například třídy či generické programování, ale zároveň zůstává blízko hardwaru a podporuje vysoce výkonné aplikace.
Hlavní filozofií je poskytovat tzv. zero-cost abstractions; tedy konstrukce, které nepřidávají výkonovou režii oproti
ekvivalentnímu kódu v C.

Ukažme si různé praktické příklady vlastností C++:
#codeblock("../assets/code/cpp/02/examples/src/1cpp_intro/main.cpp")
Jak bylo naznačeno, skvělým způsobem, jak začít s programováním C++, je psát běžnou C syntaxi. 

První novinkou C++ je, že si nemusíme pamatovat tvar formátovacích specifikátorů (tj. např. `%f`) pří vstupu/výstupu.
```cpp
#include <iostream>

int main(){
  std::cout << "Hello world from C++" << 20 << ".\n"; 
}
```
Postupně a polopatě se zaměřme na syntaxi.
- C++ standardní knihovny nemají příponu `.h`; jedná se o designovou volbu tvůrců jazyka. 
- Dále se nám objevuje `std::cout`, to je takzvaný stream #footnote([https://en.cppreference.com/w/cpp/io/c/std_streams]) standardního výstupu. Stream je něco, do čeho budeme vkládat data a ony se budou někam ukládat. Buď do souboru, nebo na standardní výstup, například. 
- `<<` operátor intuitivně naznačuje, že "vezme hodnotu zprava a dá ji vlevo".
- V tomto konkrétním případě se snažíme vypsat string následovaný integerem. Aniž bychom použili formátovací specifikátor toho můžeme dosáhnout prostě tak, že jednotlivé datové typy oddělíme `<<`. 
- No a konečně, `std::`. Jedná se o takzvaný namespace, podobně jako v Javě. `std` jako standard.
Vlastní namespace můžeme vytvořit například takto:
```cpp
namespace pdv{
  void my_fn(){}
}

int main(){
  pdv::my_fn();
}
```
Využití je na snadě --- můžeme mít několik stejně pojmenovaných funkcí.

Podívejme se na další příklady:
```cpp
#include <iostream>

int main(){
  auto cpp_version = 20;
  std::cout << "Hello world from C++" << cpp_version << ".\n";
}
```
Zde se nám objevuje klíčové slovo `auto`. Má stejnou funkcionalitu jako `var` v Javě --- kompilátor při sestavování 
programu rozhodne, pokud má dostatečný kontext, jaký datový typ přidělit proměnné. Můžeme si tím usnadnit život třeba
u `for`-each smyček, případně obecně kdykoliv by měl být datový typ dlouhý a my byli líní. 
=== OOP
Podívejme se na objektové programování:
```cpp
class X{
  uint32_t _member; //private

public: // vše v této sekci bude public
  X(uint32_t member) : _member(member){} // konstruktor 

  uint32_t member(){ // getter
    return _member;
  }

  uint32_t member(uint32_t new_value){ // setter
    return _member = new_value;
  } 
}; // nezapomínejte na ;

int main(){
  auto x = X(10);
  std::cout << "member = " << x.member() << "\n";
}
```
U tříd v C++ platí, že vše je v základním stavu `private`. Na pořadí labelů (`public`, `private`...) nezáleží.

U konstruktoru si všimněme, že se nám objevuje syntaxe s `:`. Ta značí, že přiřazujeme hodnotu *členské proměnné* dané 
třídy. Syntaxe `_member(member)` má stejný efekt jako `_member = member`.

Běžnou praxí v C++ je, že getter a setter se jmenují stejně, s tím, že se využívá overloadingu.
=== std::vector
Ukažme si práci s vektory:
```cpp
#include <vector>
int main(){
  auto vec = std::vector<uint32_t>{1, 2, 3, 4, 5};
  std::cout << vec.size() << "\n"; // 5
  std::cout << vec[0] << "\n"; // vypíše první prvek
  for (auto v : vec) std::cout << v << "\n"; // for-each; vypíše všechny prvky
  std::cout << vec[10] << "\n"; // vypíše se '0'.
}
```
Vektory dynamicky mění svou velikost na heapu dle potřeby. Nahrazují manuální práci s malloc a realloc z klasické C 
implementace. Ekvivalentem je ArrayList v Javě. Všimněme si notace `<uint32_t>`, která vypadá a chová se jako generika, 
ale nejsou to úplně generika. Jedná se o template --- více dále.

Proč program u poslední řádky vypsal `0`, když je náš vektor jen velikosti 5? C++ nekontroluje, jestli je pozice 
validní, takže v tomto případě saháme za vektor, na nějaká data na heapu. Pokud bychom měli smůlu, mohla by se tam 
nacházet citlivá data, případně by tam žádná paměť nebyla a celý program by havaroval.
Tento problém můžeme vyřešit:
```cpp
std::cout << vec.at(10) << "\n";
```
Tato metoda funguje naprosto ekvivalentně, jen navíc provádí bound check.
=== Destructor
Jak je vlastně možné, že se vektor může dynamicky zvětšovat?
```cpp
int main(){
  auto vec = std::vector<uint32_t>{1, 2, 3, 4, 5};
  for(size_t i=0; i < 1000; ++i) 
    vec.push_back(i);
}
```
V konstruktoru je nespíše obyčejný malloc, kterým si alokujeme buffer na heapu. Dokud dostačuje, tak do něj skrze 
`push_back` volně přidáváme hodnoty. Až místo dojde, tak se zavolá `realloc`, a pokračujeme dál. Z toho ale plyne 
otázka --- jak se uvolňuje takto alokovaná pamět? Odpovědí jsou destruktory. Použijme náš předchozí příklad:
```cpp
class X{
  std::vector<uint32_t> vec;
  void* _member; 

public:
  X() : _member(malloc(128)){
    std::cout << "vytvořeno\n";
  }

  ~X(){ // destruktor; vlnovka je důležitá!
    free(_member);
    std::cout << "zničeno\n";
  } 
};

int main(){
  auto x = X();
  std::cout << "prostřední print\n";
}
```
Destruktory se automaticky volají v moment, kdy zaniká proměnná. Aniž bychom zabíhali do detailu, tak řekněme, že 
proměnná zaniká na konci scopu, ve kterém byla vytvořena. Tedy v tomto příkladu by `vec` zanikl na konci mainu.

V destruktoru musíme zajistit, že to, co jsme si mohli teoreticky alokovat, korektně uvolníme. Když budeme mít členské 
proměnné, které samy o sobě vyžadují zdestruování a destruktor mají, C++ se už o vše postará a korektně ho 
zavolá při zániku třídy.

V destruktoru nemusíme jen uvolňovat paměť. Můžeme tam přidat i zavírání file descriptorů, čekání na jiná vlákna nebo
cokoliv jiného. 

#info-box([Pokud třeba budeme chtít pracovat s file descriptorem, často ho alokujeme v konstruktoru a uvolníme
v destruktoru. Tento idiom lze nalézt pod zkratkou RAII, tj. Resource Acquisition Is Initialization.])

=== Template

```cpp
class X{};

template <typename T>
class Y{
  T _t;
};

int main(){
  Y<uint32_t> t;
}
```
Compiler v tento moment substituuje za `T` ve třídě `Y` obsah `<>` při vytvoření instance třídy. Výhodou tohoto přístupu
je, že jak samotná třída, tak ona proměnná `_t` jsou uloženy na stacku, čímž ušetříme čas oproti přístupu na heap.

Ukažme si příklad, kde použijeme templaty na funkci:
#codeblock("../assets/code/cpp/02/examples/src/1cpp_intro/template_fn.cpp")
Po substituci se kompilátor pokusil zavolat `Z.do_thing()`. Protože třída tuto metodu nemá implementovanou, program 
havaroval.

Zkusme teď parametrizovat třídu dvěma parametry:
#codeblock("../assets/code/cpp/02/examples/src/1cpp_intro/template_array.cpp")
Jak vidíme, můžeme parametrizovat nejenom datovým typem, ale i konkrétním číslem.

=== Další kontejnery
```cpp
int main(){
  auto vec = std::vector<uint32_t>();
  auto arr = std::array<uint32_t, 10>();
  std::queue<uint32_t>();
  std::map<uint32_t, uint32_t>(); // udržuje pořadí jak jsme hodnoty vkládali
  std::unordered_map<uint32_t, uint32_t>(); // bez pořadí, je rychlejší
  std::set<uint32_t>();
  std::unordered_set<uint32_t>();
}
```
Array je typ, který v sobě má pole 10 prvků, v tomto případě. Array a samotné hodnoty jsou uloženy na stacku. Fixní 
velikost je indikovaná i nutností uvést do templatu konkrétní velikost. Přes vše lze iterovat skrze `for`-each, na 
všechny fungují metody `size()` a jiné. #link("https://en.cppreference.com/w/cpp/container.html")[Seznam všech 
kontejnerů zde].

=== Předávání hodnot do funkcí
Mějme tento příklad:
```cpp
void fn(std::vector<uint32_t> vec){}

int main(){
  auto vec = std::vector<uint32_t>();
  fn(vec);
}
```
V tomto případě se při volání funkce vytvoří kopie celého vektoru, což znamená zbytečné kopírování všech prvků. Obzvlášť
u rekurze je tento přístup velmi nevýhodný, ba až nemožný s obrovskými vektory. V klasickém C bychom tento problém 
řešili skrze pointery.
```cpp
std::vector<uint32_t> *vec_ptr;

void fn(std::vector<uint32_t> *vec){
  vec_ptr = vec;
}

int fn2(){
  auto vec = std::vector<uint32_t>();
  fn(&vec);
}
```
To je už lepší přístup, ale stále nevhodný pro případ, že by nám pointer lokální proměnné utekl do globální, tedy mimo 
scope!

Druhou, lepší variantou jsou reference:
```cpp
void fn(std::vector<uint32_t>& vec){ // zde přibylo &

}

int main(){
  auto vec = std::vector<uint32_t>();
  fn(vec);
}
```
Reference garantuje, že je vytvořena na validní objekt, který existuje někde v paměti.

== Vícevláknové programování
// #codeblock("../assets/code/cpp/02/examples/src/1cpp_intro/template_heap.cpp")
/*
```cpp


```
*/