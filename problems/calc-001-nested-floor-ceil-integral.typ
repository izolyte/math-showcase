#import "../src/template.typ": *
#import "../src/theorems.typ": theorem, lemma, corollary, proposition, definition, proof, insight, step, remark, example
#import "../src/components.typ": comparison, figure-image, cite, numbered, answer, diagram
#import "../src/style.typ": default-theme
#import "@preview/cetz:0.3.4"

#show: doc.with(
  title: "A Nested Floor–Ceiling Integral",
  source: "MIT Integration Bee 2026, Qualifying Round, #15",
  source_url: "https://math.mit.edu/~yyao1/pdf/qualifying_round_2026_answers.pdf",
  source_license: "All rights reserved",
  date: "2026-06-20",
  tags: ("calculus", "floor-ceiling", "definite-integral"),
  prerequisites: (
    (name: "Floor and ceiling functions", url: "https://en.wikipedia.org/wiki/Floor_and_ceiling_functions"),
    (name: "Fractional part", url: "https://en.wikipedia.org/wiki/Fractional_part"),
    (name: "Integrating step functions", url: none),
  ),
  resources: (
    (title: "Floor and ceiling functions (Wikipedia)", url: "https://en.wikipedia.org/wiki/Floor_and_ceiling_functions"),
    (title: "Triangular number (Wikipedia)", url: "https://en.wikipedia.org/wiki/Triangular_number"),
  ),
)

= Problem Statement

Evaluate the following definite integral:

$ integral_0^1000 (floor(ceil(x)) + ceil(floor(x)) + floor(lr(\{ x \})) + lr(\{ floor(x) \}) + ceil(lr(\{ x \})) + lr(\{ ceil(x) \})) dif x, $

where $floor(dot)$ denotes the floor function, $ceil(dot)$ denotes the ceiling function, and $lr(\{ x \}) = x - floor(x)$ represents the fractional part of $x$.

#answer[$ integral_0^1000 (dots.c) dif x = 1000 dot 1001 = 1\,001\,000. $]

= Setup and Notation

#definition(title: "Floor, Ceiling, and Fractional Part Functions")[
  For any real number $x$, $floor(x)$ is defined as the greatest integer less than or equal to $x$, 
  and $ceil(x)$ is defined as the least integer greater than or equal to $x$. The fractional 
  part of $x$ is defined as $lr(\{ x \}) = x - floor(x)$, which satisfies the inequality 
  $0 lt.eq lr(\{ x \}) < 1$ for all $x in RR$.
]

The solution is governed by two fundamental properties. First, if $n in ZZ$, applying any of the three functions yields a trivial result: $floor(n) = ceil(n) = n$ and $lr(\{ n \}) = 0$. 

Second, if $x$ is a non-integer lying within the open unit interval $(k, k+1)$ for some integer $k in ZZ$, it follows that:
$ floor(x) = k, quad ceil(x) = k+1, quad lr(\{ x \}) in (0, 1). $

#diagram(caption: [
  For $x in (k, k+1)$: the floor drops left to $k$, the ceiling rises right to $k+1$, and the fractional part $lr(\{x\}) = x - k$ lies strictly inside $(0, 1)$.
])[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *
    let acc = default-theme.accent
    line((-0.4, 0), (4.7, 0), mark: (end: ">"))
    line((0, -0.1), (0, 0.1))
    line((4, -0.1), (4, 0.1))
    content((0, -0.38), text(size: 8pt)[$k$])
    content((4, -0.38), text(size: 8pt)[$k+1$])
    content((4.6, -0.3), text(size: 8pt)[$x$])
    let xp = 2.5
    circle((xp, 0), radius: 0.07, fill: acc, stroke: none)
    content((xp, 0.35), text(size: 8pt, fill: acc)[$x$])
    line((xp - 0.12, -0.5), (0.12, -0.5), mark: (end: ">"), stroke: acc)
    content((xp / 2, -0.85), text(size: 8pt, fill: acc)[$floor(x) = k$])
    line((xp + 0.12, 0.5), (3.88, 0.5), mark: (end: ">"), stroke: luma(140))
    content(((xp + 4) / 2, 0.85), text(size: 8pt, fill: luma(140))[$ceil(x) = k+1$])
    line((0, -1.3), (xp, -1.3), stroke: (paint: acc, dash: "dashed"))
    line((0, -1.22), (0, -1.38))
    line((xp, -1.22), (xp, -1.38))
    content((xp / 2, -1.65), text(size: 8pt)[$lr(\{x\}) in (0,1)$])
  })
]

