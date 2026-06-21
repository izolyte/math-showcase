#import "../src/template.typ": *
#import "../src/theorems.typ": theorem, lemma, corollary, proposition, definition, proof, insight, step, remark, example
#import "../src/components.typ": comparison, figure-image, cite, numbered, answer, diagram
#import "../src/style.typ": default-theme
#import "@preview/cetz:0.3.4"

#show: doc.with(
  title: "อินทิกรัลโคไซน์กำลัง–โคไซน์เฟอริเยร์",
  source: "Romanian Mathematical Magazine, เสนอโดย K. Srinivasa Raghava",
  source_url: none,
  source_license: "All rights reserved",
  date: "2026-06-21",
  tags: ("calculus", "definite-integral", "special-functions", "gamma-function", "beta-function", "complex-analysis", "fourier-analysis", "trigonometry", "induction", "analytic-continuation", "combinatorics"),
  prerequisites: (
    (name: "อุปนัยเชิงคณิตศาสตร์", url: "https://en.wikipedia.org/wiki/Mathematical_induction"),
    (name: "การอินทิเกรตทีละส่วน", url: "https://en.wikipedia.org/wiki/Integration_by_parts"),
    (name: "เอกลักษณ์ผลคูณ–ผลรวม", url: "https://en.wikipedia.org/wiki/List_of_trigonometric_identities#Product-to-sum_and_sum-to-product_identities"),
    (name: "สูตรออยเลอร์", url: "https://en.wikipedia.org/wiki/Euler%27s_formula"),
    (name: "ทฤษฎีบททวินาม", url: "https://en.wikipedia.org/wiki/Binomial_theorem"),
    (name: "ฟังก์ชันแกมมา", url: "https://en.wikipedia.org/wiki/Gamma_function"),
    (name: "ฟังก์ชันเบตา", url: "https://en.wikipedia.org/wiki/Beta_function"),
    (name: "สูตรสะท้อนออยเลอร์", url: "https://en.wikipedia.org/wiki/Reflection_formula"),
    (name: "การต่อเชิงวิเคราะห์", url: "https://en.wikipedia.org/wiki/Analytic_continuation"),
    (name: "ทฤษฎีบทคาร์ลสัน", url: "https://en.wikipedia.org/wiki/Carlson%27s_theorem"),
  ),
  resources: (
    (title: "อินทิกรัลวอลลิส (Wikipedia)", url: "https://en.wikipedia.org/wiki/Wallis%27_integrals"),
    (title: "ทฤษฎีบททวินาม (Wikipedia)", url: "https://en.wikipedia.org/wiki/Binomial_theorem"),
    (title: "เอกลักษณ์ Vandermonde–Chu / ผลรวมฟังก์ชันเบตา (Wikipedia)", url: "https://en.wikipedia.org/wiki/Vandermonde%27s_identity"),
    (title: "สูตรออยเลอร์ (Wikipedia)", url: "https://en.wikipedia.org/wiki/Euler%27s_formula"),
    (title: "สูตรสะท้อนออยเลอร์ (Wikipedia)", url: "https://en.wikipedia.org/wiki/Reflection_formula"),
    (title: "สูตรทวีกำลังเลอฌ็องดร์ (Wikipedia)", url: "https://en.wikipedia.org/wiki/Multiplication_theorem#Legendre_duplication_formula"),
    (title: "ทฤษฎีบทคาร์ลสัน (Wikipedia)", url: "https://en.wikipedia.org/wiki/Carlson%27s_theorem"),
    (title: "กระทู้ที่เกี่ยวข้อง (Math StackExchange, CC BY-SA 4.0)", url: "https://math.stackexchange.com/questions/456899"),
  ),
)

= โจทย์

สำหรับ $beta > alpha > -1$ จงหาค่า

$ integral_0^(pi slash 2) cos^alpha(x) cos(beta x) dif x. $

#answer[
  $ integral_0^(pi slash 2) cos^alpha(x) cos(beta x) dif x
    = frac(pi, 2^(alpha+1))
      dot frac(Gamma(alpha+1),
               Gamma(frac(alpha+beta,2)+1) dot Gamma(frac(alpha-beta,2)+1)). $
]

= สัญกรณ์และข้อตกลงเบื้องต้น

#definition(title: "ฟังก์ชันแกมมา")[
  #emph[ฟังก์ชันแกมมา] $Gamma : CC without {0,-1,-2,dots.c} arrow CC$ นิยามสำหรับ
  $op("Re")(z) > 0$ โดย
  $ Gamma(z) = integral_0^oo t^(z-1) e^(-t) dif t $
  และขยายแบบ meromorphic ไปทั้ง $CC$ โดยมีขั้วอย่างง่ายที่จำนวนเต็มไม่เกิน $0$ สองสมบัติที่ใช้ตลอด:
  - #cite([ความสัมพันธ์เวียนเกิด $Gamma(z+1) = z Gamma(z)$],
      url: "https://en.wikipedia.org/wiki/Gamma_function#Properties")
    ซึ่งให้ $Gamma(n+1) = n!$ สำหรับ $n in NN_0 := {0, 1, 2, dots.c}$
  - ค่าพิเศษ: $Gamma(1) = 1$ และ $Gamma(1 slash 2) = sqrt(pi)$
]

