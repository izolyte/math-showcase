#import "../src/template.typ": *
#import "../src/theorems.typ": theorem, lemma, corollary, proposition, definition, proof, insight, step, remark, example
#import "../src/components.typ": comparison, figure-image, cite, numbered, answer, diagram
#import "../src/style.typ": default-theme
#import "@preview/cetz:0.3.4"

#show: doc.with(
  title: "อินทิกรัลพื้น–เพดานซ้อนกัน",
  source: "MIT Integration Bee 2026, Qualifying Round, #15",
  source_url: "https://math.mit.edu/~yyao1/pdf/qualifying_round_2026_answers.pdf",
  source_license: "All rights reserved",
  date: "2026-06-20",
  tags: ("calculus", "floor-ceiling", "definite-integral"),
  prerequisites: (
    (name: "ฟังก์ชันพื้นและเพดาน", url: "https://en.wikipedia.org/wiki/Floor_and_ceiling_functions"),
    (name: "ภาคเศษส่วน", url: "https://en.wikipedia.org/wiki/Fractional_part"),
    (name: "การอินทิเกรตฟังก์ชันขั้นบันได", url: none),
  ),
  resources: (
    (title: "ฟังก์ชันพื้นและเพดาน (Wikipedia)", url: "https://en.wikipedia.org/wiki/Floor_and_ceiling_functions"),
    (title: "จำนวนสามเหลี่ยม (Wikipedia)", url: "https://en.wikipedia.org/wiki/Triangular_number"),
  ),
)

= โจทย์

จงหาค่าของ

$ integral_0^1000 (floor(ceil(x)) + ceil(floor(x)) + floor(lr(\{ x \})) + lr(\{ floor(x) \}) + ceil(lr(\{ x \})) + lr(\{ ceil(x) \})) dif x, $

โดยที่ $floor(dot)$ คือฟังก์ชันพื้น (Floor function), $ceil(dot)$ คือฟังก์ชันเพดาน (Ceiling function), และ $lr(\{ x \}) = x - floor(x)$ คือภาคเศษส่วน (Fractional part) ของ $x$

#answer[$ integral_0^1000 (dots.c) dif x = 1000 dot 1001 = 1\,001\,000. $]

= สัญกรณ์และข้อตกลงเบื้องต้น

#definition(title: "ฟังก์ชันพื้น เพดาน และภาคเศษส่วน")[
  สำหรับจำนวนจริง $x$ ใด ๆ: $floor(x)$ คือจำนวนเต็มที่มากที่สุดที่ไม่เกิน $x$
  และ $ceil(x)$ คือจำนวนเต็มที่น้อยที่สุดที่ไม่น้อยกว่า $x$ ในขณะที่
  $lr(\{ x \}) = x - floor(x)$ คือภาคเศษส่วนของ $x$ ซึ่งมีค่าอยู่ในช่วง
  $0 lt.eq lr(\{ x \}) < 1$ เสมอ
]

กุญแจสำคัญในการแก้โจทย์ข้อนี้มีสองประการ ประการแรก หาก $n$ เป็นจำนวนเต็ม การประยุกต์ใช้ฟังก์ชันพื้น ฟังก์ชันเพดาน หรือภาคเศษส่วน จะไม่เปลี่ยนแปลงค่าของจำนวนเต็มนั้น กล่าวคือ $floor(n) = ceil(n) = n$ และ $lr(\{ n \}) = 0$ 

ประการที่สอง หาก $x$ ไม่เป็นจำนวนเต็มและอยู่ในช่วงเปิด $(k, k+1)$ โดยที่ $k$ เป็นจำนวนเต็ม จะได้ว่า
$ floor(x) = k, quad ceil(x) = k+1, quad lr(\{ x \}) in (0, 1). $

#diagram(caption: [
  สำหรับ $x in (k, k+1)$: $floor(x)$ ลงไปที่ $k$ และ $ceil(x)$ ขึ้นไปที่ $k+1$ ขณะที่ $lr(\{x\}) = x - k$ อยู่ในช่วงเปิด $(0, 1)$
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

เนื่องจากช่วงของการอินทิเกรตคือ $[0, 1000]$ ค่าของ $x$ จึงเป็นจำนวนจริงบวกทั้งหมด ทำให้ไม่ต้องพิจารณากรณีเครื่องหมายลบ

