#import "../src/template.typ": *
#import "../src/theorems.typ": theorem, lemma, corollary, proposition, definition, proof, insight, step, remark, example
#import "../src/components.typ": comparison, figure-image, cite, numbered, answer, diagram
#import "../src/style.typ": default-theme
#import "@preview/cetz:0.3.4"

#show: doc.with(
  title: "Cosine Power–Cosine Fourier Integral",
  source: "Romanian Mathematical Magazine, proposed by K. Srinivasa Raghava",
  source_url: none,
  source_license: "All rights reserved",
  date: "2026-06-21",
  tags: ("calculus", "definite-integral", "special-functions", "gamma-function", "beta-function", "complex-analysis", "fourier-analysis", "trigonometry", "induction", "analytic-continuation", "combinatorics"),
  prerequisites: (
    (name: "Mathematical induction", url: "https://en.wikipedia.org/wiki/Mathematical_induction"),
    (name: "Integration by parts", url: "https://en.wikipedia.org/wiki/Integration_by_parts"),
    (name: "Product-to-sum identities", url: "https://en.wikipedia.org/wiki/List_of_trigonometric_identities#Product-to-sum_and_sum-to-product_identities"),
    (name: "Euler's formula", url: "https://en.wikipedia.org/wiki/Euler%27s_formula"),
    (name: "Binomial theorem", url: "https://en.wikipedia.org/wiki/Binomial_theorem"),
    (name: "Gamma function", url: "https://en.wikipedia.org/wiki/Gamma_function"),
    (name: "Beta function", url: "https://en.wikipedia.org/wiki/Beta_function"),
    (name: "Euler reflection formula", url: "https://en.wikipedia.org/wiki/Reflection_formula"),
    (name: "Analytic continuation", url: "https://en.wikipedia.org/wiki/Analytic_continuation"),
    (name: "Carlson's theorem", url: "https://en.wikipedia.org/wiki/Carlson%27s_theorem"),
  ),
  resources: (
    (title: "Wallis integrals (Wikipedia)", url: "https://en.wikipedia.org/wiki/Wallis%27_integrals"),
    (title: "Binomial theorem (Wikipedia)", url: "https://en.wikipedia.org/wiki/Binomial_theorem"),
    (title: "Vandermonde–Chu identity / Beta function sum (Wikipedia)", url: "https://en.wikipedia.org/wiki/Vandermonde%27s_identity"),
    (title: "Euler's formula (Wikipedia)", url: "https://en.wikipedia.org/wiki/Euler%27s_formula"),
    (title: "Euler reflection formula (Wikipedia)", url: "https://en.wikipedia.org/wiki/Reflection_formula"),
    (title: "Legendre duplication formula (Wikipedia)", url: "https://en.wikipedia.org/wiki/Multiplication_theorem#Legendre_duplication_formula"),
    (title: "Carlson's theorem (Wikipedia)", url: "https://en.wikipedia.org/wiki/Carlson%27s_theorem"),
    (title: "Related discussion (Math StackExchange, CC BY-SA 4.0)", url: "https://math.stackexchange.com/questions/456899"),
  ),
)

= Problem Statement

For real parameters satisfying $beta > alpha > -1$, evaluate

$ integral_0^(pi slash 2) cos^alpha(x) cos(beta x) dif x. $

#answer[
  $ integral_0^(pi slash 2) cos^alpha(x) cos(beta x) dif x
    = frac(pi, 2^(alpha+1))
      dot frac(Gamma(alpha+1),
               Gamma(frac(alpha+beta,2)+1) dot Gamma(frac(alpha-beta,2)+1)). $
]

= Setup and Notation

#definition(title: "Gamma function")[
  The #emph[Gamma function] $Gamma : CC without {0,-1,-2,dots.c} arrow CC$ is defined for
  $op("Re")(z) > 0$ by
  $ Gamma(z) = integral_0^oo t^(z-1) e^(-t) dif t $
  and extended meromorphically to all of $CC$, with simple poles at the non-positive
  integers. Two properties are used throughout:
  - #cite([Recurrence: $Gamma(z+1) = z Gamma(z)$],
      url: "https://en.wikipedia.org/wiki/Gamma_function#Properties"),
    which gives $Gamma(n+1) = n!$ for $n in NN_0 := {0, 1, 2, dots.c}$; and
  - Special values: $Gamma(1) = 1$ and $Gamma(1 slash 2) = sqrt(pi)$.
]

Write $I(alpha, beta) := integral_0^(pi slash 2) cos^alpha(x) cos(beta x) dif x$ and define the
candidate closed form
$ F(alpha, beta) :=
    frac(pi, 2^(alpha+1))
    dot frac(Gamma(alpha+1),
             Gamma(frac(alpha+beta,2)+1) dot Gamma(frac(alpha-beta,2)+1)). $
The goal is to establish $I(alpha, beta) = F(alpha, beta)$ for all $beta > alpha > -1$.

The integrand blends a decaying envelope $cos^alpha(x)$ — which concentrates near $x = 0$
and vanishes at $x = pi slash 2$ for $alpha > 0$ — with the higher-frequency oscillation
$cos(beta x)$, whose sign changes partially cancel the accumulated area.

