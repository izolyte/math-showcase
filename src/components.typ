#import "style.typ": theme-state

// reusable content pieces, themed via theme-state

// a comparison / case table wrapped in a numbered figure
//   #comparison(
//     ("Method", "Result", "Cost"),
//     ("Brute force", $O(n^2)$, "slow"),
//     ("Optimized",   $O(n log n)$, "fast"),
//     caption: [Approaches compared.],
//   )
#let comparison(headers, ..rows, caption: none, align-cols: auto) = context {
  let th = theme-state.get()
  let cols = headers.len()
  let header-cells = headers.map(h => table.cell(
    fill: th.primary,
    inset: 8pt,
    text(fill: white, weight: "bold", h),
  ))
  figure(
    table(
      columns: cols,
      align: if align-cols == auto { (left,) + (center,) * (cols - 1) } else { align-cols },
      stroke: (x, y) => (bottom: 0.5pt + th.rule),
      inset: 7pt,
      ..header-cells,
      ..rows.pos().flatten(),
    ),
    caption: caption,
  )
}

// A centered figure for an external image with a caption.
#let figure-image(path, caption: none, width: 80%) = figure(
  image(path, width: width),
  caption: caption,
)

// Wrap a hand-drawn diagram (a CeTZ canvas) as a captioned, numbered figure.
// The figure is the visual half of the argument, not decoration — draw it to the
// actual math. In the problem file:
//   #import "@preview/cetz:0.3.4"
//   #diagram(caption: [What the picture shows.])[
//     #cetz.canvas({ import cetz.draw: *; /* ... */ })
//   ]
#let diagram(body, caption: none) = figure(body, caption: caption)

// A boxed final answer, placed right after the problem statement for
// evaluate / find-type problems that have a crisp result. State the answer up
// front, then earn it in the solution below.
//   #answer[$ integral_0^oo e^(-x) dif x = 1. $]
#let answer(body) = context {
  let th = theme-state.get()
  block(
    width: 100%,
    fill: th.thm-fill,
    inset: (x: 14pt, y: 11pt),
    radius: (top-right: 3pt, bottom-right: 3pt),
    stroke: (left: 2pt + th.primary),
    breakable: true,
  )[
    #smallcaps(text(weight: "bold", fill: th.primary)[Answer.])#h(0.4em)#body
  ]
}

// Number a display equation, for the few you actually refer back to. Equations
// are unnumbered by default (see template), so wrap only those in `numbered`:
//   #numbered($ a^2 + b^2 = c^2 $) <pyth>
//   ... as @pyth shows ...
#let numbered(eq) = {
  set math.equation(numbering: "(1)")
  eq
}

// Inline citation for a named theorem, rule, or technique that the solution
// invokes but does not prove. Such a result must always be traceable, so give
// either an online `url` or an offline `ref` (a book/paper, rendered as a
// footnote). With neither, a red [ref?] marker is rendered so the gap is
// impossible to miss in review — fill it before shipping.
//   #step(reason: cite("Dominated Convergence Theorem", url: "https://..."))[ ... ]
//   #step(reason: cite("Sylow's theorem", ref: [Dummit & Foote, §4.5]))[ ... ]
#let cite(name, url: none, ref: none) = {
  if url != none { link(url)[#emph(name)] }
  else if ref != none [#emph(name)#footnote(ref)]
  else [#emph(name)#text(fill: rgb("#b5403a"), size: 0.85em)[~[ref?]]]
}