เขียน $I(alpha, beta) := integral_0^(pi slash 2) cos^alpha(x) cos(beta x) dif x$ และนิยามสูตรที่ต้องการพิสูจน์
$ F(alpha, beta) :=
    frac(pi, 2^(alpha+1))
    dot frac(Gamma(alpha+1),
             Gamma(frac(alpha+beta,2)+1) dot Gamma(frac(alpha-beta,2)+1)). $
เป้าหมายคือแสดงว่า $I(alpha, beta) = F(alpha, beta)$ สำหรับทุก $beta > alpha > -1$

ฟังก์ชันถูกอินทิเกรตผสมระหว่างเส้นโค้ง $cos^alpha(x)$ ที่กดลงใกล้ $x = pi slash 2$
กับการแกว่งความถี่สูง $cos(beta x)$ ซึ่งเปลี่ยนเครื่องหมายและชดเชยพื้นที่บางส่วน

#diagram(caption: [
  ฟังก์ชันถูกอินทิเกรต $cos(x) cos(2x)$ สำหรับ $alpha = 1$, $beta = 2$ บน $[0, pi slash 2]$
  เป็นบวกบน $(0, pi slash 4)$ (แรเงาสี accent) ตัดแกน $x$ ที่ $pi slash 4$ แล้วเป็นลบบน $(pi slash 4, pi slash 2)$
  (แรเงาเทา) แถบบวกกว้างกว่าส่วนลบ ทำให้พื้นที่สุทธิเท่ากับ $1 slash 3$
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

= แนวคิด

#insight[
  พิสูจน์โดย #emph[การอุปนัยเชิงแข็งแกร่งบน $n = alpha in NN_0$] เพื่อแสดงว่า
  $I(n, beta) = F(n, beta)$ สำหรับทุกจำนวนเต็มไม่ลบ $n$ จากนั้นใช้ #emph[การต่อเนื่องเชิงวิเคราะห์]
  ขยายผลไปยัง $alpha > -1$ ทั้งหมด

  - #strong[กรณีฐาน ($n = 0$).] ฟังก์ชันถูกอินทิเกรตกลายเป็น $cos(beta x)$
    ซึ่งหาปฏิยานุพันธ์ได้โดยตรง การจับคู่ผลลัพธ์กับ $F(0, beta)$ ต้องใช้
    #emph[สูตรสะท้อนออยเลอร์] $Gamma(z) Gamma(1-z) = pi slash sin(pi z)$
    เพื่อแปลงผลคูณ $Gamma(beta slash 2) Gamma(1-beta slash 2)$ ให้เป็นไซน์เดี่ยว

  - #strong[ขั้นอุปนัย ($n-1 arrow n$).] การอินทิเกรตทีละส่วนกับ $u = cos^n(x)$
    และ $dif v = cos(beta x) dif x$ ทำให้พจน์ขอบเขตหายไป (เพราะ $cos^n(pi slash 2) = 0$
    สำหรับ $n gt.eq 1$) และได้อินทิกรัลที่มี $sin(x) sin(beta x)$
    จากนั้น #emph[เอกลักษณ์ผลคูณ–ผลรวม]
    $sin(x) sin(beta x) = frac(1,2)[cos((beta-1)x) - cos((beta+1)x)]$
    แยกออกเป็นสองอินทิกรัลที่กำลังลดลงหนึ่ง ได้ความสัมพันธ์เวียนเกิด
    $ I(n, beta) = frac(n, 2 beta) lr([I(n-1, beta-1) - I(n-1, beta+1)]). $
    การตรวจสอบพีชคณิต (ขั้นที่ 3) ยืนยันว่า $F$ เป็นไปตามความสัมพันธ์เดียวกัน

  - #strong[ขยายไปยัง $alpha > -1$ ทั่วไป.] ทั้ง $I(alpha, beta)$ และ $F(alpha, beta)$
    วิเคราะห์ได้ในตัวแปร $alpha$ บน $op("Re")(alpha) > -1$ มีค่าจำกัดบน $op("Re")(alpha) gt.eq 0$
    และตรงกันบน $NN_0$ โดย #emph[ทฤษฎีบทคาร์ลสัน] ฟังก์ชันที่วิเคราะห์ได้และมีขอบเขต
    บน $op("Re")(z) gt.eq 0$ ซึ่งเป็นศูนย์ทุกจุดบน $NN_0$ ต้องเป็นศูนย์ตลอด
    ดังนั้น $I equiv F$ บน $op("Re")(alpha) > -1$
]

#diagram(caption: [
  โครงสร้างการอุปนัย: $I(n, beta)$ แยกเป็น $I(n-1, beta-1)$ (น้ำหนักบวก สี accent)
  และ $I(n-1, beta+1)$ (น้ำหนักลบ สีเทา) หลัง $n$ รอบทุกสาขาลงถึงกรณีฐาน $I(0, gamma)$
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
      text(size: 7.5pt, fill: luma(100))[กรณีฐาน: $I(0,gamma) = sin(gamma pi slash 2) slash gamma$])
  })
]

= วิธีพิสูจน์

== วิธีที่ 1: Induction

