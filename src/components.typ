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