= แนวคิด

#insight[
  จากพจน์ทั้งหกพจน์ มีถึงห้าพจน์ที่สามารถลดรูปได้อย่างง่ายดาย เนื่องจากเมื่อนำ#strong[จำนวนเต็ม]ไปเข้าฟังก์ชันพื้นหรือเพดาน ค่าของมันย่อมไม่เปลี่ยนแปลง และเนื่องจาก $floor(x)$ กับ $ceil(x)$ ให้ผลลัพธ์เป็นจำนวนเต็มเสมอ พจน์ที่ซ้อนกันจึงยุบเหลือเพียง $ceil(x)$, $floor(x)$ และพจน์ที่เป็นศูนย์อีกสามพจน์
  
  พจน์สำคัญที่เป็นจุดเปลี่ยนคือ $ceil(lr(\{ x \}))$ ซึ่งแม้จะมีความคล้ายคลึงกับ $floor(lr(\{ x \}))$ ที่มีค่าเป็น $0$ แต่ฟังก์ชันเพดานของค่าที่อยู่ระหว่าง $0$ กับ $1$ จะมีค่าเท่ากับ $1$ เสมอ (ไม่ใช่ $0$) พจน์นี้จึงเป็น#emph[พจน์เดียว]ที่เพิ่มพื้นที่ใต้กราฟเข้ามาอีก $integral_0^1000 1 dif x = 1000$ หน่วย
]

เมื่อไม่พิจารณาจุดที่เป็นจำนวนเต็ม (เนื่องจากไม่มีผลต่อค่าอินทิกรัล) อินทิกรันด์ทั้งหมดจะยุบรูปเหลือเพียง $ceil(x) + floor(x) + 1 = 2 ceil(x)$ ซึ่งเป็น#emph[ฟังก์ชันขั้นบันได] การหาค่าอินทิกรัลจึงเป็นการคำนวณพื้นที่ใต้ขั้นบันไดนี้

#diagram(caption: [
  อินทิกรันด์มีค่าคงที่บนแต่ละช่วงย่อย $(k, k+1)$ เท่ากับ $2 ceil(x) = 2(k+1)$
  พื้นที่รวมคือผลรวมของพื้นที่สี่เหลี่ยมผืนผ้าเหล่านี้ ซึ่งบนช่วง $[0, N]$ จะมีค่าเท่ากับ $N(N+1)$
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

= วิธีทำ

#step(reason: [ผลลัพธ์ของฟังก์ชันพื้นและเพดานเป็นจำนวนเต็ม])[
  เนื่องจาก $floor(x)$ และ $ceil(x)$ เป็นจำนวนเต็มสำหรับทุกค่า $x$ การนำไปเข้าฟังก์ชันพื้น เพดาน หรือภาคเศษส่วนซ้ำอีกครั้ง จึงไม่เปลี่ยนแปลงค่าเดิม:
  $ floor(ceil(x)) = ceil(x), quad ceil(floor(x)) = floor(x), quad
    lr(\{ floor(x) \}) = 0, quad lr(\{ ceil(x) \}) = 0. $
  ทำให้เราสามารถลดทอนพจน์ไปได้ถึงสี่พจน์
]

#step(reason: [ขอบเขตของค่าภาคเศษส่วน])[
  เนื่องจาก $0 lt.eq lr(\{ x \}) < 1$ ฟังก์ชันพื้นของ $lr(\{ x \})$ จึงมีค่าเป็น $0$ เสมอ:
  $ floor(lr(\{ x \})) = 0. $
  สำหรับพจน์ฟังก์ชันเพดาน หาก $x$ ไม่เป็นจำนวนเต็ม ค่าของ $lr(\{ x \})$ จะมากกว่า $0$ แต่ไม่ถึง $1$ ซึ่งจำนวนเต็มที่น้อยที่สุดที่ไม่น้อยกว่าค่านี้คือ $1$ พอดี:
  $ ceil(lr(\{ x \})) = 1 quad (x in.not ZZ). $

  #diagram(caption: [
    $lr(\{x\}) in (0,1)$ สำหรับ $x in.not ZZ$: ฟังก์ชันพื้นปัดลงเป็น $0$ ขณะที่ฟังก์ชันเพดานปัดขึ้นเป็น $1$ — นี่คือความไม่สมมาตรที่เป็นหัวใจของโจทย์
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
  (สำหรับจุดที่ $x$ เป็นจำนวนเต็ม จะได้ $lr(\{ x \}) = 0$ ส่งผลให้พจน์นี้เป็น $0$ ทว่าจุดเหล่านี้เป็นเซตจำกัดบนช่วง $[0, 1000]$ จึงไม่มีผลกระทบต่อค่าของอินทิกรัล)
]