#step(reason: [กรณีฐาน $n = 0$: ปฏิยานุพันธ์และ
  #cite("สูตรสะท้อนออยเลอร์", url: "https://en.wikipedia.org/wiki/Reflection_formula")])[

  #strong[กรณีย่อย $beta = 0$.]
  $I(0,0) = integral_0^(pi slash 2) 1 dif x = pi slash 2$.
  จากนิยาม $F$ เมื่อ $alpha = beta = 0$ และ $Gamma(1) = 1$:
  $ F(0,0) = frac(pi, 2) dot frac(Gamma(1), Gamma(1) dot Gamma(1)) = frac(pi, 2) = I(0,0). $

  #strong[กรณีย่อย $beta eq.not 0$.]
  เนื่องจาก $cos^0(x) = 1$ ปฏิยานุพันธ์ของ $cos(beta x)$ คือ $sin(beta x) slash beta$:
  $
    I(0, beta)
      &= integral_0^(pi slash 2) cos(beta x) dif x
       = lr([frac(sin(beta x), beta)])_0^(pi slash 2) \
      &= frac(sin(beta pi slash 2), beta) - frac(sin(0), beta)
       = frac(sin(beta pi slash 2), beta).
  $

  เราจะแสดงว่า $F(0, beta)$ เท่ากับค่านี้ แทน $alpha = 0$ และ $Gamma(1) = 1$:
  $ F(0, beta) = frac(pi, 2) dot frac(1, Gamma(frac(beta,2)+1) dot Gamma(1 - frac(beta,2))). $

  ใช้#cite([ความสัมพันธ์เวียนเกิด $Gamma(z+1) = z Gamma(z)$],
    url: "https://en.wikipedia.org/wiki/Gamma_function#Properties")
  กับ $z = beta slash 2$:
  $ Gamma(frac(beta,2)+1) = frac(beta,2) dot Gamma(frac(beta,2)). $

  แทนกลับเข้าใน $F(0, beta)$:
  $
    F(0, beta)
      &= frac(pi, 2) dot frac(1, frac(beta,2) dot Gamma(frac(beta,2)) dot Gamma(1 - frac(beta,2))) \
      &= frac(pi, beta dot Gamma(frac(beta,2)) dot Gamma(1 - frac(beta,2))).
  $

  จาก#cite("สูตรสะท้อนออยเลอร์",
    url: "https://en.wikipedia.org/wiki/Reflection_formula")
  $Gamma(z) Gamma(1-z) = pi slash sin(pi z)$ เมื่อ $z in.not ZZ$
  แทน $z = beta slash 2$:
  $ Gamma(frac(beta,2)) dot Gamma(1 - frac(beta,2)) = frac(pi, sin(pi beta slash 2)). $

  ดังนั้น:
  $
    F(0, beta)
      &= frac(pi, beta) dot frac(sin(pi beta slash 2), pi)
       = frac(sin(beta pi slash 2), beta)
       = I(0, beta). quad checkmark
  $
]

#step(reason: [การอินทิเกรตทีละส่วนและ
  #cite("เอกลักษณ์ผลคูณ–ผลรวม",
    url: "https://en.wikipedia.org/wiki/List_of_trigonometric_identities#Product-to-sum_and_sum-to-product_identities")])[

  กำหนดจำนวนเต็ม $n gt.eq 1$ และสมมติว่า $I(n-1, gamma) = F(n-1, gamma)$ สำหรับทุก $gamma in RR$
  ตั้ง
  $ u = cos^n(x), quad dif v = cos(beta x) dif x $
  ดังนั้น
  $ dif u = -n cos^(n-1)(x) sin(x) dif x, quad v = frac(sin(beta x), beta). $

  การอินทิเกรตทีละส่วนให้:
  $
    I(n, beta)
      = lr([frac(cos^n(x) sin(beta x), beta)])_0^(pi slash 2)
        + frac(n, beta) integral_0^(pi slash 2) cos^(n-1)(x) sin(x) sin(beta x) dif x.
  $

  #remark[
    พจน์ขอบเขตหายไปทั้งสองปลาย: ที่ $x = 0$ มี $sin(0) = 0$; ที่ $x = pi slash 2$
    มี $cos^n(pi slash 2) = 0$ (สำหรับ $n gt.eq 1$) นี่คือเหตุผลที่ต้องแยกกรณีฐาน $n = 0$
    ออกต่างหาก เพราะที่ $n = 0$ พจน์ขอบเขตไม่หายไปเองโดยอัตโนมัติ
  ]

  เมื่อพจน์ขอบเขตหายไป:
  $ I(n, beta) = frac(n, beta) integral_0^(pi slash 2) cos^(n-1)(x) sin(x) sin(beta x) dif x. $

  ใช้#cite("เอกลักษณ์ผลคูณ–ผลรวม",
    url: "https://en.wikipedia.org/wiki/List_of_trigonometric_identities#Product-to-sum_and_sum-to-product_identities")
  $ sin(x) sin(beta x) = frac(1,2) lr([cos((beta-1)x) - cos((beta+1)x)]) $
  กับฟังก์ชันถูกอินทิเกรต:
  $
    I(n, beta)
      &= frac(n, beta) dot frac(1,2) integral_0^(pi slash 2)
           cos^(n-1)(x) lr([cos((beta-1)x) - cos((beta+1)x)]) dif x \
      &= frac(n, 2 beta) lr([integral_0^(pi slash 2) cos^(n-1)(x) cos((beta-1)x) dif x
           - integral_0^(pi slash 2) cos^(n-1)(x) cos((beta+1)x) dif x]) \
      &= frac(n, 2 beta) lr([I(n-1, beta-1) - I(n-1, beta+1)]).
  $

  โดยสมมติฐานการอุปนัย $I(n-1, beta-1) = F(n-1, beta-1)$ และ $I(n-1, beta+1) = F(n-1, beta+1)$:
  $ I(n, beta) = frac(n, 2 beta) lr([F(n-1, beta-1) - F(n-1, beta+1)]). $
]

