# Audit of the 17 additional textbook scans

Checked 2026-10-06. “Unused” describes current references, not whether a diagram belonged in the course. The earlier inventory was too broad: **8 diagrams were present before migration and are now omitted; 7 were already unreferenced in the original decks; 2 cannot yet be verified.**

## Evidence and scope

Compared the original Xaringan `index.Rmd` files at the last source commit before migration with both the initial Quarto conversion and the current sources. The original course posts point to separate Netlify sites; those sites currently return HTTP 404. The original Rmd files remain available in the author's GitHub repositories. The audit uses pinned commits from 2022, rather than assuming current repository contents represent the originals.

The main conversion is commit `c1c8848` (2026-03-09); Oferta y Demanda was converted separately in `8ee5ba4`. Commit `05cb2d8` (2026-08-13) repaired several missing/incorrect image references, but did not restore the eight figures below. “Omitted” establishes absence; it does not establish whether that absence was intentional.

| File | Finding | Original slide / evidence |
| --- | --- | --- |
| `slides/oferta-y-demanda/imgs/elasticidad.png` | Unresolved | The old Netlify deck returns 404; no original source repository located. |
| `slides/oferta-y-demanda/imgs/extremos.png` | Unresolved | The old Netlify deck returns 404; no original source repository located. |
| `slides/los-consumidores/imgs/excedente_2.png` | Already unused | [No reference in the original pre-migration Rmd.](https://github.com/rlabuonora/slides-consumidores/blob/a32f79d42ce8e3bd58120cad906a7dde413a361e/index.Rmd) |
| `slides/los-consumidores/imgs/excedente_1.png` | Already unused | [No reference in the original pre-migration Rmd.](https://github.com/rlabuonora/slides-consumidores/blob/a32f79d42ce8e3bd58120cad906a7dde413a361e/index.Rmd) |
| `slides/los-mercados/imgs/costos_crecientes.png` | Already unused | [No reference in the original pre-migration Rmd.](https://github.com/rlabuonora/slides-compentencia/blob/d863da4436e9a521f7cbe1a242fde26326eb3fc7/index.Rmd) |
| `slides/los-mercados/imgs/oferta_lp.png` | Already unused | [No reference in the original pre-migration Rmd.](https://github.com/rlabuonora/slides-compentencia/blob/d863da4436e9a521f7cbe1a242fde26326eb3fc7/index.Rmd) |
| `slides/los-mercados/imgs/oferta_costo_marginal.png` | Already unused | [No reference in the original pre-migration Rmd.](https://github.com/rlabuonora/slides-compentencia/blob/d863da4436e9a521f7cbe1a242fde26326eb3fc7/index.Rmd) |
| `slides/los-mercados/imgs/oferta_fija.png` | Already unused | [No reference in the original pre-migration Rmd.](https://github.com/rlabuonora/slides-compentencia/blob/d863da4436e9a521f7cbe1a242fde26326eb3fc7/index.Rmd) |
| `slides/los-mercados/imgs/costos_constantes.png` | Already unused | [No reference in the original pre-migration Rmd.](https://github.com/rlabuonora/slides-compentencia/blob/d863da4436e9a521f7cbe1a242fde26326eb3fc7/index.Rmd) |
| `slides/los-mercados/imgs/punto_de_cierre.png` | Confirmed omitted | [Punto de cierre](https://github.com/rlabuonora/slides-compentencia/blob/d863da4436e9a521f7cbe1a242fde26326eb3fc7/index.Rmd#L211) |
| `slides/los-mercados/imgs/tres_resultados.png` | Confirmed omitted | [Tres resultados posibles](https://github.com/rlabuonora/slides-compentencia/blob/d863da4436e9a521f7cbe1a242fde26326eb3fc7/index.Rmd#L180) |
| `slides/los-mercados-ii-monopolio/imgs/demanda_en_competencia_imperfecta.png` | Confirmed omitted | [Elasticidad de la demanda](https://github.com/rlabuonora/slides-monopolio/blob/5c86c4390d6da3f669faf4b70f38c358381999b3/index.Rmd#L105) |
| `slides/los-mercados-ii-monopolio/imgs/costos_y_estructura_de_mercado.png` | Confirmed omitted | [Costos y Competencia Imperfecta](https://github.com/rlabuonora/slides-monopolio/blob/5c86c4390d6da3f669faf4b70f38c358381999b3/index.Rmd#L147) |
| `slides/las-empresas/imgs/mejora_tecnologica.png` | Confirmed omitted | [Cambio tecnológico](https://github.com/rlabuonora/slides-empresas/blob/9189b6b88d7c93778223bc403399d3dd200a00c0/index.Rmd#L194) |
| `slides/las-empresas/imgs/productividad_costos.png` | Confirmed omitted | [Productividad marginal y costos](https://github.com/rlabuonora/slides-empresas/blob/9189b6b88d7c93778223bc403399d3dd200a00c0/index.Rmd#L343) |
| `slides/las-empresas/imgs/costos_beneficios.png` | Confirmed omitted | [Costos y maximización de beneficio](https://github.com/rlabuonora/slides-empresas/blob/9189b6b88d7c93778223bc403399d3dd200a00c0/index.Rmd#L355) |
| `slides/los-mercados-ii-monopolio/imgs/costos.png` | Confirmed omitted | [Ingresos, beneficios y costos](https://github.com/rlabuonora/slides-monopolio/blob/5c86c4390d6da3f669faf4b70f38c358381999b3/index.Rmd#L230) |

## What was lost

- **Las Empresas (3):** technological-change comparison; productivity and costs; total revenue, total cost and profit maximization. The corresponding Quarto slides retain brief text but omit the charts. The last slide also changes the original total-revenue/total-cost explanation to a marginal comparison.
- **Los Mercados I (2):** three short-run outcomes and the shutdown-point chart. Both slide titles and explanatory text remain, but their figures are absent.
- **Los Mercados II (3):** firm demand under perfect/imperfect competition; costs and market structure; total revenue, costs and profit. The costs-and-market-structure slide itself is absent; the other two topics remain as text.

These eight should be included in the R reconstruction queue before being treated as archived extras. Restoring the market-structure slide also requires its explanation of market demand relative to minimum efficient scale. The original imperfect-competition wording should be corrected: a downward-sloping firm demand curve is not necessarily inelastic, and an optimizing monopolist chooses an elastic region when marginal cost is positive.

## Already unreferenced in the original sources (7)

The two consumer-surplus scans and five additional competitive-market scans (increasing costs, long-run supply, firm supply/marginal cost, fixed supply, constant costs) were stored in the old repositories but did not appear in the original `index.Rmd` decks checked. Their absence from Quarto therefore is not evidence of a migration loss.

## Unresolved (2)

`oferta-y-demanda/imgs/elasticidad.png` and `extremos.png`: the old course post points to `https://slides-oferta-demanda.netlify.app/`, which currently returns 404; no source repository was found among the author's public repositories. The current Quarto deck does contain R-generated elasticity and extreme-case charts in the separate elasticity unit, but this does not prove these two images were deliberately replaced. Do not classify these files as intentionally unused without the original Oferta y Demanda source.

## Deck changes

This audit updates documentation only. No diagrams or slides have been restored in this pass.