Over the interval of integration $[0, 1000]$, the variable $x$ remains non-negative everywhere, thereby eliminating any sign-related subtleties.

= Core Idea

#insight[
  Of the six terms in the integrand, five serve as #emph[decoys] that can be systematically reduced. Because the floor and ceiling functions always map to integers, and any such function applied to an integer acts as the identity, the nested terms collapse rapidly into $ceil(x)$, $floor(x)$, and three zeros.
  
  The critical component is the term $ceil(lr(\{ x \}))$ — #emph[the lone survivor]. While its counterpart $floor(lr(\{ x \}))$ vanishes to $0$, the ceiling of any value strictly bounded between $0$ and $1$ is precisely $1$. This term alone contributes an additional area of $integral_0^1000 1 dif x = 1000$ to the integral.
]

Excluding the set of integers (which, being of #emph[measure zero], do not alter the value of the integral), the entire integrand simplifies to $ceil(x) + floor(x) + 1 = 2 ceil(x)$. This is a classical #emph[step function], and evaluating the integral reduces to computing the area beneath this staircase trajectory.

#diagram(caption: [
  The integrand remains constant on each open subinterval $(k, k+1)$, satisfying $2 ceil(x) = 2(k+1)$.
  The total area is the sum of these rectangular segments, which over the interval $[0, N]$ yields $N(N+1)$.
])[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *
    let acc = default-theme.accent
    let s = 0.32                       // y-scale: drawn height = value * s
    line((0, 0), (3.7, 0), mark: (end: ">"))
    line((0, 0), (0, 6 * s + 0.6), mark: (end: ">"))
    for pair in ((0, 2), (1, 4), (2, 6)) {
      let (k, v) = pair
      rect((k, 0), (k + 1, v * s), fill: acc.lighten(82%), stroke: acc)
      content((k + 0.5, v * s + 0.24), text(size: 8pt, fill: acc)[#v])
    }
    for tx in (1, 2, 3) {
      line((tx, -0.06), (tx, 0.06))
      content((tx, -0.3), text(size: 8pt)[$#tx$])
    }
    content((3.6, -0.3), text(size: 8pt)[$x$])
    content((0.9, 6 * s + 0.45), text(size: 8pt, fill: acc)[$y = 2 ceil(x)$])
  })
]

= Solution

#step(reason: [Idempotency and integer identities under functional nesting])[
  Since $floor(x)$ and $ceil(x)$ map exclusively to the set of integers for all $x in RR$, nesting them further within these functions preserves their initial values, while their fractional parts vanish:
  $ floor(ceil(x)) = ceil(x), quad ceil(floor(x)) = floor(x), quad
    lr(\{ floor(x) \}) = 0, quad lr(\{ ceil(x) \}) = 0. $
  This effectively resolves and simplifies four of the six terms.
]

#step(reason: [Bounding the codomain of the fractional part])[
  By definition, $0 lt.eq lr(\{ x \}) < 1$, which forces the floor of the fractional part to be identically zero:
  $ floor(lr(\{ x \})) = 0. $
  Conversely, for the ceiling component, when $x in.not ZZ$, we have $lr(\{ x \}) in (0, 1)$. The least integer greater than or equal to a value strictly bounded between $0$ and $1$ is exactly $1$:
  $ ceil(lr(\{ x \})) = 1 quad (x in.not ZZ). $

  #diagram(caption: [
    Since $lr(\{x\}) in (0,1)$ for non-integers, the floor always rounds down to $0$ while the ceiling always rounds up to $1$ — the asymmetry at the heart of this problem.
  ])[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *
      let acc = default-theme.accent
      line((-0.4, 0), (4.7, 0), mark: (end: ">"))
      line((0, -0.1), (0, 0.1))
      line((4, -0.1), (4, 0.1))
      content((0, -0.38), text(size: 8pt)[$0$])
      content((4, -0.38), text(size: 8pt)[$1$])
      content((4.65, -0.3), text(size: 8pt)[$lr(\{x\})$])
      circle((0, 0), radius: 0.09, fill: white, stroke: luma(120) + 0.8pt)
      circle((4, 0), radius: 0.09, fill: white, stroke: luma(120) + 0.8pt)
      let xp = 2.5
      circle((xp, 0), radius: 0.07, fill: acc, stroke: none)
      line((xp - 0.12, -0.5), (0.15, -0.5), mark: (end: ">"), stroke: luma(150))
      content((xp / 2, -0.85), text(size: 8pt, fill: luma(120))[$floor(lr(\{x\})) = 0$])
      line((xp + 0.12, 0.5), (3.85, 0.5), mark: (end: ">"), stroke: acc)
      content(((xp + 4) / 2, 0.85), text(size: 8pt, fill: acc)[$ceil(lr(\{x\})) = 1$])
    })
  ]
  (Note that at integer points, $lr(\{ x \}) = 0$, causing this term to vanish. However, because integers constitute a finite subset of $[0, 1000]$, they exert no influence on the Riemann integral.)
]