#step(reason: [ตรวจสอบเชิงพีชคณิตว่า $F$ เป็นไปตามความสัมพันธ์เวียนเกิดเดียวกัน])[

  เราต้องแสดงว่า $frac(n, 2 beta) lr([F(n-1, beta-1) - F(n-1, beta+1)]) = F(n, beta)$

  #strong[กระจาย $F(n-1, beta-1)$ และ $F(n-1, beta+1)$.]
  แทน $(alpha, beta) = (n-1, beta-1)$ ในนิยามของ $F$:
  $
    F(n-1, beta-1)
      = frac(pi, 2^n) dot frac(Gamma(n),
          Gamma(frac(n+beta,2)) dot Gamma(frac(n-beta,2)+1)).
  $

  (อาร์กิวเมนต์แรกของ Gamma คือ $frac((n-1)+(beta-1),2)+1 = frac(n+beta,2)$
  และอาร์กิวเมนต์ที่สองคือ $frac((n-1)-(beta-1),2)+1 = frac(n-beta,2)+1$)

  ในทำนองเดียวกัน แทน $(alpha, beta) = (n-1, beta+1)$:
  $
    F(n-1, beta+1)
      = frac(pi, 2^n) dot frac(Gamma(n),
          Gamma(frac(n+beta,2)+1) dot Gamma(frac(n-beta,2))).
  $

  #strong[แยกตัวส่วนโดยใช้ความสัมพันธ์เวียนเกิด.]
  ใช้ $Gamma(z+1) = z Gamma(z)$:
  $
    Gamma(frac(n-beta,2)+1)
      = frac(n-beta,2) dot Gamma(frac(n-beta,2)), \
    Gamma(frac(n+beta,2)+1)
      = frac(n+beta,2) dot Gamma(frac(n+beta,2)).
  $

  ทำให้ทั้งสองพจน์มีตัวส่วนร่วม $Gamma(frac(n+beta,2))$ และ $Gamma(frac(n-beta,2))$:
  $
    F(n-1, beta-1)
      &= frac(pi Gamma(n), 2^n)
         dot frac(2, (n-beta) dot Gamma(frac(n+beta,2)) dot Gamma(frac(n-beta,2))), \
    F(n-1, beta+1)
      &= frac(pi Gamma(n), 2^n)
         dot frac(2, (n+beta) dot Gamma(frac(n+beta,2)) dot Gamma(frac(n-beta,2))).
  $

  #strong[หาผลต่าง.]
  ดึงตัวประกอบร่วม $frac(2 pi Gamma(n), 2^n dot Gamma(frac(n+beta,2)) dot Gamma(frac(n-beta,2)))$ ออก:
  $
    F(n-1, beta-1) - F(n-1, beta+1)
      &= frac(2 pi Gamma(n), 2^n dot Gamma(frac(n+beta,2)) dot Gamma(frac(n-beta,2)))
         dot lr([frac(1, n-beta) - frac(1, n+beta)]) \
      &= frac(2 pi Gamma(n), 2^n dot Gamma(frac(n+beta,2)) dot Gamma(frac(n-beta,2)))
         dot frac(2 beta, n^2-beta^2).
  $

  #strong[คูณด้วย $n slash (2 beta)$.]
  $
    frac(n, 2 beta) lr([F(n-1,beta-1) - F(n-1,beta+1)])
      = frac(2 n pi Gamma(n),
           2^n (n^2-beta^2) Gamma(frac(n+beta,2)) Gamma(frac(n-beta,2))).
  $

  #strong[เขียนใหม่โดยใช้ความสัมพันธ์เวียนเกิด.]
  จาก $(n^2 - beta^2) = (n+beta)(n-beta)$ และ $Gamma(z+1) = z Gamma(z)$:
  $
    (n+beta) Gamma(frac(n+beta,2))
      &= 2 Gamma(frac(n+beta,2)+1), \
    (n-beta) Gamma(frac(n-beta,2))
      &= 2 Gamma(frac(n-beta,2)+1).
  $

  ดังนั้น $(n^2-beta^2) Gamma(frac(n+beta,2)) Gamma(frac(n-beta,2))
  = 4 Gamma(frac(n+beta,2)+1) Gamma(frac(n-beta,2)+1)$

  แทนกลับ:
  $
    frac(n, 2 beta) lr([F(n-1,beta-1) - F(n-1,beta+1)])
      &= frac(2 n pi Gamma(n), 2^n dot 4 Gamma(frac(n+beta,2)+1) Gamma(frac(n-beta,2)+1)) \
      &= frac(pi Gamma(n+1), 2^(n+1) Gamma(frac(n+beta,2)+1) Gamma(frac(n-beta,2)+1)) \
      &= F(n, beta). quad checkmark
  $

  (ขั้นสุดท้ายใช้ $n Gamma(n) = Gamma(n+1)$)
]

