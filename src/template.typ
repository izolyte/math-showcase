#import "style.typ": default-theme, theme-state
#import "theorems.typ": reset-environments, section-reset
#import "config.typ": author as default-author

// rounded tag chip
#let _pill(t, th) = box(
  fill: th.thm-fill,
  inset: (x: 5pt, y: 2pt),
  outset: (y: 1pt),
  radius: 3pt,
  text(size: 8pt, fill: th.primary, weight: "medium", t),
)

#let doc(
  title: "",
  source: "",
  source_url: none,
  source_license: "All rights reserved",
  author: default-author,
  subtitle: none,
  date: none,
  difficulty: none,
  tags: (),
  summary: none,
  prerequisites: (),
  resources: (),
  theme: (:),          // per-doc overrides
  body
) = {
  // merge overrides over the defaults and share with the environments
  let th = default-theme + theme
  theme-state.update(th)

  set document(title: title, author: author)
  set text(font: th.font, size: th.size, fill: th.ink, ligatures: true)
  set par(justify: true, leading: 0.72em, spacing: 1.2em)
  set heading(numbering: "1.1")
  set math.equation(numbering: "(1)")

  // level-1 headings: small caps + a rule, and reset the env counter so
  // numbering restarts each section (Theorem 1.1, 2.1, ...)
  show heading.where(level: 1): it => {
    section-reset()
    block(above: 1.7em, below: 0.85em)[
      #text(size: 12pt, weight: "bold", fill: th.primary)[#smallcaps(it)]
      #v(3.5pt)
      #line(length: 100%, stroke: 0.4pt + th.rule)
    ]
  }
  show heading.where(level: 2): it => block(above: 1.1em, below: 0.5em)[
    #text(size: 11pt, weight: "bold", fill: th.primary, style: "italic")[#it]
  ]
  show link: set text(fill: th.accent)
  show ref: set text(fill: th.accent)
  show figure.caption: set text(size: 9pt, fill: th.muted)

  set page(
    paper: "a4",
    margin: (x: 2.4cm, top: 2.6cm, bottom: 2.3cm),
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 8.5pt, fill: th.muted)
        emph(title)
        v(-7pt)
        line(length: 100%, stroke: 0.5pt + th.rule)
      }
    },
    footer: context {
      set align(center)
      set text(size: 8.5pt, fill: th.muted)
      counter(page).display("1 / 1", both: true)
    },
  )

  reset-environments()

  // metadata for `typst query`, used to build the README index
  [#metadata((
    title: title,
    source: source,
    source_url: source_url,
    difficulty: difficulty,
    date: date,
    tags: tags,
  )) <problem-meta>]

  // title block
  line(length: 100%, stroke: 1.2pt + th.primary)
  v(2.5pt)
  line(length: 100%, stroke: 0.5pt + th.primary)
  v(11pt)
  text(size: 20pt, weight: "bold", fill: th.primary)[#title]
  if subtitle != none {
    v(4pt)
    text(size: 12.5pt, fill: th.muted, style: "italic")[#subtitle]
  }

  // byline
  v(9pt)
  {
    set text(size: 9.5pt)
    [by #text(weight: "medium")[#author]]
    if date != none { text(fill: th.muted)[#h(0.6em)·#h(0.6em)#date] }
  }

  // source + difficulty
  v(6pt)
  {
    set text(size: 9pt, fill: th.muted)
    let parts = ()
    if source != "" {
      parts.push[Source: #if source_url != none [#link(source_url)[#source]] else [#source]]
    }
    if difficulty != none {
      parts.push[Difficulty: #difficulty]
    }
    parts.join("  ·  ")
  }

  // Tag pills
  if tags.len() > 0 {
    v(6pt)
    box(tags.map(t => _pill(t, th)).join(h(4pt)))
  }

  v(9pt)
  line(length: 100%, stroke: 0.5pt + th.rule)

  // summary
  if summary != none {
    v(12pt)
    block(inset: (left: 1.2em, right: 1.2em))[
      #text(weight: "bold", fill: th.primary)[Summary. ]
      #text(style: "italic")[#summary]
    ]
  }

  v(16pt)

  body

  // prerequisites + further reading
  if prerequisites.len() > 0 or resources.len() > 0 {
    v(22pt)
    line(length: 100%, stroke: 0.5pt + th.rule)
    v(9pt)

    if prerequisites.len() > 0 {
      text(weight: "bold", fill: th.primary, "Prerequisites")
      v(4pt)
      for p in prerequisites {
        if type(p) == dictionary and p.at("url", default: none) != none {
          [- #link(p.url)[#p.name] \ ]
        } else if type(p) == dictionary {
          [- #p.name \ ]
        } else {
          [- #p \ ]
        }
      }
      v(9pt)
    }

    if resources.len() > 0 {
      text(weight: "bold", fill: th.primary, "Further Reading")
      v(4pt)
      for r in resources {
        [- #link(r.url)[#r.title] \ ]
      }
    }
  }

  // credit line at the bottom
  v(1fr)
  line(length: 100%, stroke: 0.5pt + th.rule)
  v(5pt)
  text(size: 8pt, fill: th.muted)[
    #if source != "" [
      Problem adapted from #source (#source_license). \
      Solution by #author, licensed #link("https://creativecommons.org/licenses/by/4.0/")[CC BY 4.0].
    ] else [
      Original problem and solution by #author, licensed #link("https://creativecommons.org/licenses/by/4.0/")[CC BY 4.0].
    ]
  ]
}
