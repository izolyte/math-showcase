// Copy this file to start a new problem (or run: make new T=<topic> S=<slug>).
// Rename to: [topic]-[###]-[slug].typ   (see docs/CONVENTIONS.md)
//
// Before committing:
//   - compiles cleanly (make compile P=<topic>-NNN)
//   - every theorem/rule used is named, no skipped steps
//   - statement is in your own words if the source had prose
//   - source set, or "" for an original problem
//   - make index
// Delete these comment lines when done.

#import "../src/template.typ": *
#import "../src/theorems.typ": theorem, lemma, corollary, proposition, definition, proof, insight, step, remark, example
#import "../src/components.typ": comparison, figure-image

#show: doc.with(
  title: "Problem title here",
  subtitle: none,                             // optional one-line subtitle
  source: "e.g. Putnam 2019 B3",
  source_url: "https://...",                 // link to original, or none
  source_license: "All rights reserved",     // or "CC BY-SA 4.0" (Stack Exchange), "CC BY 4.0"
  // author defaults from src/config.typ; override only if needed
  date: none,                                 // e.g. "2026-06-16"
  difficulty: "medium",                       // easy | medium | hard
  summary: none,                              // optional one-line abstract under the title
  tags: ("calculus", "subtopic-1", "subtopic-2"),
  // theme: (accent: rgb("#0a7d55")),         // optional per-problem color override
  prerequisites: (
    (name: "Some theorem", url: none),       // url: none until you add a link
    (name: "Another concept", url: "https://..."),
  ),
  resources: (
    (title: "Resource title", url: "https://..."),
  ),
)

= Problem Statement

State the problem precisely. Pure math (equations) may be copied; restate
creative word-problem prose in your own words.

= Setup and Notation

Fix notation, list what is given and what must be shown. Recall any definition
the solution relies on.

#definition(title: "Term")[Define any non-standard term used below.]

= Strategy

Explain the plan in plain language *before* the formal work: why this approach,
what the obstacle is, and how it is overcome.

#insight[State the single idea that makes the problem tractable.]

= Solution

Break the argument into numbered steps. Justify *every* step with the rule or
theorem it uses, and don't skip steps.

#step(reason: [definition of the object])[
  First move. Show the work.
]

#step(reason: [name the theorem / rule applied])[
  Next move, with full intermediate algebra:
  $ ... = ... $
]

#step(reason: [why this is valid])[
  Continue until the result is reached.
]

#proof[
  Optional: a formal proof block for the central claim, ending with QED.
]

#theorem[State the result that has now been established.]

= Verification

Sanity-check the answer: special cases, units, limits, or a numerical check.

= Reflection

Can it be generalized? Alternative methods? Common pitfalls? Related results?
