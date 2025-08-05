#import "template.typ": *

#set text(font:"New Computer Modern", lang:"cs", size:11pt)

// #show: doc => project-style(
//   title: "Paralelní a distribuované výpočty",
//   author: "Jakub Adamec",
//   version: "1.0.0",
//   date: datetime.today(),
//   doc,
// )

#align(center)[
  #v(2cm)
  #set text(14.4pt)
  *České vysoké učení technické v Praze*

  *Fakulta elektrotechnická*
  #v(1cm)
  #set text(24.88pt)
  *Paralelní a distribuované výpočty*

  #set text(14.4pt)
  B4B36PDV
  #v(2cm)
  #set text(11pt)
  Jakub Adamec \
  Praha, #datetime.today().year()
  #v(1.5cm)
  #figure(image("assets/images/symbol_cvut_plna_samostatna_verze.svg", width:50%))
]

#pagebreak()

#outline()

#pagebreak()

// #include "content/00-preface.typ"
// #pagebreak()

// --- multithreading ---
// chapter?
#include "content/01-cpp/01-intro.typ"
#include "content/01-cpp/02-cpp.typ"
#include "content/01-cpp/03-openmp.typ"
#include "content/01-cpp/04-cds.typ"
#include "content/01-cpp/05-design.typ"
#include "content/01-cpp/06-sort.typ"
#include "content/01-cpp/07-gpu.typ"

// --- distributed ---
#pagebreak()
// chapter?
#include "content/02-java/01-intro.typ"
#include "content/02-java/02-time.typ"
#include "content/02-java/03-snapshot.typ"
#include "content/02-java/04-exclusion.typ"
#include "content/02-java/05-raft.typ"
#include "content/02-java/06-leader.typ"
// ...

// --- Závěr ---
#pagebreak()
#include "content/99-bibliography.typ"