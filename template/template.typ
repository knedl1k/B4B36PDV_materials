#import "./front.typ": *
#import "./outline.typ": *
#import "./colors.typ": *

#let template(meta: (), body) = {
    set document(
        author: meta.author,
        title: meta.title,
        date: meta.date
    )
    set page(paper: "a4")
    set text(font:"Libertinus Serif", lang:"cs", size:11pt)
    set heading(numbering: "1.1")

    title-page(
        title: meta.title,
        subtitle: meta.subtitle,
        author: meta.author,
        date: meta.date.year(),
        university: meta.university,
        faculty: meta.faculty,
        logo-path: meta.logo,
    )
    
    show link: it => {
        set text(proper-purple)
        it
    }

    show raw.where(block: true): it => {
      set par(justify: false)
      set align(left)
      block(
        width: 100%,
        fill: light-grey,
        spacing: 0pt,
        outset: 0pt,
        inset: 8pt,
        radius: 5pt,
        above: 13pt,
        below: 13pt,
      )[#it]
    }

    set math.equation(numbering: "(1)")

    set page(numbering: "I")
    counter(page).update(1)
    toc() // render outline / table of contents
    body // render rest of the document 
}

#let codeblock(filename) = raw(read(filename), block: true, lang: filename.split(".").at(-1)) // show codeblock from a destionation with syntax highlighting