#diagram(caption: [
  The integrand $cos(x) cos(2x)$ for $alpha = 1$, $beta = 2$ on $[0, pi slash 2]$. It is
  positive on $(0, pi slash 4)$ where $cos(2x) > 0$ (accent shading), crosses zero at
  $x = pi slash 4$, then dips negative on $(pi slash 4, pi slash 2)$ (gray shading). The
  positive strip is wider than the dip, giving a net signed area of $1 slash 3$ — verified
  numerically in the Verification section.
])[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *
    let acc = default-theme.accent
    let N  = 40
    let xs = 4.5 / (calc.pi / 2)
    let ys = 2.2
    for i in range(0, N) {
      let xv = float(i) / float(N) * calc.pi / 4
      let yv = calc.cos(xv) * calc.cos(2.0 * xv) * ys
      if yv > 0 {
        line((xv * xs, 0.0), (xv * xs, yv), stroke: acc.lighten(70%) + 0.5pt)
      }
    }
    for i in range(0, N) {
      let xv = calc.pi / 4 + float(i) / float(N) * calc.pi / 4
      let yv = calc.cos(xv) * calc.cos(2.0 * xv) * ys
      if yv < 0 {
        line((xv * xs, 0.0), (xv * xs, yv), stroke: luma(185) + 0.5pt)
      }
    }
    let pxd = 0.0
    let pyd = 1.0 * ys
    for i in range(1, 2 * N + 1) {
      let xv = float(i) / float(2 * N) * calc.pi / 2
      let yv = calc.cos(xv) * calc.cos(2.0 * xv) * ys
      line((pxd, pyd), (xv * xs, yv), stroke: acc + 1pt)
      pxd = xv * xs
      pyd = yv
    }
    line((-0.3, 0), (5.1, 0), mark: (end: ">"))
    line((0, -0.68), (0, 2.65), mark: (end: ">"))
    content((5.06, -0.32), text(size: 8pt)[$x$])
    content((-0.28, 2.62), text(size: 8pt)[$y$])
    let p4x = calc.pi / 4 * xs
    let p2x = calc.pi / 2 * xs
    line((p4x, -0.1), (p4x, 0.1))
    line((p2x, -0.1), (p2x, 0.1))
    line((-0.1, ys), (0.1, ys))
    content((p4x, -0.4), text(size: 8pt)[$pi\/4$])
    content((p2x, -0.4), text(size: 8pt)[$pi\/2$])
    content((-0.32, ys), text(size: 8pt)[$1$])
    content((p4x * 0.46, 0.40 * ys), text(size: 8pt, fill: acc)[$+$])
    content((p4x + (p2x - p4x) * 0.52, -0.17 * ys), text(size: 8pt, fill: luma(90))[$-$])
    content((4.55, 1.82), text(size: 8pt, fill: acc)[$cos(x)cos(2x)$])
    circle((p4x, 0), radius: 0.07, fill: acc, stroke: none)
  })
]

= Idea

#insight[
  The proof proceeds by #emph[strong induction on $n = alpha in NN_0$] to
  establish $I(n, beta) = F(n, beta)$ for every non-negative integer $n$, then invokes
  #emph[analytic continuation] to extend the result to all real $alpha > -1$.

  - #strong[Base case ($n = 0$).] The integrand collapses to $cos(beta x)$, whose
    antiderivative is elementary. Matching the result against $F(0, beta)$ requires
    the #emph[Euler reflection formula] $Gamma(z) Gamma(1 - z) = pi slash sin(pi z)$,
    which converts the product $Gamma(beta slash 2) Gamma(1 - beta slash 2)$ into a
    single sine — exactly cancelling $pi slash beta$ to leave $sin(beta pi slash 2) slash beta$.

  - #strong[Inductive step ($n-1 arrow n$).] Integration by parts with
    $u = cos^n(x)$ and $dif v = cos(beta x) dif x$ eliminates the boundary terms
    (because $cos^n(pi slash 2) = 0$ for $n gt.eq 1$) and produces an integrand
    containing $sin(x) sin(beta x)$. The #emph[product-to-sum identity]
    $sin(x) sin(beta x) = frac(1,2)[cos((beta-1)x) - cos((beta+1)x)]$
    then splits this into two integrals of the same type at one lower power,
    giving the recursion
    $ I(n, beta) = frac(n, 2 beta) lr([I(n-1, beta-1) - I(n-1, beta+1)]). $
    A direct algebraic check (Step 3) shows $F$ satisfies the #emph[identical]
    recursion, so the inductive hypothesis closes the step cleanly.

  - #strong[Extension to real $alpha > -1$.] Both $I(alpha, beta)$ and
    $F(alpha, beta)$ are analytic in $alpha$ on $op("Re")(alpha) > -1$, bounded on
    $op("Re")(alpha) gt.eq 0$, and coincide on $NN_0$. By #emph[Carlson's theorem],
    such a function vanishing on $NN_0$ must be identically zero, so
    $I(alpha, beta) - F(alpha, beta) equiv 0$ throughout $op("Re")(alpha) > -1$.
]

