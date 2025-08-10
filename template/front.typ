#let title-page(
  title: "",
  subtitle: "",
  author: "",
  date: datetime.today().year(),
  university: "",
  faculty: "",
  logo-path: "",
  use-font: "Technika"
) = {
    set align(center)
    v(2.5cm)
    // Uni and faculty
    text(
        font: use-font,
        weight: "regular",
        size: 14.4pt,
        university
    )
    v(0.1mm)
    // linebreak()
    text(
        font: use-font,
        weight: "regular",
        size: 14.4pt,
        faculty
    )

    v(1cm)

    // main title
    text(
        font: use-font,
        weight: "regular",
        size: 24.88pt,
        title
    )

    v(1mm)

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
    text(size: 12pt, author)
    linebreak()
    text(size: 12pt, "Praha, " + str(date))

    v(1.5cm)

    if logo-path != "" {
        image(logo-path, width: 50%)
    }
    pagebreak()
}
