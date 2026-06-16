#import "style.typ": theme-state, default-theme

// Formal AMS-style environments. A single counter numbers all results
// section-relative (Theorem 1.1, Definition 1.2, Lemma 1.3, ...), reset at each
// top-level heading by `section-reset()` (called from the template). Colors come
// from the live theme state, so per-document overrides cascade here.

#let _env-counter = counter("mshow-env")
#let _step-counter = counter("mshow-step")

#let reset-environments() = {
  _env-counter.update(0)
  _step-counter.update(0)
}

// Called by the template on every level-1 heading.
#let section-reset() = _env-counter.update(0)

// Numbered, accent-barred result. `italic` renders the statement in italic
// (classical convention for theorem-like statements).
#let _env(kind, fill-key, accent-key, italic, title, body) = {
  _env-counter.step()
  context {
    let th = theme-state.get()
    let acc = th.at(accent-key)
    let sec = counter(heading).get()
    let s = if sec.len() > 0 { sec.first() } else { 0 }
    let n = _env-counter.get().first()
    let statement = if italic { emph(body) } else { body }
    block(
      width: 100%,
      fill: th.at(fill-key),
      inset: (x: 14pt, y: 11pt),
      radius: (top-right: 3pt, bottom-right: 3pt),
      stroke: (left: 2pt + acc),
      breakable: true,
    )[
      #smallcaps(text(weight: "bold", fill: acc)[#kind #numbering("1.1", s, n)])#if title != none [ #emph[(#title)]]#text(weight: "bold")[.]#h(0.4em)#statement
    ]
  }
}

#let theorem(title: none, body) = _env("Theorem", "thm-fill", "accent", true, title, body)
#let lemma(title: none, body) = _env("Lemma", "thm-fill", "accent", true, title, body)
#let corollary(title: none, body) = _env("Corollary", "thm-fill", "accent", true, title, body)
#let proposition(title: none, body) = _env("Proposition", "thm-fill", "accent", true, title, body)
#let definition(title: none, body) = _env("Definition", "def-fill", "def-accent", false, title, body)

// highlighted callout for the key idea
#let insight(body) = context {
  let th = theme-state.get()
  block(
    width: 100%,
    fill: th.insight-fill,
    inset: (x: 14pt, y: 11pt),
    radius: (top-right: 3pt, bottom-right: 3pt),
    stroke: (left: 2pt + th.insight-accent),
    breakable: true,
  )[
    #smallcaps(text(weight: "bold", fill: th.insight-accent)[Key Insight.])#h(0.4em)#body
  ]
}

// a numbered solution step with an optional cited reason
//   #step(reason: [Chain rule])[Differentiate both sides ...]
#let step(reason: none, body) = {
  _step-counter.step()
  context {
    let th = theme-state.get()
    block(width: 100%, above: 0.9em, below: 0.9em)[
      #text(weight: "bold", fill: th.primary)[Step #_step-counter.get().first().] #body
      #if reason != none {
        v(2pt)
        text(size: 9pt, fill: th.muted)[#h(1.2em)▸ #emph[reason:] #reason]
      }
    ]
  }
}

// Proof with a right-aligned QED tombstone.
#let proof(body) = block(width: 100%, inset: (left: 2pt))[
  #emph[Proof.]#h(0.4em)#body#h(1fr)$square$
]

// Lightweight inline notes.
#let remark(body) = context {
  let th = theme-state.get()
  block(width: 100%, inset: (left: 2pt))[
    #text(fill: th.muted)[#emph[Remark.]] #body
  ]
}

#let example(body) = block(width: 100%, inset: (left: 2pt))[
  #emph[Example.] #body
]
