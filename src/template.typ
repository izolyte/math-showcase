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
  tags: (),
  prerequisites: (),
  resources: (),
  theme: (:),          // per-doc overrides
  body
) = {
  // merge overrides over the defaults and share with the environments
  let th = default-theme + theme
  theme-state.update(th)

  set document(title: title, author: author)
  set text(font: th.font, size: th.size, fill: th.ink, ligatures: true,
    lang: "en", hyphenate: true)
  set par(justify: true, leading: 0.72em, spacing: 1.2em)
  set heading(numbering: "1.1")
  // Equations are unnumbered by default; number only the ones you reference,
  // with `numbered(...)` from components. (Numbering every display is clutter.)
  set math.equation(numbering: none)

  // level-1 headings: small caps + a rule, and reset the env counter so
  // numbering restarts each section (Theorem 1.1, 2.1, ...)
  show heading.where(level: 1): it => {
    section-reset()
    block(above: 1.7em, below: 0.85em)[
      #text(size: 12pt, weight: "bold", fill: th.accent)[#counter(heading).display()]#h(0.6em)#text(size: 12pt, weight: "bold", fill: th.primary)[#smallcaps(it.body)]
      #v(3.5pt)
      // two-tone underline: a short accent segment over a full hairline
      #line(length: 100%, stroke: 0.4pt + th.rule)
      #v(-0.4pt)
      #line(length: 1.8em, stroke: 1.4pt + th.accent)
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
        grid(
          columns: (1fr, auto),
          align: (left + bottom, right + bottom),
          emph(title),
          if tags.len() > 0 { text(tracking: 1pt)[#upper(tags.first())] },
        )
        v(2pt)
        line(length: 100%, stroke: 0.5pt + th.rule)
      }
    },
    footer: context {
      set text(size: 8pt, fill: th.muted)
      line(length: 100%, stroke: 0.5pt + th.rule)
      v(3pt)
      // brand left, page right; author/license live in the colophon, not here
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        smallcaps[math-showcase],
        counter(page).display("1 / 1", both: true),
      )
    },
  )

  reset-environments()

  // metadata for `typst query`, used to build the README index
  [#metadata((
    title: title,
    source: source,
    source_url: source_url,
    date: date,
    tags: tags,
  )) <problem-meta>]

  // title block — editorial header: eyebrow, title, accent mark, meta, tags.
  // eyebrow: the primary area in spaced caps, accent colour
  if tags.len() > 0 {
    text(size: 8.5pt, weight: "bold", fill: th.accent, tracking: 2pt)[
      #upper(tags.first())
    ]
    v(6pt)
  }
  text(size: 23pt, weight: "bold", fill: th.primary)[#title]
  if subtitle != none {
    v(5pt)
    text(size: 12.5pt, fill: th.muted, style: "italic")[#subtitle]
  }
  // source attribution — shown prominently under the title when present
  if source != "" {
    v(6pt)
    text(size: 10.5pt, fill: th.muted, style: "italic")[
      #if source_url != none [#link(source_url)[#source]] else [#source]
    ]
  }

  // short accent rule — a signature mark under the title
  v(9pt)
  line(length: 2.6em, stroke: 2pt + th.accent)

  // tag pills
  if tags.len() > 0 {
    v(8pt)
    box(tags.map(t => _pill(t, th)).join(h(4pt)))
  }

  v(11pt)
  line(length: 100%, stroke: 0.5pt + th.rule)

  v(16pt)

  body

  // end-of-solution mark: a small accent diamond between two hairlines
  v(12pt)
  align(center)[
    #box(baseline: -0.1em, line(length: 2em, stroke: 0.5pt + th.rule))
    #h(0.6em) #text(size: 8pt, fill: th.accent)[#sym.diamond.filled] #h(0.6em)
    #box(baseline: -0.1em, line(length: 2em, stroke: 0.5pt + th.rule))
  ]

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
