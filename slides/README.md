# Slides

Quarto slide decks live here.

## Layout

- One deck per folder: `slides/<slug>/index.qmd`
- Rendered output goes to `static/slides/<slug>/`
- Lesson posts can then link to or embed `/slides/<slug>/`

## Commands

- `make slides-check`
- `make slides-render`

## Migration Pattern

For each lesson:

1. Create `slides/<slug>/index.qmd`
2. Copy teaching content from the legacy xaringan repo
3. Rebuild the deck with `make slides-render`
4. Update the lesson post to reference `/slides/<slug>/`

Do not edit files inside `static/slides/` directly.