#diagram(caption: [
  The inductive decomposition: $I(n, beta)$ branches into $I(n-1, beta-1)$ (positive
  weight, accent) and $I(n-1, beta+1)$ (negative weight, gray). After $n$ rounds
  every branch terminates at a base case $I(0, gamma) = sin(gamma pi slash 2) slash gamma$.
])[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *
    let acc = default-theme.accent
    let bw  = 1.55
    let bh  = 0.42
    let draw-box(cx, cy, lbl, bg) = {
      rect((cx - bw, cy - bh), (cx + bw, cy + bh),
           fill: bg, stroke: acc + 0.65pt, radius: 0.1)
      content((cx, cy), text(size: 7.5pt)[$#lbl$])
    }
    draw-box(3.7, 4.0, [I(n, beta)], acc.lighten(78%))
    draw-box(1.3, 2.0, [I(n-1, beta-1)], acc.lighten(90%))
    draw-box(6.1, 2.0, [I(n-1, beta+1)], luma(232))
    line((3.7 - 0.4, 4.0 - bh), (1.3 + 0.55, 2.0 + bh),
         mark: (end: ">"), stroke: acc + 0.8pt)
    line((3.7 + 0.4, 4.0 - bh), (6.1 - 0.55, 2.0 + bh),
         mark: (end: ">"), stroke: luma(110) + 0.8pt)
    content((2.15, 3.2), text(size: 7pt, fill: acc)[$+frac(n,2beta)$])
    content((5.25, 3.2), text(size: 7pt, fill: luma(80))[$-frac(n,2beta)$])
    draw-box(0.1,  0.0, [I(0, beta-n)], acc.lighten(95%))
    draw-box(3.7,  0.0, [$dots.c$],     acc.lighten(95%))
    draw-box(7.3,  0.0, [I(0, beta+n)], acc.lighten(95%))
    line((1.3 - 0.5, 2.0 - bh), (0.2,  0.0 + bh), mark: (end: ">"), stroke: luma(155) + 0.6pt)
    line((1.3 + 0.6, 2.0 - bh), (3.5,  0.0 + bh), mark: (end: ">"), stroke: luma(155) + 0.6pt)
    line((6.1 - 0.2, 2.0 - bh), (3.9,  0.0 + bh), mark: (end: ">"), stroke: luma(155) + 0.6pt)
    line((6.1 + 0.6, 2.0 - bh), (7.1,  0.0 + bh), mark: (end: ">"), stroke: luma(155) + 0.6pt)
    content((3.7, -0.82),
      text(size: 7.5pt, fill: luma(100))[base: $I(0,gamma) = sin(gamma pi slash 2) slash gamma$])
  })
]

= Proofs

== Proof I: Induction on $n$

#step(reason: [Base case $n = 0$: antiderivative and
  #cite("Euler reflection formula", url: "https://en.wikipedia.org/wiki/Reflection_formula")])[

  #strong[Subcase $beta = 0$.]
  $I(0,0) = integral_0^(pi slash 2) 1 dif x = pi slash 2$.
  From the definition of $F$ with $alpha = beta = 0$ and $Gamma(1) = 1$:
  $ F(0,0) = frac(pi, 2) dot frac(Gamma(1), Gamma(1) dot Gamma(1)) = frac(pi, 2) = I(0,0). $

  #strong[Subcase $beta eq.not 0$.]
  Since $cos^0(x) = 1$, the antiderivative of $cos(beta x)$ is $sin(beta x) slash beta$:
  $
    I(0, beta)
      &= integral_0^(pi slash 2) cos(beta x) dif x
       = lr([frac(sin(beta x), beta)])_0^(pi slash 2) \
      &= frac(sin(beta pi slash 2), beta) - frac(sin(0), beta)
       = frac(sin(beta pi slash 2), beta).
  $

  We now show $F(0, beta)$ equals the same value. Substituting $alpha = 0$ and $Gamma(1) = 1$:
  $ F(0, beta) = frac(pi, 2) dot frac(1, Gamma(frac(beta,2)+1) dot Gamma(1 - frac(beta,2))). $

  Apply the
  #cite([recurrence $Gamma(z+1) = z Gamma(z)$],
    url: "https://en.wikipedia.org/wiki/Gamma_function#Properties")
  with $z = beta slash 2$ to the first Gamma in the denominator:
  $ Gamma(frac(beta,2)+1) = frac(beta,2) dot Gamma(frac(beta,2)). $

  Substituting this into $F(0, beta)$:
  $
    F(0, beta)
      &= frac(pi, 2) dot frac(1, frac(beta,2) dot Gamma(frac(beta,2)) dot Gamma(1 - frac(beta,2))) \
      &= frac(pi, beta dot Gamma(frac(beta,2)) dot Gamma(1 - frac(beta,2))).
  $

  The #cite("Euler reflection formula",
    url: "https://en.wikipedia.org/wiki/Reflection_formula")
  states $Gamma(z) Gamma(1-z) = pi slash sin(pi z)$ for all $z in.not ZZ$.
  Setting $z = beta slash 2$ gives
  $ Gamma(frac(beta,2)) dot Gamma(1 - frac(beta,2)) = frac(pi, sin(pi beta slash 2)). $

  Substituting:
  $
    F(0, beta)
      &= frac(pi, beta) dot frac(sin(pi beta slash 2), pi)
       = frac(sin(beta pi slash 2), beta)
       = I(0, beta). quad checkmark
  $
]

