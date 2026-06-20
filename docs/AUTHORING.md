# Authoring

What goes inside a problem file. Naming, branches, and git are in
[CONVENTIONS.md](CONVENTIONS.md).

Start from [`../problems/_TEMPLATE.typ`](../problems/_TEMPLATE.typ).

## Sections

Eight sections, always in this order when present:

```text
Problem Statement → Answer → Setup & Notation → Idea →
Solution → Verification → Reflection → Application
```

Only Problem Statement and Solution are required. Add the others when they
pull their weight — a two-section write-up is fine if the problem is short.

- **Answer** — for evaluate/find problems: box the result with `answer[...]`
  up front, then prove it.
- **Idea** — the `#insight` before the formal work.
- **Reflection** — generalizations, alternative proofs, pitfalls. Keep it
  within mathematics.
- **Application** — a concrete real-world use (statistics, physics,
  computation). Include a cite for each. Skip if there's nothing honest to say.

## Writing the solution

- **Cite every result you use but don't prove.** Any named theorem, rule, or
  technique needs a `cite("…", url: "…")` (online) or `cite("…", ref: [Book, §x])`
  (offline). This covers claims in any section — Setup, Idea, Verification,
  Application — not just `step` reasons. ("no elementary antiderivative" →
  cite Liouville; "the tail converges" → cite the comparison test.) A `cite`
  without a source prints a red `[ref?]`, so missing references are visible.
  Elementary facts (commutativity, basic arithmetic) need no cite. A `#theorem`
  you prove in the file is yours — don't cite your own result.

- **Show every step.** Include the algebra between displayed lines. If a reader
  has to ask "how did that follow?", the step is missing. Put the rule in
  `reason:`.

- **Concrete before abstract.** Before stating the general case, show a small
  instance — a specific `n`, a picture, a number.

- **Lead with the idea.** Put an `#insight` naming the key move before the
  formal steps.

- **Diagram when the math is visual.** If the problem has geometry or a
  visualizable structure, draw it with `diagram(...)` (CeTZ `@preview/cetz:0.3.4`,
  pinned) — a shaded region, a lattice, a transformed domain. Make it specific
  to the actual problem; theme with `default-theme.accent`. Skip it only when
  nothing visual would help.

- **Don't flatten the result.** If the answer is surprising or the method is
  non-obvious, say so briefly. Skip this if there's nothing real to add.

- **End with the right environment.** A prove task ends with `#theorem`. An
  evaluate/find task ends at the answer — don't re-box a value as a `#theorem`.

- **Verify.** Prove → check an adversarial step. Evaluate → recompute a second
  way or numerically. Find-all → show sufficiency *and* "no others". Optimize →
  give the witness and the equality case. Count → check small cases by hand.

## Honesty

Don't fabricate a step you can't fill. Report the gap. For an original or
extended problem, if a statement turns out to be unprovable, you mis-stated it
— give the counterexample, then the corrected statement. A wrong proof is worse
than no proof.

## Bilingual (Thai)

Thai siblings share the English file's number with `-th` on the slug
(`calc-001-x.typ` → `calc-001-x-th.typ`; see CONVENTIONS → Bilingual siblings).
Write English first.

- Translate the **prose** — headings, explanations, `reason:` text, insights.
  Keep all math, symbols, and proper nouns (Cauchy–Schwarz, Fubini). `cite`
  links stay; only the display name is translated.
- Short sentences. One idea each. Don't stack `ซึ่ง…ที่…โดยที่…` clauses.
- **Register: semi-formal (กึ่งทางการ).** Use "เรา" (เราจะแสดงว่า…,
  เราจึงได้…) and natural connectives (พิจารณา, สังเกตว่า, จะได้ว่า, ดังนั้น,
  นั่นคือ). Not stiff textbook prose.

## Tools (`src/components.typ`, `src/theorems.typ`)

| Tool | For |
|------|-----|
| `theorem` / `lemma` / `corollary` / `proposition` | a numbered result you prove |
| `definition` | a definition |
| `step(reason: …)` | a justified solution step |
| `proof` | a formal proof block (auto QED) |
| `insight` | the key idea callout |
| `answer` | boxed final answer (evaluate/find problems) |
| `cite(name, url:/ref:)` | link a named result you use |
| `diagram(body, caption:)` | a CeTZ figure |
| `numbered(eq)` | number an equation you refer back to |
| `remark` / `example` / `comparison` | asides, tables |

Math is always Typst `$…$` — never plain-text a formula. Equations are
unnumbered by default; wrap only the ones you reference back in `numbered(...)`.
Titles are plain strings — no `$math$`.

## Before committing

- `make compile P=<topic>-NNN` passes, and so does the `-th` sibling if one exists.
- No `[ref?]` markers — every used theorem/rule/technique has a cite.
- No skipped steps.
- Diagram included if the math is visual.
- Problem statement is in your own words if the source had prose; `source` set
  (or `""` for an original problem).
- `make index` run.
