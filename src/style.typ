// Central theme for the whole showcase. Change colors/fonts here once and every
// problem updates. A problem can also override any key per-document:
//   #show: doc.with(theme: (accent: rgb("#0a7"), ...))
// The override cascades to the theorem environments too (via `theme-state`).

#let default-theme = (
  // palette
  primary: rgb("#1b2a4a"),        // deep navy, titles + headings
  accent: rgb("#b5403a"),         // muted crimson, rules + theorem bars
  muted: rgb("#6b7280"),          // metadata, captions
  rule: rgb("#dde2ea"),           // hairlines
  ink: rgb("#1a1a1a"),            // body text

  // environment fills
  thm-fill: rgb("#f3f6fb"),       // theorem / lemma / corollary / proposition
  def-fill: rgb("#eef5f1"),       // definition
  def-accent: rgb("#2f7d5b"),
  insight-fill: rgb("#fff7e3"),   // key insight callout
  insight-accent: rgb("#d99a00"),

  // typography
  // "New Computer Modern" ships bundled with Typst, so CI and local builds
  // match without installing system fonts. Libertinus Serif is a safe fallback.
  font: ("New Computer Modern", "Libertinus Serif"),
  size: 11pt,
)

// Live theme, so theorem environments pick up per-document overrides.
#let theme-state = state("mshow-theme", default-theme)

// Backwards-compatible convenience exports (use defaults).
#let theme = default-theme
#let primary = default-theme.primary
#let accent = default-theme.accent
#let surface = default-theme.thm-fill
#let doc-font = default-theme.font
#let doc-size = default-theme.size