#step(reason: [Integration by parts and
  #cite("product-to-sum identity",
    url: "https://en.wikipedia.org/wiki/List_of_trigonometric_identities#Product-to-sum_and_sum-to-product_identities")])[

  Fix an integer $n gt.eq 1$ and assume $I(n-1, gamma) = F(n-1, gamma)$ for all
  $gamma > n - 1$ (the inductive hypothesis; this covers $gamma = beta plus.minus 1$
  since $beta > n$ implies $beta - 1 > n - 1$). We set
  $ u = cos^n(x), quad dif v = cos(beta x) dif x, $
  so that
  $ dif u = -n cos^(n-1)(x) sin(x) dif x, quad v = frac(sin(beta x), beta). $

  Integration by parts gives
  $
    I(n, beta)
      = lr([frac(cos^n(x) sin(beta x), beta)])_0^(pi slash 2)
        + frac(n, beta) integral_0^(pi slash 2) cos^(n-1)(x) sin(x) sin(beta x) dif x.
  $

  #remark[
    The boundary term vanishes at both endpoints: at $x = 0$, $sin(0) = 0$; at
    $x = pi slash 2$, $cos^n(pi slash 2) = 0^n = 0$ (for $n gt.eq 1$). Both factors
    in the product $cos^n(x) sin(beta x)$ vanish at separate endpoints — a key
    consequence of $n gt.eq 1$ that fails at $n = 0$, which is why the base case
    was handled separately.
  ]

  With the boundary term gone:
  $ I(n, beta) = frac(n, beta) integral_0^(pi slash 2) cos^(n-1)(x) sin(x) sin(beta x) dif x. $

  Apply the #cite("product-to-sum identity",
    url: "https://en.wikipedia.org/wiki/List_of_trigonometric_identities#Product-to-sum_and_sum-to-product_identities")
  $ sin(x) sin(beta x) = frac(1,2) lr([cos((beta-1)x) - cos((beta+1)x)]) $
  to the integrand:
  $
    I(n, beta)
      &= frac(n, beta) dot frac(1,2) integral_0^(pi slash 2)
           cos^(n-1)(x) lr([cos((beta-1)x) - cos((beta+1)x)]) dif x \
      &= frac(n, 2 beta) lr([integral_0^(pi slash 2) cos^(n-1)(x) cos((beta-1)x) dif x
           - integral_0^(pi slash 2) cos^(n-1)(x) cos((beta+1)x) dif x]) \
      &= frac(n, 2 beta) lr([I(n-1, beta-1) - I(n-1, beta+1)]).
  $

  By the inductive hypothesis both $I(n-1, beta-1)$ and $I(n-1, beta+1)$ equal $F$ at
  their respective arguments:
  $ I(n, beta) = frac(n, 2 beta) lr([F(n-1, beta-1) - F(n-1, beta+1)]). $
]

#step(reason: [Algebraic verification that $F$ satisfies the same recursion])[

  We must show
  $frac(n, 2 beta) lr([F(n-1, beta-1) - F(n-1, beta+1)]) = F(n, beta)$.

  #strong[Expand $F(n-1, beta-1)$ and $F(n-1, beta+1)$.]
  Substituting $(alpha, beta) = (n-1, beta-1)$ into the definition of $F$:
  $
    F(n-1, beta-1)
      = frac(pi, 2^n) dot frac(Gamma(n),
          Gamma(frac(n+beta,2)) dot Gamma(frac(n-beta,2)+1)).
  $

  (Here the first Gamma argument is $frac((n-1)+(beta-1),2)+1 = frac(n+beta-2,2)+1 = frac(n+beta,2)$,
  and the second is $frac((n-1)-(beta-1),2)+1 = frac(n-beta,2)+1$.)

  Similarly, substituting $(alpha, beta) = (n-1, beta+1)$:
  $
    F(n-1, beta+1)
      = frac(pi, 2^n) dot frac(Gamma(n),
          Gamma(frac(n+beta,2)+1) dot Gamma(frac(n-beta,2))).
  $

  #strong[Factor the denominator using the recurrence.]
  Apply $Gamma(z+1) = z Gamma(z)$ to pull the extra factor out of each denominator:
  $
    Gamma(frac(n-beta,2)+1)
      = frac(n-beta,2) dot Gamma(frac(n-beta,2)), \
    Gamma(frac(n+beta,2)+1)
      = frac(n+beta,2) dot Gamma(frac(n+beta,2)).
  $

  This rewrites the two terms so that the same pair $Gamma(frac(n+beta,2))$ and $Gamma(frac(n-beta,2))$
  appears in both denominators:
  $
    F(n-1, beta-1)
      &= frac(pi Gamma(n), 2^n)
         dot frac(2, (n-beta) dot Gamma(frac(n+beta,2)) dot Gamma(frac(n-beta,2))), \
    F(n-1, beta+1)
      &= frac(pi Gamma(n), 2^n)
         dot frac(2, (n+beta) dot Gamma(frac(n+beta,2)) dot Gamma(frac(n-beta,2))).
  $

  #strong[Compute the difference.]
  Factoring out the common factor
  $frac(2 pi Gamma(n), 2^n dot Gamma(frac(n+beta,2)) dot Gamma(frac(n-beta,2)))$:
  $
    F(n-1, beta-1) - F(n-1, beta+1)
      &= frac(2 pi Gamma(n), 2^n dot Gamma(frac(n+beta,2)) dot Gamma(frac(n-beta,2)))
         dot lr([frac(1, n-beta) - frac(1, n+beta)]) \
      &= frac(2 pi Gamma(n), 2^n dot Gamma(frac(n+beta,2)) dot Gamma(frac(n-beta,2)))
         dot frac((n+beta)-(n-beta), (n-beta)(n+beta)) \
      &= frac(2 pi Gamma(n), 2^n dot Gamma(frac(n+beta,2)) dot Gamma(frac(n-beta,2)))
         dot frac(2 beta, n^2-beta^2).
  $

  #strong[Multiply by $n slash (2 beta)$.]
  $
    frac(n, 2 beta) lr([F(n-1,beta-1) - F(n-1,beta+1)])
      = frac(2 n pi Gamma(n),
           2^n (n^2-beta^2) Gamma(frac(n+beta,2)) Gamma(frac(n-beta,2))).
  $

  #strong[Rewrite $n^2 - beta^2$ using the recurrence.]
  The identity $(n^2 - beta^2) = (n+beta)(n-beta)$ combined with the recurrence
  $Gamma(z+1) = z Gamma(z)$ gives
  $
    (n+beta) Gamma(frac(n+beta,2))
      &= 2 dot frac(n+beta,2) dot Gamma(frac(n+beta,2))
       = 2 Gamma(frac(n+beta,2)+1), \
    (n-beta) Gamma(frac(n-beta,2))
      &= 2 dot frac(n-beta,2) dot Gamma(frac(n-beta,2))
       = 2 Gamma(frac(n-beta,2)+1).
  $

  Therefore
  $ (n^2-beta^2) Gamma(frac(n+beta,2)) Gamma(frac(n-beta,2))
    = 4 Gamma(frac(n+beta,2)+1) Gamma(frac(n-beta,2)+1). $

  Substituting:
  $
    frac(n, 2 beta) lr([F(n-1,beta-1) - F(n-1,beta+1)])
      &= frac(2 n pi Gamma(n), 2^n dot 4 Gamma(frac(n+beta,2)+1) Gamma(frac(n-beta,2)+1)) \
      &= frac(n pi Gamma(n), 2^(n+1) Gamma(frac(n+beta,2)+1) Gamma(frac(n-beta,2)+1)) \
      &= frac(pi Gamma(n+1), 2^(n+1) Gamma(frac(n+beta,2)+1) Gamma(frac(n-beta,2)+1)) \
      &= F(n, beta). quad checkmark
  $

  (The last step uses $n Gamma(n) = Gamma(n+1)$ from the recurrence.)
]

