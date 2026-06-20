// Copy this file to start a new problem (or run: make new T=<topic> S=<slug>).
// Rename to: [topic]-[###]-[slug].typ   (see docs/CONVENTIONS.md)
//
// Before committing:
//   - compiles cleanly (make compile P=<topic>-NNN)
//   - every imported theorem/rule/technique is cited (cite(name, url:) or cite(name, ref:)); no [ref?]
//   - no skipped steps — a reader never has to ask "how did that follow?"
//   - a diagram is included wherever the math is visual
//   - sections in order, only the ones the problem earns (see CONVENTIONS)
//   - statement is in your own words if the source had prose
//   - source set, or "" for an original problem
//   - make index
// Delete these comment lines when done.

#import "../src/template.typ": *
#import "../src/theorems.typ": theorem, lemma, corollary, proposition, definition, proof, insight, step, remark, example
#import "../src/components.typ": comparison, figure-image, cite, numbered, answer, diagram
// For a hand-drawn figure, also uncomment these (CeTZ is pinned; the first
// compile downloads it). Draw to the actual math — see #diagram example below.
// #import "../src/style.typ": default-theme
// #import "@preview/cetz:0.3.4"

#show: doc.with(
  title: "Problem title here",                // plain text — no $math$ here
  subtitle: none,                             // optional one-line subtitle
  source: "e.g. Putnam 2019 B3",
  source_url: "https://...",                 // link to original, or none
  source_license: "All rights reserved",     // or "CC BY-SA 4.0" (Stack Exchange), "CC BY 4.0"
  // author defaults from src/config.typ; override only if needed
  date: none,                                 // e.g. "2026-06-16"
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

// SECTIONS ARE A MENU IN A FIXED ORDER, NOT A CHECKLIST. Only the statement and
// the solution are required. Add the rest *when they earn their place* and keep
// them in the order below — it follows how a reader thinks: what's asked → what's
// the answer → fix notation → the idea → the formal work → check → step back. A
// short evaluation is fine as Statement + Solution alone; don't pad with an empty
// "Reflection". Match the structure to the problem.

// --- REQUIRED ---

= Problem Statement

State the problem precisely. Pure math (equations) may be copied; restate
creative word-problem prose in your own words.

// (optional) Answer — for evaluate / find-type problems, show the result up
// front, then prove it below. Skip it when the statement already is the claim.
// #answer[$ integral_0^oo e^(-x) dif x = 1. $]

// --- OPTIONAL, BEFORE the solution (in this order) ---

// = Setup and Notation
// Fix notation and recall definitions — only when the solution carries enough
// machinery that inlining it would clutter the argument.
// #definition(title: "Term")[Define any non-standard term.]

// = Idea
// The plan in plain language before the formal work, ending in the key insight —
// only when the approach is non-obvious enough to deserve motivating. For a short
// problem, an #insight at the top of the solution is enough.
// #insight[The one idea that makes the problem tractable.]
//
// A diagram makes the idea visible — include one whenever the math is geometric:
// #diagram(caption: [What the picture shows.])[
//   #cetz.canvas(length: 1cm, {
//     import cetz.draw: *
//     let acc = default-theme.accent
//     line((-2.5, 0), (2.5, 0), mark: (end: ">"))   // x-axis
//     line((0, 0), (0, 1.6), mark: (end: ">"))       // y-axis
//     // ... draw curves / regions / lattices to the actual problem ...
//   })
// ]

= Solution

Show every move — including the algebra between two displayed lines — so the
reader never has to reconstruct a jump. Name the rule each step uses in
`reason:`, and `cite` it with a link whenever it is a named theorem or technique
(skip the link only for elementary algebra).

#step(reason: [definition / first move])[
  Show the work.
]

#step(reason: cite("Name of the theorem", url: "https://..."))[
  Next move, with the intermediate algebra spelled out line by line:
  $ a &= b \
      &= c \
      &= d. $
]

#theorem[State the result that has now been established.]

// --- OPTIONAL, AFTER the solution (in this order) ---

// = Verification
// Sanity-check keyed to the task type: small cases, a limit, an equality case,
// or recomputing by another method. Worth it whenever the answer isn't
// self-evidently right.

// = Reflection
// Generalizations, alternative methods, and common pitfalls — within mathematics.
// Only with a genuine point to make. A reference equation can be numbered for
// back-reference: #numbered($ sum_(k=1)^n k = n(n+1)/2 $) <closed>

// = Application
// Where the result is actually used — other areas of math, science, engineering,
// computation. The real-world hook most solution write-ups skip; it's part of
// what sets this showcase apart. Cite each claimed use, and only include it when
// there's a concrete, honest application — don't stretch for one.
