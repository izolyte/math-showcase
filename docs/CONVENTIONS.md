# Conventions

Naming and git rules for the repo. For what goes inside a problem file, start
from [`../problems/_TEMPLATE.typ`](../problems/_TEMPLATE.typ) - it has the
sections, the metadata fields, and a checklist commented inline.

The patterns:

| Thing | Pattern | Example |
|-------|---------|---------|
| File | `problems/<topic>-<###>-<slug>.typ` | `calc-001-gamma-integral.typ` |
| Branch | `<action>/<topic>-<###>-<slug>` | `problem/calc-001-gamma-integral` |
| Issue / PR title | `<action>(<topic>-<###>): <text>` | `add(calc-001): gamma integral` |

`<topic>` and `<action>` are fixed sets (below). `main` always has to compile.

## Topics

Every problem has one primary topic, and the prefix is the first part of the
file name. A problem that mixes areas still picks one primary topic; the rest go
into its `tags`.

The list lives in [`../topics.txt`](../topics.txt). The scripts, the pre-commit
hook, and CI all read it from there, and the tables in the docs are filled in
from it by `make topics`. So to add a topic, edit `topics.txt` and run
`make topics` - don't edit the table below by hand (CI fails if it drifts).

<!-- TOPICS:START table (generated from topics.txt by `make topics`) -->
| Prefix | Topic |
|--------|-------|
| `calc` | Calculus |
| `linalg` | Linear Algebra |
| `alg` | Abstract Algebra |
| `analysis` | Real Analysis |
| `complex` | Complex Analysis |
| `nt` | Number Theory |
| `combo` | Combinatorics |
| `prob` | Probability |
| `topo` | Topology |
| `ode` | Differential Equations |
<!-- TOPICS:END -->

## File names

```
problems/<topic>-<###>-<slug>.typ
```

- `<topic>`: a prefix from the table above.
- `<###>`: zero-padded number, unique within the topic (`001`, `002`, ...).
- `<slug>`: short, lowercase, hyphenated.

```
calc-001-gamma-integral.typ
linalg-002-cayley-hamilton.typ
nt-003-gaussian-prime.typ
```

You don't pick the number yourself - `make new T=<topic> S=<slug>` finds the
next free one and copies the template. The pre-commit hook and CI reject any
file in `problems/` that doesn't match the pattern (`_TEMPLATE.typ` is exempt).

### Bilingual (Thai) siblings

A problem can have a Thai-language sibling. It is a separate file (one language
per file, like one problem per file) that **shares the English file's number**
and appends `-th` to the slug:

```text
calc-001-gamma-integral.typ        English (primary, write first)
calc-001-gamma-integral-th.typ     Thai sibling, same problem, same number
```

The `-th` form still matches the file-name pattern (`-th` is part of the slug),
so no file-name validation change is needed. The Thai file does **not** get a new
number from `make new`; copy the English file and rename it by hand. Thai
rendering relies on the Thai serif faces in the font fallback
(see [`../src/style.typ`](../src/style.typ)); CI installs them via
`fonts-thai-tlwg`.

## Branches

```
<action>/<topic>-<###>-<slug>
```

`<action>` is one of five:

| Action | For |
|--------|-----|
| `problem` | a new problem |
| `fix` | correcting a wrong or incomplete solution |
| `improve` | clarifying an explanation that isn't wrong |
| `template` | changing files in `src/` |
| `refs` | references |

```
problem/calc-001-gamma-integral
fix/linalg-002-missing-eigenvalue-case
improve/nt-003-clarify-euclidean-steps
template/add-lemma-env
refs/calculus-integration-videos
```

## Issue and PR titles

Same pattern for both:

```
<action>(<topic>-<###>): <text>
```

```
add(calc-004): Basel problem via Euler's proof
fix(linalg-002): step 3 skips the degenerate matrix case
improve(calc-001): step 2 explanation too brief
template: add lemma and corollary environments
refs(nt): missing number theory prerequisite links
```

`template` and repo-wide `refs` changes can drop the `(<topic>-<###>)` part.

## Sourcing results

A hard invariant for every solution: **any result used but not proved in the
file must be traceable.** A named theorem, rule, or technique you invoke without
proving carries a reference the reader can follow — `cite(name, url: ...)` for an
online source or `cite(name, ref: [Book, §x])` for an offline one. Steps that
follow from earlier lines or your own algebra need no citation; elementary
background (commutativity, basic arithmetic) is assumed, not cited. A `cite` with
no source renders a red `[ref?]` marker so the gap is caught before shipping.

## Workflow

```
1. open an issue        add(calc-001): gamma integral
2. branch from main     problem/calc-001-gamma-integral
3. write the solution   (fill in the template)
4. PR, squash-merge, close the issue
5. delete the branch
```

Everything on `main` compiles, and every problem file compiles on its own. CI
checks this on every push and PR.

## Versioning

No version numbers, no changelog. The git history and closed issues are the
record.
