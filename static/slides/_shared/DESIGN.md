# Reusable course slide designs

The labor-market deck contains four working examples. All use `.course-slide`, the same 48 px heading, blue divider, 38 px sans-serif body, and fixed spacing on a 1600 × 900 canvas. The shared base stylesheet imports `layouts.css`; other slides opt in by adding the class.

| Layout | Example | Use |
| --- | --- | --- |
| Text | Ingresos y factores de producción | A short explanation or list, with one nested level |
| Chart + takeaway | Q = 2 no es de equilibrio | One chart and one teaching conclusion |
| Large image | Desempleo cíclico | One photograph, preserved aspect ratio |
| Text + image | Desempleo friccional | Short explanation beside a photograph or diagram |

## Text

```markdown
## Título {.course-slide}

- Idea principal
- Segunda idea
```

## Chart + takeaway

```markdown
## Título {.course-slide}

::: {.visual}
![](figs/chart.svg){.plain .nostretch fig-alt="Describe the chart's meaning."}
:::

::: {.takeaway}
Una conclusión breve.
:::
```

For a large image, use the same visual container without the takeaway. An optional `.source` paragraph below it holds an attribution; do not invent missing historical sources.

## Text + image

```markdown
## Título {.course-slide}

::: {.split}
::: {.explanation}
Una explicación breve.

**Ejemplo:** un caso concreto.
:::
::: {.visual}
![](imgs/example.png){.plain .nostretch fig-alt="Describe the image."}
:::
:::
```

## Graphical elements

Use white backgrounds, dark ink `#23313d` for axes and labels, blue `#5e82ae` for the focal series or bar, gray `#c5cdd5` for context, and warm brown `#b36b35` for a reference line. Grid lines use `#e8edf2`. Combine color with direct labels or dashed lines so meaning does not depend on color alone. Use sans-serif labels at 30–36 px on a roughly 1400 px wide graphic. Avoid legends when a direct label fits. Keep photos uncropped and undistorted.

`../mercado-de-trabajo/figs/vpmg-salario.svg` is an editable chart example using these conventions. CSS does not recolor existing PNG charts; recreate those from source when adopting the design. Existing slide layouts retain their styling until explicitly migrated.

Render all decks with `make slides-render`.

## Integrated photographs

Load `../_shared/photos.css` explicitly in the deck's `format.revealjs.css` list.
A photographic slide places its heading and short explanation over a large image,
with a soft fade behind the text. No title divider, separate image box, or bottom
caption panel is used. Keep the subject in the clear portion of the image.

```markdown
## Título {.photo-slide background-image="imgs/photo.jpg" background-size="cover" background-position="right center"}

::: {.photo-copy}
Una explicación breve o hasta tres puntos.
:::
```

Use `.photo-text-right` when the subject is on the left. Use `.photo-title-only`
for a photograph with just a title (the fade then runs from the top). Portraits
can use `background-size="auto 100%"` and `background-position="right center"`
to avoid cropping faces. Charts, diagrams, tables, and informational screenshots
must not use this photographic layout. Existing section covers retain their design.