#step(reason: [รวมทุกพจน์บนช่วงเปิด $(k, k+1)$])[
  สำหรับ $x in (k, k+1)$ ซึ่งไม่เป็นจำนวนเต็ม เมื่อรวมทั้งหกพจน์เข้าด้วยกันจะได้:
  $ underbrace(ceil(x), k+1) + underbrace(floor(x), k) + underbrace(0, floor(lr(\{ x \}))) + underbrace(0, lr(\{ floor(x) \})) + underbrace(1, ceil(lr(\{ x \}))) + underbrace(0, lr(\{ ceil(x) \}))
    = 2k + 2 = 2(k+1) = 2 ceil(x). $
]

#step(reason: [การอินทิเกรตฟังก์ชันขั้นบันไดทีละช่วงย่อย])[
  เนื่องจากอินทิกรันด์มีค่าคงที่เท่ากับ $2(k+1)$ บนแต่ละช่วงย่อย $(k, k+1)$ สำหรับ $k = 0, 1, dots, 999$ การอินทิเกรตค่าคงที่บนช่วงที่กว้าง $1$ หน่วย จะได้ผลลัพธ์เท่ากับค่าคงที่นั้น ๆ ดังนั้น
  $ integral_0^1000 (dots.c) dif x = sum_(k=0)^999 integral_k^(k+1) 2(k+1) dif x
    = sum_(k=0)^999 2(k+1) = 2 sum_(j=1)^1000 j. $

  #remark[
    การอินทิเกรตค่าคงที่ $c$ บนช่วงความยาว $1$ ให้ผล $integral_k^(k+1) c dif x = c dot 1 = c$ นั่นคือพื้นที่ของสี่เหลี่ยมแต่ละขั้นในบันไดเท่ากับความสูงพอดี #emph[ไม่ต้องคำนวณซับซ้อน]
  ]
]

#step(reason: [การหาผลรวมอนุกรมเลขคณิต (จับคู่แบบเกาส์)])[
  #remark[
    เคล็ดลับของเกาส์: จับคู่ $j$ กับ $1001-j$ ทุกคู่รวมกันได้ $j + (1001-j) = 1001$ เสมอ และมีทั้งหมด $1000$ คู่ ดังนั้น $2 sum_(j=1)^1000 j = 1000 times 1001$ โดยไม่ต้องใช้สูตรสำเร็จ
  ]
  $ 2 sum_(j=1)^1000 j = sum_(j=1)^1000 (j + (1001 - j)) = sum_(j=1)^1000 1001 = 1000 dot 1001. $
  ดังนั้น
  $ integral_0^1000 (dots.c) dif x = 1000 dot 1001 = 1\,001\,000. $
]

= การตรวจสอบความถูกต้อง

#strong[การคำนวณแยกพจน์อิสระ:] หาค่าอินทิกรัลของ $floor(x)$, $ceil(x)$ และค่าคงที่ $1$ แยกกันบนช่วง $[0, 1000]$:
$ integral_0^1000 floor(x) dif x = sum_(k=0)^999 k = 499\,500, quad
  integral_0^1000 ceil(x) dif x = sum_(k=1)^1000 k = 500\,500, quad
  integral_0^1000 1 dif x = 1000. $
เมื่อนำผลลัพธ์มารวมกันจะได้ $499\,500 + 500\,500 + 1000 = 1\,001\,000$ ซึ่งตรงกับคำตอบเดิม

#diagram(caption: [
  $ceil(x)$ = $floor(x)$ $+ 1$ ทุกช่วง (แถบสีจาง) ผลต่างรวม $= N$ — บน $[0, 1000]$ คือ $1000$ หน่วยพอดี
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