#step(reason: [สรุปการอุปนัยและ#cite("ทฤษฎีบทคาร์ลสัน", url: "https://en.wikipedia.org/wiki/Carlson%27s_theorem")])[

  ขั้นที่ 1–3 พิสูจน์โดยการอุปนัยเชิงแข็งแกร่งว่า $I(n, beta) = F(n, beta)$
  สำหรับทุก $n in NN_0$ และทุก $beta in RR$

  สำหรับ $alpha > -1$ ทั่วไป สังเกตว่า:
  - $I(alpha, beta)$ วิเคราะห์ได้ในตัวแปร $alpha$ บน $op("Re")(alpha) > -1$
    โดยทฤษฎีการลู่เข้าแบบครอบงำ (เพราะ $abs(cos^alpha(x) cos(beta x)) lt.eq cos^(op("Re")(alpha))(x)$
    อินทิเกรตได้บนช่วงนั้น)
  - $F(alpha, beta)$ วิเคราะห์ได้บนครึ่งระนาบเดียวกัน เพราะ#cite("ฟังก์ชันแกมมา",
      url: "https://en.wikipedia.org/wiki/Gamma_function")
    วิเคราะห์ได้นอกขั้วของมัน ซึ่งอยู่ที่จำนวนเต็มไม่เกิน $0$ นอกครึ่งระนาบนี้
  - ทั้งสองมีค่าจำกัดบน $op("Re")(alpha) gt.eq 0$ และตรงกันบน $NN_0$

  โดย#cite("ทฤษฎีบทคาร์ลสัน",
    url: "https://en.wikipedia.org/wiki/Carlson%27s_theorem")
  ฟังก์ชันที่วิเคราะห์ได้และมีขอบเขตบน $op("Re")(z) gt.eq 0$ ซึ่งเป็นศูนย์ทุกจุดบน $NN_0$
  ต้องเป็นศูนย์ตลอด ผลต่าง $I(alpha, beta) - F(alpha, beta)$ เป็นไปตามเงื่อนไขทั้งหมด
  และเป็นศูนย์บน $NN_0$ ดังนั้นมันเป็นศูนย์ตลอด $op("Re")(alpha) > -1$
]

#theorem[
  สำหรับ $beta > alpha > -1$
  $ integral_0^(pi slash 2) cos^alpha(x) cos(beta x) dif x
    = frac(pi, 2^(alpha+1))
      dot frac(Gamma(alpha+1),
               Gamma(frac(alpha+beta,2)+1) dot Gamma(frac(alpha-beta,2)+1)). $
]

== วิธีที่ 2: เอกซ์โพเนนเชียลเชิงซ้อน

#insight[
  แทนที่จะสร้างสูตรด้วย induction เราจะ #emph[แตก $cos^n(x)$ เป็นเอกซ์โพเนนเชียลเชิงซ้อน]
  ผ่านทฤษฎีบททวินาม แล้วอินทิเกรตแต่ละพจน์ความถี่เดี่ยวในรูปปิด จากนั้นยุบผลรวมทวินามสลับเครื่องหมาย
  ด้วย #emph[เอกลักษณ์ Vandermonde–Chu] สุดท้ายสูตรสะท้อน Euler ตัด $Gamma(frac(beta-n,2))$
  กับตัวประกอบไซน์ ได้ $F(n,beta)$ โดยตรง วิธีนี้ใช้ได้แน่ชัดสำหรับ $n$ จำนวนเต็ม
  และขยายสู่ $alpha > -1$ จริงด้วยทฤษฎีบท Carlson เช่นเดิม
]

#diagram(caption: [
  การแทน $w = e^(-2i x)$ ส่ง $x in (0, pi slash 2)$ ไปยังส่วนโค้งล่างบนวงกลมหนึ่งหน่วย (เส้นสี)
  จาก $w=1$ ที่ $x=0$ ผ่าน $w=-i$ ที่ $x=pi slash 4$ ถึง $w=-1$ ที่ $x=pi slash 2$
  ดิสก์เปิด $|w|<1$ (แรเงา) คือบริเวณลู่เข้าของอนุกรมทวินาม $(1+w)^n = sum_k binom(n,k)w^k$
  เส้นทางอยู่บนขอบ จุด $w=-1$ เป็นจุดเดียวที่น่าเป็นห่วง แต่ $(1+w)^n=0$ ที่นั่น
  จึงสลับลำดับผลรวมกับอินทิกรัลได้
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
    content((-0.1, 0.50), text(size: 6.5pt, fill: acc.darken(15%))[อนุกรมลู่เข้า])
    content((1.5, -1.7), text(size: 7.5pt, fill: acc)[$w = e^(-2i x)$])
  })
]