#step(reason: [Algebraic synthesis of the integrand on $(k, k+1)$])[
  For any non-integer $x$ belonging to the interval $(k, k+1)$, summing the six components yields:
  $ underbrace(ceil(x), k+1) + underbrace(floor(x), k) + underbrace(0, floor(lr(\{ x \}))) + underbrace(0, lr(\{ floor(x) \})) + underbrace(1, ceil(lr(\{ x \}))) + underbrace(0, lr(\{ ceil(x) \}))
    = 2k + 2 = 2(k+1) = 2 ceil(x). $
]

#step(reason: [Piecewise integration of the step function])[
  Because the integrand is constant with a value of $2(k+1)$ on each subinterval $(k, k+1)$ for $k = 0, 1, dots, 999$, integrating over these unit intervals preserves the constant value. Thus,
  $ integral_0^1000 (dots.c) dif x = sum_(k=0)^999 integral_k^(k+1) 2(k+1) dif x
    = sum_(k=0)^999 2(k+1) = 2 sum_(j=1)^1000 j. $

  #remark[
    Integrating a constant $c$ over a unit interval gives $integral_k^(k+1) c dif x = c dot 1 = c$. Each staircase rectangle has width $1$ and height $2(k+1)$, so its area is simply $2(k+1)$ — #emph[no antiderivative required].
  ]
]

#step(reason: [Evaluation of the arithmetic series via Gauss pairing])[
  Pairing the $j$-th term with the $(1001 - j)$-th term yields $1000$ identical sums of $1001$:
  #remark[
    Gauss's trick: pair each $j$ with $1001-j$. Every pair sums to $1001$, and there are $1000$ such pairs, so $2 sum_(j=1)^1000 j = 1000 times 1001$ without needing the closed-form formula.
  ]
  $ 2 sum_(j=1)^1000 j = sum_(j=1)^1000 (j + (1001 - j)) = sum_(j=1)^1000 1001 = 1000 dot 1001. $
  Consequently,
  $ integral_0^1000 (dots.c) dif x = 1000 dot 1001 = 1\,001\,000. $
]

= Verification

#strong[Independent Term-by-Term Integration:] We can integrate $floor(x)$, $ceil(x)$, and the constant function $1$ independently over the domain $[0, 1000]$:
$ integral_0^1000 floor(x) dif x = sum_(k=0)^999 k = 499\,500, quad
  integral_0^1000 ceil(x) dif x = sum_(k=1)^1000 k = 500\,500, quad
  integral_0^1000 1 dif x = 1000. $
Summing these individual results yields $499\,500 + 500\,500 + 1000 = 1\,001\,000$, which perfectly matches our initial result.