#strong[การทดสอบด้วยการแทนค่า:] สมมติให้ $x = 1.7$ (ซึ่งอยู่ในช่วง $k = 1$):
$floor(ceil(1.7)) = floor(2) = 2$, $ceil(floor(1.7)) = ceil(1) = 1$,
$floor(lr(\{ 1.7 \})) = floor(0.7) = 0$, $lr(\{ floor(1.7) \}) = lr(\{ 1 \}) = 0$,
$ceil(lr(\{ 1.7 \})) = ceil(0.7) = 1$, $lr(\{ ceil(1.7) \}) = lr(\{ 2 \}) = 0$
ผลรวมคือ $2 + 1 + 0 + 0 + 1 + 0 = 4 = 2 ceil(1.7)$ #sym.checkmark

#strong[การตรวจสอบด้วยกรณีทั่วไป:] หากเปลี่ยนช่วงการอินทิเกรตเป็น $[0, N]$ ด้วยวิธีคิดเดียวกันจะได้ผลลัพธ์เป็น $N(N+1)$ เมื่อทดลองแทนค่า $N = 2$: ฟังก์ชัน $2 ceil(x)$ จะมีค่าเท่ากับ $2$ บนช่วง $(0,1)$ และมีค่าเท่ากับ $4$ บนช่วง $(1,2)$ พื้นที่รวมคือ $2 + 4 = 6 = 2 dot 3$ #sym.checkmark

= บทสรุปและมุมมองเพิ่มเติม

โจทย์ข้อนี้ถูกออกแบบขึ้นโดยอาศัยคุณสมบัติความไม่สมมาตรของพจน์คู่ขนานอย่าง $floor(lr(\{ x \}))$ และ $ceil(lr(\{ x \}))$ เนื่องจากภาคเศษส่วนถูกจำกัดให้อยู่ในช่วง $[0, 1)$ เสมอ ส่งผลให้ฟังก์ชันพื้นของมันเป็น $0$ ในทุกจุด ขณะที่ฟังก์ชันเพดานจะมีค่าเป็น $1$ เกือบทุกจุดยกเว้นตรงตำแหน่งจำนวนเต็ม หากผู้อ่านพิจารณาพจน์ที่ห้าผิดพลาดโดยคิดว่าสมมาตรกับพจน์ที่สาม คำตอบที่ได้จะเป็น $1\,000\,000$ ซึ่งเป็นคำตอบลวงที่เป็น#emph[กับดักสำคัญ]ของข้อนี้

#diagram(caption: [
  ถ้าเข้าใจผิดว่า $ceil(lr(\{x\}))=0$: อินทิกรันด์จะเป็น $2k+1$ (เทา) แทน $2k+2$ แถบสีจางคือพื้นที่ $1000$ หน่วยที่หายไป
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

ข้อสังเกตเชิงลึกคือ อินทิกรันด์นี้ไม่ได้มีค่าเท่ากับ $2 ceil(x)$ ที่จุดที่เป็นจำนวนเต็มอย่างสมบูรณ์ (เนื่องจากที่จุดเหล่านั้น $ceil(lr(\{ x \})) = 0$ และค่าของ $ceil(x)$ จะเท่ากับ $floor(x)$) อย่างไรก็ตาม เนื่องจากฟังก์ชันทั้งสองมีค่าต่างกันเฉพาะบนเซตจำกัด (Finite set) ซึ่งมี#emph[มหาภาคเป็นศูนย์] (Measure zero) ค่าอินทิกรัลจำกัดเขตจึงยังคงเท่ากัน การคำนวณแบบฟังก์ชันขั้นบันไดจึงยังคงความถูกต้องแม่นยำ

ในกรณีทั่วไป เราสามารถสรุปสูตรได้ว่า:
$ integral_0^N (dots.c) dif x = N(N+1) = 2 dot (N(N+1))/2, $
ซึ่งคิดเป็นสองเท่าของจำนวนสามเหลี่ยม (Triangular number) ลำดับที่ $N$ และคำตอบ $1\,001\,000$ ในโจทย์ข้อนี้ ก็คือกรณีเฉพาะที่ $N = 1000$ นั่นเอง

#diagram(caption: [
  $N=4$: จุดสีเข้ม $= T_4 = 1+2+3+4 = 10$, จุดทั้งหมด $= 4 times 5 = 20 = 2T_4$ ดังนั้น $sum_(j=1)^N j = N(N+1) slash 2$
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