#step(reason: [เขียนเป็นส่วนจริงของอินทิกรัลเชิงซ้อน])[
  เขียน $cos(beta x) = op("Re")(e^(i beta x))$ และนิยาม
  $ J := integral_0^(pi slash 2) cos^n(x) e^(i beta x) dif x, $
  จะได้ $I(n, beta) = op("Re")(J)$ ข้อดีคือ $e^(i beta x)$ รวม $cos(beta x)$ และ $sin(beta x)$
  ไว้ในนิพจน์เดียว เราจึงแบกอินทิกรันด์เชิงซ้อนตัวเดียวและฉายลงแกนจริงตอนท้ายเท่านั้น
]

#step(reason: [
  กระจาย $cos^n(x)$ ด้วย
  #cite([ทฤษฎีบททวินาม], url: "https://en.wikipedia.org/wiki/Binomial_theorem")])[

  เขียน $2cos(x) = e^(i x) + e^(-i x)$ และแยกตัวประกอบ $e^(i n x)$:
  $
    cos^n(x) = frac((e^(i x) + e^(-i x))^n, 2^n)
             = frac(e^(i n x), 2^n) (1 + e^(-2i x))^n.
  $

  แทน $(1 + w)^n = sum_(k=0)^n binom(n,k) w^k$ โดย $w = e^(-2i x)$:
  $
    cos^n(x) = frac(1, 2^n) sum_(k=0)^n binom(n,k) e^(i(n - 2k)x).
  $

  #remark[
    ผลรวมจบที่ $k = n$ เพราะ $binom(n,k) = 0$ สำหรับ $k > n$ จำนวนเต็ม
    ความถี่ $n - 2k$ สำหรับ $k = 0, 1, dots.c, n$ เป็นอนุกรมเลขคณิต $n, n-2, dots.c, -n$
    ซึ่งต่างกันทุกพจน์ การแตกจึงเป็นเอกลักษณ์
  ]

  แทนใน $J$ และสลับผลรวม (จำกัด) กับอินทิกรัล:
  $
    J = frac(1, 2^n) sum_(k=0)^n binom(n,k) integral_0^(pi slash 2) e^(i(n+beta-2k)x) dif x.
  $
]

#step(reason: [คำนวณแต่ละอินทิกรัลเอกซ์โพเนนเชียล แล้วดึงส่วนจริง])[
  กำหนด $gamma_k := n + beta - 2k$ สำหรับ $gamma_k eq.not 0$ ปฏิยานุพันธ์โดยตรงให้:
  $
    integral_0^(pi slash 2) e^(i gamma_k x) dif x
      = lr([frac(e^(i gamma_k x), i gamma_k)])_0^(pi slash 2)
      = frac(e^(i gamma_k pi slash 2) - 1, i gamma_k).
  $

  แยกส่วนจริงและส่วนจินตภาพโดยเขียน
  $e^(i gamma_k pi slash 2) - 1 = (cos(gamma_k pi slash 2) - 1) + i sin(gamma_k pi slash 2)$:
  $
    frac(e^(i gamma_k pi slash 2) - 1, i gamma_k)
      = frac(sin(gamma_k pi slash 2), gamma_k)
        + frac(cos(gamma_k pi slash 2) - 1, i gamma_k).
  $

  เศษส่วนที่สอง: คูณเศษและส่วนด้วย $-i$ ได้ $frac(-i(cos(gamma_k pi slash 2) - 1), gamma_k)$
  ซึ่งเป็นจินตภาพล้วน ดังนั้น
  $
    op("Re") integral_0^(pi slash 2) e^(i gamma_k x) dif x
      = frac(sin(gamma_k pi slash 2), gamma_k)
      = frac(sin(frac((n+beta-2k)pi, 2)), n+beta-2k).
  $

  รวมทุก $k$:
  $
    I(n, beta) = frac(1, 2^n) sum_(k=0)^n binom(n,k)
                 frac(sin(frac((n+beta-2k)pi, 2)), n+beta-2k).
  $
]

