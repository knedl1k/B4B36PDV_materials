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

    title-page(
        title: meta.title,
        subtitle: meta.subtitle,
        author: meta.author,
        date: meta.date.year(),
        university: meta.university,
        faculty: meta.faculty,
        logo-path: meta.logo,
    )
    
    set heading(numbering: "1.1")


    toc()
    body
}