#step(reason: [Strong induction conclusion and
  #cite("Carlson's theorem",
    url: "https://en.wikipedia.org/wiki/Carlson%27s_theorem")])[

  Steps 1–3 establish $I(n, beta) = F(n, beta)$ for every $n in NN_0$ and all
  $beta in RR$ by strong induction: Step 1 is the base case, and Step 2 provides
  the recursive reduction whose algebraic correctness Step 3 verifies.

  To extend the equality to all real $alpha > -1$, observe:

  - $I(alpha, beta)$ is an analytic function of $alpha$ on $op("Re")(alpha) > -1$,
    by the dominated convergence theorem applied to differentiation under the integral
    sign (the bound $abs(cos^alpha(x) cos(beta x)) lt.eq cos^(op("Re")(alpha))(x)$
    is integrable for $op("Re")(alpha) > -1$).
  - $F(alpha, beta)$ is analytic in $alpha$ on the same half-plane, because the
    #cite("Gamma function",
      url: "https://en.wikipedia.org/wiki/Gamma_function")
    is analytic away from its poles at the non-positive integers, which lie outside
    $op("Re")(alpha) > -1$.
  - Both functions are bounded on $op("Re")(alpha) gt.eq 0$ (the integral is bounded
    by $integral_0^(pi slash 2) 1 dif x = pi slash 2$ and $F$ is bounded there
    by the growth estimates on $Gamma$).
  - They agree on the set $NN_0 = {0, 1, 2, dots.c}$, which lies within
    $op("Re")(alpha) gt.eq 0$.

  By #cite("Carlson's theorem",
    url: "https://en.wikipedia.org/wiki/Carlson%27s_theorem"),
  a function analytic and bounded on $op("Re")(z) gt.eq 0$ that vanishes on $NN_0$
  must be identically zero. The difference $I(alpha, beta) - F(alpha, beta)$
  satisfies all these conditions and vanishes on $NN_0$, so it is identically zero
  throughout $op("Re")(alpha) > -1$, and in particular for all real $alpha > -1$.
]

#theorem[
  For $beta > alpha > -1$,
  $ integral_0^(pi slash 2) cos^alpha(x) cos(beta x) dif x
    = frac(pi, 2^(alpha+1))
      dot frac(Gamma(alpha+1),
               Gamma(frac(alpha+beta,2)+1) dot Gamma(frac(alpha-beta,2)+1)). $
]

== Proof II: Complex Exponential Method

#insight[
  Instead of building the formula inductively, we #emph[dissolve $cos^n(x)$ into complex
  exponentials] via the binomial theorem, integrate each pure-frequency component in closed
  form, and collapse the resulting alternating-sign binomial sum with the
  #emph[Vandermonde–Chu identity]. The Euler reflection formula then cancels the remaining
  $Gamma(frac(beta-n,2))$ against the sine factor, yielding $F(n,beta)$ directly. The proof
  runs exactly for integer $n = alpha$; the extension to real $alpha > -1$ still uses
  Carlson's theorem — the same final step as Solution 1.
]

#diagram(caption: [
  The substitution $w = e^(-2i x)$ sends $x in (0, pi slash 2)$ to the lower arc on the unit
  circle (accent), from $w=1$ at $x=0$ through $w=-i$ at $x=pi slash 4$ to the endpoint
  $w=-1$ at $x=pi slash 2$. The open disk $|w|<1$ (shaded) is the unconditional convergence
  region of the binomial series $(1+w)^n = sum_k binom(n,k)w^k$. The path lies on the
  boundary; the endpoint $w=-1$ is the only problematic point, but $(1+w)^n=0$ there so the
  integrand vanishes and the swap of sum and integral is valid.
])[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *
    let acc = default-theme.accent
    let r   = 2.0
    let N   = 60
    circle((0, 0), radius: r, fill: acc.lighten(88%), stroke: luma(185) + 0.7pt)
    for i in range(0, N) {
      let th1 = -float(i) / float(N) * calc.pi
      let th2 = -float(i + 1) / float(N) * calc.pi
      line(
        (r * calc.cos(th1), r * calc.sin(th1)),
        (r * calc.cos(th2), r * calc.sin(th2)),
        stroke: acc + 1.8pt,
      )
    }
    line((0.22, -r + 0.06), (-0.18, -r - 0.06), mark: (end: ">"), stroke: acc + 1.3pt)
    line((-r - 0.5, 0), (r + 0.5, 0), mark: (end: ">"), stroke: luma(60) + 0.6pt)
    line((0, -r - 0.55), (0, r + 0.55), mark: (end: ">"), stroke: luma(60) + 0.6pt)
    content((r + 0.68, -0.28), text(size: 7.5pt)[$op("Re")(w)$])
    content((-0.52, r + 0.58), text(size: 7.5pt)[$op("Im")(w)$])
    circle((r, 0), radius: 0.09, fill: acc, stroke: none)
    content((r + 0.18, 0.38), text(size: 7.5pt, fill: acc)[$w=1$])
    content((r + 0.18, 0.12), text(size: 6.5pt, fill: luma(120))[$x=0$])
    circle((0, -r), radius: 0.07, fill: acc.lighten(15%), stroke: none)
    content((0.38, -r - 0.25), text(size: 7.5pt)[$w=-i$])
    content((0.38, -r - 0.5), text(size: 6.5pt, fill: luma(120))[$x=pi slash 4$])
    circle((-r, 0), radius: 0.09, fill: white, stroke: rgb("#c0392b") + 1.2pt)
    line((-r - 0.1, -0.1), (-r + 0.1, 0.1), stroke: rgb("#c0392b") + 1.2pt)
    line((-r - 0.1, 0.1), (-r + 0.1, -0.1), stroke: rgb("#c0392b") + 1.2pt)
    content((-r - 0.15, 0.44), text(size: 7.5pt, fill: rgb("#c0392b"))[$w=-1$])
    content((-r - 0.15, 0.18), text(size: 6.5pt, fill: luma(120))[$x=pi slash 2$])
    content((-0.1, 0.80), text(size: 7.5pt, fill: acc.darken(15%))[$|w|<1$])
    content((-0.1, 0.50), text(size: 6.5pt, fill: acc.darken(15%))[series converges])
    content((1.5, -1.7), text(size: 7.5pt, fill: acc)[$w = e^(-2i x)$])
  })
]