#step(reason: [
  แยกตัวประกอบด้วยสูตรมุมลบ และประเมินผลรวมด้วย
  #cite([เอกลักษณ์ Vandermonde–Chu], url: "https://en.wikipedia.org/wiki/Vandermonde%27s_identity")])[

  #strong[แยกตัวประกอบ $sin$ ออกจากผลรวม.]
  สำหรับ $k$ จำนวนเต็มใดก็ตาม ใช้ $sin(theta - k pi) = (-1)^k sin(theta)$
  โดย $theta = frac((n+beta)pi, 2)$:
  $
    sin frac((n+beta-2k)pi, 2)
      = sin(frac((n+beta)pi, 2) - k pi)
      = (-1)^k sin frac((n+beta)pi, 2).
  $
  ตัวประกอบ $sin frac((n+beta)pi, 2)$ ไม่ขึ้นกับ $k$ จึงดึงออกได้:
  $ I(n,beta) = frac(sin(frac((n+beta)pi, 2)), 2^n) dot S_n $
  เมื่อ $S_n := sum_(k=0)^n frac((-1)^k binom(n,k), n+beta-2k)$.

  #strong[ประเมิน $S_n$ โดยแทน $j = n - k$.]
  ตั้ง $j = n - k$ (ดังนั้น $k = n - j$, $(-1)^k = (-1)^n (-1)^j$, $binom(n,n-j) = binom(n,j)$
  และ $n+beta-2(n-j) = beta-n+2j$):
  $
    S_n
      = sum_(j=0)^n frac((-1)^n (-1)^j binom(n,j), beta-n+2j)
      = frac((-1)^n, 2) sum_(j=0)^n frac((-1)^j binom(n,j), frac(beta-n,2)+j).
  $

  ผลรวมภายในตรงกับ
  #cite([เอกลักษณ์ Vandermonde–Chu], url: "https://en.wikipedia.org/wiki/Vandermonde%27s_identity"):
  สำหรับ $s > 0$ และ $n gt.eq 0$ จำนวนเต็ม,
  $
    sum_(j=0)^n frac((-1)^j binom(n,j), s+j)
      = B(s, n+1)
      = frac(Gamma(s) Gamma(n+1), Gamma(s+n+1)).
  $

  ตั้ง $s = (beta-n) slash 2$ จะได้ $s + n + 1 = (n+beta) slash 2 + 1$:
  $
    sum_(j=0)^n frac((-1)^j binom(n,j), frac(beta-n,2)+j)
      = frac(Gamma(frac(beta-n,2)) Gamma(n+1), Gamma(frac(n+beta,2)+1)).
  $

  ดังนั้น:
  $
    S_n = frac((-1)^n, 2) dot frac(Gamma(frac(beta-n,2)) Gamma(n+1), Gamma(frac(n+beta,2)+1)).
  $

  แทนกลับในสมการของ $I(n,beta)$:
  $
    I(n, beta)
      = frac((-1)^n sin(frac((n+beta)pi, 2)), 2^(n+1))
        dot frac(Gamma(frac(beta-n,2)) Gamma(n+1), Gamma(frac(n+beta,2)+1)).
  $
]

#step(reason: [
  ตัด $Gamma(frac(beta-n,2))$ กับไซน์ผ่าน
  #cite([สูตรสะท้อน Euler], url: "https://en.wikipedia.org/wiki/Reflection_formula")])[

  ใช้ $Gamma(z)Gamma(1-z) = pi slash sin(pi z)$ โดย $z = (beta-n) slash 2$
  และ $1 - z = (n-beta) slash 2 + 1$:
  $ Gamma(frac(beta-n,2)) Gamma(frac(n-beta,2)+1) = frac(pi, sin(frac((beta-n)pi, 2))). $

  เนื่องจาก $sin(frac((beta-n)pi,2)) = -sin(frac((n-beta)pi,2))$ แยก $Gamma(frac(beta-n,2))$:
  $ Gamma(frac(beta-n,2)) = frac(-pi, Gamma(frac(n-beta,2)+1) sin(frac((n-beta)pi,2))). $

  #strong[เอกลักษณ์ไซน์สำหรับ $n$ จำนวนเต็ม.]
  ใช้ $sin(A + n pi) = (-1)^n sin(A)$ โดย $A = (beta-n)pi slash 2$:
  $
    sin frac((n+beta)pi, 2)
      = (-1)^n sin frac((beta-n)pi, 2)
      = (-1)^(n+1) sin frac((n-beta)pi, 2).
  $

  #strong[รวบทุกตัวประกอบ.]
  แทนค่า $Gamma(frac(beta-n,2))$ และเอกลักษณ์ไซน์ โดยเขียน $G_+ = Gamma(frac(n+beta,2)+1)$
  และ $G_- = Gamma(frac(n-beta,2)+1)$:
  $
    I(n, beta)
      = frac((-1)^n sin(frac((n+beta)pi,2)), 2^(n+1))
        dot frac(Gamma(n+1), G_+)
        dot frac(-pi, G_- sin(frac((n-beta)pi,2))).
  $

  แทน $(-1)^n sin(frac((n+beta)pi,2)) = (-1)^(n+1) sin(frac((n-beta)pi,2))$
  แล้ว $sin(frac((n-beta)pi,2))$ ตัดกัน:
  $
    I(n, beta)
      = frac((-1)^(n+1) dot (-pi) dot (-1)^(n+1) dot Gamma(n+1), 2^(n+1) G_+ G_-)
      = frac((-1)^(2n+2) pi Gamma(n+1), 2^(n+1) G_+ G_-)
      = frac(pi Gamma(n+1), 2^(n+1) Gamma(frac(n+beta,2)+1) Gamma(frac(n-beta,2)+1)).
  $

  นี่คือ $F(n, beta)$ พอดี การขยายสู่ $alpha > -1$ จริงดำเนินเหมือนวิธีที่ 1:
  ทั้ง $I(alpha,beta)$ และ $F(alpha,beta)$ เป็นฟังก์ชันวิเคราะห์และมีขอบเขตบน $op("Re")(alpha) gt.eq 0$
  และตรงกันบน $NN_0$ ดังนั้นโดย#cite([ทฤษฎีบท Carlson], url: "https://en.wikipedia.org/wiki/Carlson%27s_theorem")
  จะได้ $I(alpha,beta) = F(alpha,beta)$ สำหรับ $alpha > -1$ ทั้งหมด #sym.checkmark
]


= การตรวจสอบ