#diagram(caption: [
  On each subinterval, $ceil(x)$ exceeds $floor(x)$ by exactly $1$ (shaded strip), so $integral_0^N (ceil(x) - floor(x)) dif x = N$.
])[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *
    let acc = default-theme.accent
    let s = 0.38
    line((-0.3, 0), (3.7, 0), mark: (end: ">"))
    line((0, 0), (0, 3 * s + 0.7), mark: (end: ">"))
    for k in (0, 1, 2) {
      if k > 0 {
        rect((k, 0), (k + 1, k * s), fill: luma(220), stroke: luma(170) + 0.6pt)
        content((k + 0.5, k * s / 2), text(size: 7pt, fill: luma(100))[$#k$])
      }
      rect((k, k * s), (k + 1, (k + 1) * s), fill: acc.lighten(72%), stroke: acc + 0.6pt)
      content((k + 0.5, k * s + s / 2), text(size: 7pt, fill: acc)[$+1$])
    }
    for tx in (1, 2, 3) {
      line((tx, -0.06), (tx, 0.06))
      content((tx, -0.28), text(size: 8pt)[$#tx$])
    }
    content((3.6, -0.28), text(size: 8pt)[$x$])
  })
]

#strong[Pointwise Evaluation:] Consider a test point $x = 1.7$ (which corresponds to $k = 1$):
$floor(ceil(1.7)) = floor(2) = 2$, $ceil(floor(1.7)) = ceil(1) = 1$,
$floor(lr(\{ 1.7 \})) = floor(0.7) = 0$, $lr(\{ floor(1.7) \}) = lr(\{ 1 \}) = 0$,
$ceil(lr(\{ 1.7 \})) = ceil(0.7) = 1$, $lr(\{ ceil(1.7) \}) = lr(\{ 2 \}) = 0$.
The total sum is $2 + 1 + 0 + 0 + 1 + 0 = 4 = 2 ceil(1.7)$. #sym.checkmark

#strong[Inductive Case Scaling:] Generalizing the integral over the interval $[0, N]$ using identical reasoning yields $N(N+1)$. Setting $N = 2$, the function $2 ceil(x)$ equals $2$ on $(0,1)$ and $4$ on $(1,2)$. The total area is $2 + 4 = 6 = 2 dot 3$. #sym.checkmark

= Reflection and Deeper Perspectives

The elegance of this problem lies in the structural asymmetry between the terms $floor(lr(\{ x \}))$ and $ceil(lr(\{ x \}))$ which superficially resemble a symmetric pair. Because the codomain of the fractional part function is restricted to $[0, 1)$, its floor is identically zero everywhere, whereas its ceiling evaluates to $1$ almost everywhere except at integer coordinates. If one misinterprets the fifth term as being symmetric to the third, the resulting calculation collapses to the deceptively elegant but #emph[incorrect] answer of $1\,000\,000$, which serves as the #emph[primary trap] of the question.

#diagram(caption: [
  If $ceil(lr(\{x\}))$ is mistakenly set to $0$, the integrand becomes $2k+1$ (gray) instead of $2k+2$. The shaded strips (height $1$ per unit interval) are the missing $1000$.
])[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *
    let acc = default-theme.accent
    let s = 0.3
    line((-0.3, 0), (3.7, 0), mark: (end: ">"))
    line((0, 0), (0, 7 * s + 0.5), mark: (end: ">"))
    for k in (0, 1, 2) {
      let hw = (2 * k + 1) * s
      let hc = (2 * k + 2) * s
      rect((k, 0), (k + 1, hw), fill: luma(225), stroke: luma(170) + 0.6pt)
      rect((k, hw), (k + 1, hc), fill: acc.lighten(68%), stroke: acc + 0.6pt)
      content((k + 0.5, hw / 2), text(size: 7pt, fill: luma(100))[$#{2 * k + 1}$])
      content((k + 0.5, hw + s / 2), text(size: 7pt, fill: acc)[$+1$])
    }
    for tx in (1, 2, 3) {
      line((tx, -0.06), (tx, 0.06))
      content((tx, -0.28), text(size: 8pt)[$#tx$])
    }
    content((3.6, -0.28), text(size: 8pt)[$x$])
  })
]

From a rigorous analytical perspective, the integrand does not equal $2 ceil(x)$ at integer boundary points, since $ceil(lr(\{ x \})) = 0$ and $ceil(x) = floor(x)$ at those locations. However, because these two bounded functions differ only on a finite set—which constitutes a set of #emph[measure zero]—their definite Riemann integrals are identical. Thus, the piecewise staircase methodology remains mathematically sound.

In the general case (for integers $N gt.eq 0$), the integral can be elegantly formulated as:
$ integral_0^N (dots.c) dif x = N(N+1) = 2 dot (N(N+1))/2, $
which corresponds to twice the $N$-th triangular number. The specific solution of $1\,001\,000$ given in the problem statement is simply the particular realization of this general rule evaluated at $N = 1000$.

#diagram(caption: [
  $N=4$ example: filled dots $= T_4 = 1+2+3+4 = 10$, all dots $= 4 times 5 = 20 = 2T_4$, so $sum_(j=1)^N j = N(N+1) slash 2$.
])[
  #cetz.canvas(length: 0.85cm, {
    import cetz.draw: *
    let acc = default-theme.accent
    let sp = 0.48
    for i in range(4) {
      for j in range(5) {
        let x = j * sp
        let y = i * sp
        if j <= i {
          circle((x, y), radius: 0.13, fill: acc, stroke: none)
        } else {
          circle((x, y), radius: 0.13, fill: luma(235), stroke: luma(190) + 0.5pt)
        }
      }
    }
  })
]