#step(reason: [Express as real part of a complex integral])[
  Write $cos(beta x) = op("Re")(e^(i beta x))$ and define
  $ J := integral_0^(pi slash 2) cos^n(x) e^(i beta x) dif x, $
  so $I(n, beta) = op("Re")(J)$. The advantage: $e^(i beta x)$ absorbs
  both $cos(beta x)$ and $sin(beta x)$ into one expression; we carry a single
  complex integrand and project onto the real axis only at the end.
]

#step(reason: [
  Expand $cos^n(x)$ by the
  #cite([binomial theorem], url: "https://en.wikipedia.org/wiki/Binomial_theorem")])[

  Write $2cos(x) = e^(i x) + e^(-i x)$ and factor out $e^(i n x)$:
  $
    cos^n(x) = frac((e^(i x) + e^(-i x))^n, 2^n)
             = frac(e^(i n x), 2^n) (1 + e^(-2i x))^n.
  $

  Apply $(1 + w)^n = sum_(k=0)^n binom(n,k) w^k$ with $w = e^(-2i x)$:
  $
    cos^n(x) = frac(1, 2^n) sum_(k=0)^n binom(n,k) e^(i(n - 2k)x).
  $

  #remark[
    The sum terminates at $k = n$ because $binom(n,k) = 0$ for integer $k > n$. The
    $n+1$ frequencies $n - 2k$ for $k = 0, 1, dots.c, n$ form the distinct arithmetic
    sequence $n, n-2, dots.c, -n$, so no two terms share a frequency and the
    decomposition is unique.
  ]

  Substituting into $J$ and swapping the (finite) sum with the integral:
  $
    J = frac(1, 2^n) sum_(k=0)^n binom(n,k) integral_0^(pi slash 2) e^(i(n+beta-2k)x) dif x.
  $
]

#step(reason: [Evaluate each exponential integral; extract the real part])[
  Set $gamma_k := n + beta - 2k$. For $gamma_k eq.not 0$, a direct antiderivative gives
  $
    integral_0^(pi slash 2) e^(i gamma_k x) dif x
      = lr([frac(e^(i gamma_k x), i gamma_k)])_0^(pi slash 2)
      = frac(e^(i gamma_k pi slash 2) - 1, i gamma_k).
  $

  Separate into real and imaginary parts by writing
  $e^(i gamma_k pi slash 2) - 1 = (cos(gamma_k pi slash 2) - 1) + i sin(gamma_k pi slash 2)$:
  $
    frac(e^(i gamma_k pi slash 2) - 1, i gamma_k)
      = frac(sin(gamma_k pi slash 2), gamma_k)
        + frac(cos(gamma_k pi slash 2) - 1, i gamma_k).
  $

  The second fraction: multiplying numerator and denominator by $-i$ turns it into
  $frac(-i (cos(gamma_k pi slash 2) - 1), gamma_k)$, which is purely imaginary.
  Therefore
  $
    op("Re") integral_0^(pi slash 2) e^(i gamma_k x) dif x
      = frac(sin(gamma_k pi slash 2), gamma_k)
      = frac(sin(frac((n+beta-2k)pi, 2)), n+beta-2k).
  $

  Assembling over all $k$:
  $
    I(n, beta) = frac(1, 2^n) sum_(k=0)^n binom(n,k)
                 frac(sin(frac((n+beta-2k)pi, 2)), n+beta-2k).
  $
]

