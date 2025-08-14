#let toc(depth: 3) = {
    set outline.entry(fill: repeat([.], gap: 0.5em))

    show outline.entry.where(level: 2): it => {
        box(inset: (left: 10pt))[
            #set par(hanging-indent: 15pt)
            // #v(-4pt)
            #it
            // #v(4pt)
        ]
    }

    show outline.entry.where(level: 3): it => {
        block(spacing: 6pt, inset: (left: 12pt))[
        // #v(2pt)
        #it
        // #v(-2pt)
        ]
    }

    show outline.entry.where(level: 1): it => {
        show repeat: none
        v(5pt)
        strong(it)
    }

    outline(
        title: [Obsah #v(40pt)],
        depth: 3,
        indent: (
        nesting => (
            if (nesting == 0) { 0em } else if nesting == 1 { 1em } 
            else if nesting == 2 { 2.5em } else if nesting == 3 { 4.5em }
        )
        ),
    )
}