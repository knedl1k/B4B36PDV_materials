#import "template/template.typ": *
#import "template/info-boxes.typ": *

#show: template.with(
    meta: (
        title: "Paralelní a distribuované výpočty",
        subtitle: "od principů k implementaci",
        author: "Jakub Adamec",
        date: datetime.today(),
        university: "České vysoké učení technické v Praze",
        faculty: "Fakulta elektrotechnická",
        logo: "../assets/images/symbol_cvut_plna_samostatna_verze.svg" //relative to template.typ
    )
)

#let chapters = (
    "content/01-cpp/01-intro.typ",
    "content/01-cpp/02-cpp.typ",
    "content/01-cpp/03-openmp.typ",
    "content/01-cpp/04-cds.typ",
    "content/01-cpp/05-design.typ",
    "content/01-cpp/06-sort.typ",
    "content/01-cpp/07-gpu.typ",
    "content/02-java/01-intro.typ",
    "content/02-java/02-time.typ",
    "content/02-java/03-snapshot.typ",
    "content/02-java/04-exclusion.typ",
    "content/02-java/05-raft.typ",
    "content/02-java/06-leader.typ",
)

#pagebreak()

// #include "content/00-preface.typ"
// #pagebreak()

#set page(numbering: "1")
#counter(page).update(1)
#for ch in chapters {
    include ch
    pagebreak()
}


#bibliography(style:"ieee","content/99-bibliography.yml")