#step(reason: [
  Factor via angle subtraction; evaluate sum by
  #cite([Vandermonde–Chu identity], url: "https://en.wikipedia.org/wiki/Vandermonde%27s_identity")])[

  #strong[Factor $sin$ out of the sum.]
  For any integer $k$, use $sin(theta - k pi) = (-1)^k sin(theta)$
  (since $cos(k pi) = (-1)^k$ and $sin(k pi) = 0$) with $theta = frac((n+beta)pi, 2)$:
  $
    sin frac((n+beta-2k)pi, 2)
      = sin(frac((n+beta)pi, 2) - k pi)
      = (-1)^k sin frac((n+beta)pi, 2).
  $
  The factor $sin frac((n+beta)pi, 2)$ is independent of $k$, so it pulls out:
  $ I(n,beta) = frac(sin(frac((n+beta)pi, 2)), 2^n) dot S_n $
  where $S_n := sum_(k=0)^n frac((-1)^k binom(n,k), n+beta-2k)$.

  #strong[Evaluate $S_n$ by substituting $j = n - k$.]
  Setting $j = n - k$ (so $k = n - j$, $(-1)^k = (-1)^n (-1)^j$, and
  $binom(n,n-j) = binom(n,j)$), and noting $n+beta-2(n-j) = beta-n+2j$:
  $
    S_n
      = sum_(j=0)^n frac((-1)^n (-1)^j binom(n,j), beta-n+2j)
      = frac((-1)^n, 2) sum_(j=0)^n frac((-1)^j binom(n,j), frac(beta-n,2)+j).
  $

  The inner sum matches the
  #cite([Vandermonde–Chu identity], url: "https://en.wikipedia.org/wiki/Vandermonde%27s_identity"):
  for $s > 0$ and integer $n gt.eq 0$,
  $
    sum_(j=0)^n frac((-1)^j binom(n,j), s+j)
      = B(s, n+1)
      = frac(Gamma(s) Gamma(n+1), Gamma(s+n+1)).
  $

  Set $s = (beta-n) slash 2$; then $s + n + 1 = (n+beta) slash 2 + 1$:
  $
    sum_(j=0)^n frac((-1)^j binom(n,j), frac(beta-n,2)+j)
      = frac(Gamma(frac(beta-n,2)) Gamma(n+1), Gamma(frac(n+beta,2)+1)).
  $

  Therefore:
  $
    S_n = frac((-1)^n, 2) dot frac(Gamma(frac(beta-n,2)) Gamma(n+1), Gamma(frac(n+beta,2)+1)).
  $

  Substituting into the equation for $I(n,beta)$:
  $
    I(n, beta)
      = frac((-1)^n sin(frac((n+beta)pi, 2)), 2^(n+1))
        dot frac(Gamma(frac(beta-n,2)) Gamma(n+1), Gamma(frac(n+beta,2)+1)).
  $
]

#step(reason: [
  Cancel $Gamma(frac(beta-n,2))$ against the sine via
  #cite([Euler reflection formula], url: "https://en.wikipedia.org/wiki/Reflection_formula")])[

  Apply $Gamma(z)Gamma(1-z) = pi slash sin(pi z)$ with $z = (beta-n) slash 2$
  and $1 - z = (n-beta) slash 2 + 1$:
  $ Gamma(frac(beta-n,2)) Gamma(frac(n-beta,2)+1) = frac(pi, sin(frac((beta-n)pi, 2))). $

  Since $sin(frac((beta-n)pi,2)) = -sin(frac((n-beta)pi,2))$, isolating $Gamma(frac(beta-n,2))$:
  $ Gamma(frac(beta-n,2)) = frac(-pi, Gamma(frac(n-beta,2)+1) sin(frac((n-beta)pi,2))). $

  #strong[Sine identity for integer $n$.]
  Apply $sin(A + n pi) = (-1)^n sin(A)$ with $A = (beta-n)pi slash 2$:
  $
    sin frac((n+beta)pi, 2)
      = (-1)^n sin frac((beta-n)pi, 2)
      = (-1)^(n+1) sin frac((n-beta)pi, 2).
  $

  #strong[Collect all factors.]
  Substitute the expression for $Gamma(frac(beta-n,2))$ into the formula for $I(n,beta)$
  obtained in the previous step. Writing $G_+ = Gamma(frac(n+beta,2)+1)$ and
  $G_- = Gamma(frac(n-beta,2)+1)$ for brevity:
  $
    I(n, beta)
      = frac((-1)^n sin(frac((n+beta)pi,2)), 2^(n+1))
        dot frac(Gamma(n+1), G_+)
        dot frac(-pi, G_- sin(frac((n-beta)pi,2))).
  $

  Replace $(-1)^n sin(frac((n+beta)pi,2)) = (-1)^(n+1) sin(frac((n-beta)pi,2))$, then
  $sin(frac((n-beta)pi,2))$ cancels top and bottom:
  $
    I(n, beta)
      = frac((-1)^(n+1) dot (-pi) dot (-1)^(n+1) dot Gamma(n+1), 2^(n+1) G_+ G_-)
      = frac((-1)^(2n+2) pi Gamma(n+1), 2^(n+1) G_+ G_-)
      = frac(pi Gamma(n+1), 2^(n+1) Gamma(frac(n+beta,2)+1) Gamma(frac(n-beta,2)+1)).
  $

  This is exactly $F(n, beta)$. The extension to real $alpha > -1$ proceeds identically to
  Solution 1: both $I(alpha,beta)$ and $F(alpha,beta)$ are analytic and bounded on
  $op("Re")(alpha) gt.eq 0$ and agree on $NN_0$, so Carlson's theorem gives
  $I(alpha,beta) = F(alpha,beta)$ for all $alpha > -1$. #sym.checkmark
]


= Verification

#strong[Direct computation ($alpha = 1$, $beta = 2$).]
Use the double-angle identity $cos(2x) = 2cos^2(x) - 1$ to expand the integrand:
$
  I(1,2)
    &= integral_0^(pi slash 2) cos(x)(2cos^2(x) - 1) dif x \
    &= 2 integral_0^(pi slash 2) cos^3(x) dif x - integral_0^(pi slash 2) cos(x) dif x.
