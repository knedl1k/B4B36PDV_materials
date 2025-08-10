#let title-page(
    title: "",
    subtitle: "",
    author: "",
    date: datetime.today().year(),
    university: "",
    faculty: "",
    logo-path: "",
    use-font: "New Computer Modern"
) = {
    set align(center)
    v(2.5cm)
    // university
    text(
        font: use-font,
        weight: "semibold",
        size: 14.4pt,
        university
    )
    v(0.1mm)
    // faculty
    text(
        font: use-font,
        weight: "semibold",
        size: 14.4pt,
        faculty
    )
    v(1cm)
    // main title
    text(
        font: use-font,
        weight: "semibold",
        size: 24.88pt,
        title
    )
    linebreak()
    linebreak()
    // subtitle
    if subtitle != "" {
        text(
            font: use-font,
            weight: "light",
            size: 14.4pt,
            subtitle
        )
    }
    v(1.5cm)
    // authors
    text(font: use-font, size: 12pt, author)
    linebreak()
    text(
        font: use-font,
        size: 12pt, 
        "Praha, " + str(date)
    )
    v(1.5cm)
    // uni logo
    if logo-path != "" {
        image(logo-path, width: 50%)
    }
    pagebreak()
}