#strong[วิธีตรงสำหรับ ($alpha = 1$, $beta = 2$).]
ใช้สูตรมุมคู่ $cos(2x) = 2cos^2(x) - 1$ กระจายฟังก์ชันถูกอินทิเกรต:
$
  I(1,2)
    &= integral_0^(pi slash 2) cos(x)(2cos^2(x) - 1) dif x \
    &= 2 integral_0^(pi slash 2) cos^3(x) dif x - integral_0^(pi slash 2) cos(x) dif x.
$
ผลมาตรฐาน $integral_0^(pi slash 2) cos^3(x) dif x = 2 slash 3$ และ
$integral_0^(pi slash 2) cos(x) dif x = 1$ ให้:
$ I(1,2) = 2 dot frac(2,3) - 1 = frac(1,3). $

สูตรให้ $F(1,2) = frac(pi,4) dot frac(Gamma(2), Gamma(5 slash 2) dot Gamma(1 slash 2))$
โดย $Gamma(2) = 1$, $Gamma(5 slash 2) = frac(3 sqrt(pi), 4)$, $Gamma(1 slash 2) = sqrt(pi)$:
$F(1,2) = frac(pi,4) dot frac(4, 3 pi) = frac(1,3).$ #sym.checkmark

#strong[ตรวจสอบกำลังสูง ($alpha = 2$, $beta = 3$).]
ใช้สูตรมุมสาม $cos(3x) = 4cos^3(x) - 3cos(x)$:
$
  I(2,3)
    &= 4 integral_0^(pi slash 2) cos^5(x) dif x - 3 integral_0^(pi slash 2) cos^3(x) dif x \
    &= 4 dot frac(8,15) - 3 dot frac(2,3)
     = frac(2,15).
$
สูตรให้ $F(2,3) = frac(pi,8) dot frac(Gamma(3), Gamma(7 slash 2) dot Gamma(1 slash 2))$
โดย $Gamma(3) = 2$, $Gamma(7 slash 2) = frac(15 sqrt(pi), 8)$:
$F(2,3) = frac(pi,8) dot frac(16, 15 pi) = frac(2,15).$ #sym.checkmark

#strong[อินทิกรัลวอลลิส ($beta = 0$ ทุก $alpha$).]
เมื่อ $beta = 0$ สูตรทำนาย
$ F(alpha, 0) = frac(pi, 2^(alpha+1)) dot frac(Gamma(alpha+1), lr([Gamma(frac(alpha,2)+1)])^2). $
จาก#cite("สูตรทวีกำลังเลอฌ็องดร์",
  url: "https://en.wikipedia.org/wiki/Multiplication_theorem#Legendre_duplication_formula")
$Gamma(alpha+1) = frac(2^alpha, sqrt(pi)) Gamma(frac(alpha+1,2)) Gamma(frac(alpha,2)+1)$
แทนกลับได้:
$
  F(alpha, 0)
    = frac(sqrt(pi), 2) dot frac(Gamma(frac(alpha+1,2)), Gamma(frac(alpha,2)+1)),
$
ซึ่งตรงกับ#cite("อินทิกรัลวอลลิส", url: "https://en.wikipedia.org/wiki/Wallis%27_integrals")
$integral_0^(pi slash 2) cos^alpha(x) dif x = frac(sqrt(pi), 2) dot frac(Gamma(frac(alpha+1,2)), Gamma(frac(alpha,2)+1))$.
#sym.checkmark

= ข้อสังเกตเพิ่มเติม

#strong[กรณีพิเศษจำนวนเต็ม.]
เมื่อ $n, m in NN_0$ และ $n + m$ เป็นจำนวนคู่ อัตราส่วนแกมมาใน $F(n, m)$
ลดเหลือสัมประสิทธิ์ทวินาม:
$ F(n, m) = frac(pi, 2^(n+1)) binom(n, frac(n+m,2)), $
ซึ่งเป็นสูตรคลาสสิกสำหรับ $integral_0^(pi slash 2) cos^n(x) cos(m x) dif x$
สูตรทั่วไปคือการขยายของเอกลักษณ์แบบไม่ต่อเนื่องนี้ไปยัง $beta > alpha > -1$

#strong[เงื่อนไขการลู่เข้า.]
เงื่อนไข $alpha > -1$ รับประกันว่า $cos^alpha(x)$ อินทิเกรตได้ใกล้ $x = pi slash 2$
ที่ซึ่ง $cos(x) -> 0$ ตัวส่วนในสูตรไม่เป็นศูนย์เพราะขั้วของ $Gamma$ อยู่ที่
$0, -1, -2, dots.c$ ซึ่งอยู่นอกช่วงพารามิเตอร์ที่ระบุ

#strong[รูปแบบฟังก์ชันเบตา.]
เขียน $B(a,b) = Gamma(a) Gamma(b) slash Gamma(a+b)$ ได้ว่า
$ F(alpha, beta) = frac(pi, 2^(alpha+1) (alpha+1) dot B(frac(alpha+beta,2)+1, frac(alpha-beta,2)+1)), $
ซึ่งแสดงให้เห็นว่าอินทิกรัลนี้เป็นส่วนกลับของค่า Beta function คูณด้วย $pi slash (alpha+1)$