$
The standard results $integral_0^(pi slash 2) cos^3(x) dif x = 2 slash 3$ and
$integral_0^(pi slash 2) cos(x) dif x = 1$ give
$ I(1,2) = 2 dot frac(2,3) - 1 = frac(4,3) - 1 = frac(1,3). $

The formula yields $F(1,2) = frac(pi,4) dot frac(Gamma(2), Gamma(5 slash 2) dot Gamma(1 slash 2))$.
With $Gamma(2) = 1! = 1$, $Gamma(1 slash 2) = sqrt(pi)$, and
$Gamma(5 slash 2) = frac(3,2) dot frac(1,2) dot Gamma(1 slash 2) = frac(3 sqrt(pi), 4)$:
$ F(1,2) = frac(pi,4) dot frac(1, frac(3 sqrt(pi), 4) dot sqrt(pi))
       = frac(pi,4) dot frac(4, 3 pi)
       = frac(1,3). $

Both methods give $1 slash 3$. #sym.checkmark

#strong[Higher-degree check ($alpha = 2$, $beta = 3$).]
Use the triple-angle identity $cos(3x) = 4cos^3(x) - 3cos(x)$:
$
  I(2,3)
    &= integral_0^(pi slash 2) cos^2(x)(4cos^3(x) - 3cos(x)) dif x \
    &= 4 integral_0^(pi slash 2) cos^5(x) dif x - 3 integral_0^(pi slash 2) cos^3(x) dif x \
    &= 4 dot frac(8,15) - 3 dot frac(2,3)
     = frac(32,15) - 2
     = frac(2,15).
$

($integral_0^(pi slash 2) cos^5(x) dif x = 8 slash 15$ by the Wallis reduction formula.)

The formula gives $F(2,3) = frac(pi,8) dot frac(Gamma(3), Gamma(7 slash 2) dot Gamma(1 slash 2))$.
With $Gamma(3) = 2$, $Gamma(7 slash 2) = frac(5,2) dot frac(3,2) dot frac(1,2) dot sqrt(pi) = frac(15 sqrt(pi), 8)$:
$ F(2,3) = frac(pi,8) dot frac(2, frac(15 sqrt(pi), 8) dot sqrt(pi))
       = frac(pi,8) dot frac(16, 15 pi)
       = frac(2,15). $

Both give $2 slash 15$. #sym.checkmark

#strong[Wallis integral ($beta = 0$, general $alpha$).]
When $beta = 0$ the integrand becomes $cos^alpha(x)$ and the formula predicts
$ F(alpha, 0) = frac(pi, 2^(alpha+1)) dot frac(Gamma(alpha+1), lr([Gamma(frac(alpha,2)+1)])^2). $
The
#cite("Legendre duplication formula",
  url: "https://en.wikipedia.org/wiki/Multiplication_theorem#Legendre_duplication_formula")
$Gamma(2z) = frac(2^(2z-1), sqrt(pi)) Gamma(z) Gamma(z + frac(1,2))$
with $2z = alpha + 1$ (i.e., $z = (alpha+1) slash 2$) gives
$ Gamma(alpha+1) = frac(2^alpha, sqrt(pi)) Gamma(frac(alpha+1,2)) Gamma(frac(alpha,2)+1). $
Substituting into $F(alpha, 0)$:
$
  F(alpha, 0)
    &= frac(pi, 2^(alpha+1))
       dot frac(frac(2^alpha, sqrt(pi)) Gamma(frac(alpha+1,2)) Gamma(frac(alpha,2)+1),
                lr([Gamma(frac(alpha,2)+1)])^2) \
    &= frac(pi, 2^(alpha+1))
       dot frac(2^alpha Gamma(frac(alpha+1,2)), sqrt(pi) dot Gamma(frac(alpha,2)+1)) \
    &= frac(sqrt(pi), 2) dot frac(Gamma(frac(alpha+1,2)), Gamma(frac(alpha,2)+1)),
$
which is precisely the
#cite("Wallis integral", url: "https://en.wikipedia.org/wiki/Wallis%27_integrals")
$integral_0^(pi slash 2) cos^alpha(x) dif x = frac(sqrt(pi), 2) dot frac(Gamma(frac(alpha+1,2)), Gamma(frac(alpha,2)+1))$.
#sym.checkmark

= Reflection

#strong[Integer specialization.]
When $n, m in NN_0$ with $n + m$ even, the Gamma quotient in $F(n, m)$ reduces via $Gamma(k+1) = k!$ to
$ F(n, m) = frac(pi, 2^(n+1)) binom(n, frac(n+m,2)), $
the classical result for $integral_0^(pi slash 2) cos^n(x) cos(m x) dif x$ for non-negative
integer parameters. The general formula is the natural extension of this discrete identity
to the full parameter range $beta > alpha > -1$.

#strong[Convergence conditions.]
The constraint $alpha > -1$ ensures $cos^alpha(x)$ is integrable near $x = pi slash 2$,
where $cos(x) -> 0$. The formula for $F(alpha, beta)$ is also well-defined whenever neither
Gamma factor in the denominator hits a pole — the poles of $Gamma$ occur only at
$0, -1, -2, dots.c$, so the formula remains valid (evaluating to $0$ on both sides) even
for certain pairs outside $beta > alpha > -1$.

#strong[Beta function form.]
Using $B(a, b) = Gamma(a) Gamma(b) slash Gamma(a+b)$, the result can be written as
$ integral_0^(pi slash 2) cos^alpha(x) cos(beta x) dif x
    = frac(pi, 2^(alpha+1) (alpha+1) dot B(frac(alpha+beta,2)+1, frac(alpha-beta,2)+1)), $
highlighting the integral as a reciprocal Beta value weighted by $pi slash (alpha+1)$.
