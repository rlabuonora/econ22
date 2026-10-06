# Textbook-style diagram inventory

23 active raster diagrams were reconstructed as editable R-generated SVGs. This classification is based on appearance and figure captions; book editions are not confirmed. Original raster files remain as references.

Run `make slides-charts` to regenerate these and the externalities diagrams. The implementation is in `scripts/render-textbook-diagrams.R`, with shared colors and typography in `slides/_shared/chart-theme.R`.

| Deck | Slide | Original image | Replacement SVG |
| --- | --- | --- | --- |
| elasticidad-eficiencia-e-impuestos | Elasticidad precio de la demanda | `parkin_elasticidad.png` | `figs/elasticidad-cambio-oferta.svg` |
| elasticidad-eficiencia-e-impuestos | Elasticidad e ingresos | `casos.png` | `figs/elasticidad-ingresos.svg` |
| elasticidad-eficiencia-e-impuestos | Disposición a pagar (1) | `demanda_individual_mercado.png` | `figs/demanda-individual-mercado.svg` |
| elasticidad-eficiencia-e-impuestos | Disposición a pagar (2) | `demanda_excedente.png` | `figs/excedente-consumidor.svg` |
| elasticidad-eficiencia-e-impuestos | Excedente del productor (1) | `oferta_individual_mercado.png` | `figs/oferta-individual-mercado.svg` |
| elasticidad-eficiencia-e-impuestos | Excedente del productor (2) | `oferta_excedente.png` | `figs/excedente-productor.svg` |
| elasticidad-eficiencia-e-impuestos | Equilibrio y excedentes | `equilibrio_excedentes.png` | `figs/equilibrio-excedentes.svg` |
| elasticidad-eficiencia-e-impuestos | Equilibrio y eficiencia | `eficiencia.png` | `figs/eficiencia.svg` |
| elasticidad-eficiencia-e-impuestos | Sobreproducción | `sobreproduccion.png` | `figs/sobreproduccion.svg` |
| elasticidad-eficiencia-e-impuestos | Subproducción | `subproduccion.png` | `figs/subproduccion.svg` |
| elasticidad-eficiencia-e-impuestos | Análisis económico | `impuesto.png` | `figs/impuesto-incidencia.svg` |
| introduccion | El diagrama del flujo circular | `flujo_circular.png` | `figs/flujo-circular.svg` |
| las-empresas | Función de producción | `funcion_prod.png` | `figs/funcion-produccion.svg` |
| las-empresas | Costos medios, fijos y marginales | `costos.png` | `figs/costos-medios-marginal.svg` |
| las-empresas | Costos medios, fijos y marginales (2) | `curvas_costos.png` | `figs/curvas-costo-total.svg` |
| los-mercados | Maximización de beneficios (2) | `costo_marginal_ingreso_marginal.png` | `figs/maximizacion-beneficio.svg` |
| los-mercados-ii-monopolio | Gráficamente | `max_beneficio.png` | `figs/monopolio-beneficio.svg` |
| macroeconomia | Oferta y demanda agregadas | `modelo_oa_da.png` | `figs/modelo-oferta-demanda.svg` |
| macroeconomia | Componentes de la demanda agregada | `componentes_da.png` | `figs/componentes-demanda-agregada.svg` |
| macroeconomia | Movimientos en la demanda agregada | `movs_da.png` | `figs/movimientos-demanda-agregada.svg` |
| macroeconomia | Equilibrio macroeconómico | `equilibrio_macro.png` | `figs/equilibrio-agregado.svg` |
| macroeconomia | Shock en la demanda | `shock_demanda.png` | `figs/shock-demanda-agregada.svg` |
| mercado-de-trabajo | Mercado de trabajo segmentado | `cirujanos.png` | `figs/mercados-segmentados.svg` |

## Reconstruction assumptions

These are teaching diagrams, not digitized empirical observations. Linear, reciprocal, polynomial and exponential curves reproduce the economic relationships; smooth intermediate points are illustrative.

- Individual demand: at price 1, Elisa buys 30 and Nicolás 10; market demand is their horizontal sum, 40. Individual supply: at price 15, Max supplies 100 and Mario 50; total supply is 150.
- Pizza market: demand `25 − Q`, supply `5 + Q`; equilibrium `Q = 10`, `P = 15`. Underproduction uses `Q = 5`; overproduction uses `Q = 15`.
- Gasoline tax: original equilibrium `Q = 100`, `P = 2`; tax of 2 yields `Q = 80`, buyer price 3.80 and seller price 1.80. The reconstructed lines pass through those anchors.
- Production: visible total-product anchors are 0, 2000, 3000, 3500, 3800 and 3900. Marginal product is their consecutive difference.
- Average costs: illustrative coherent functions satisfy `CTM = CVM + CFM`, with marginal cost crossing average total and variable costs at their minima. Total-cost chart is a separate example, preserving fixed cost 25 and variable cost 100 at output 13.
- Competitive firm: increasing marginal cost meets price/marginal revenue 25 at output 9.
- Monopoly: demand `200 − 20Q`, marginal revenue `200 − 40Q`; marginal cost meets marginal revenue at `Q = 4`, price 120, average cost 60 and profit 240. Cost functions are illustrative and mutually consistent.
- Macro curves and labor-market curves are schematic. Macro equilibrium is real output 3000 and price level 150; the positive demand shock increases both. Labor curves illustrate segmented markets, without claiming measured wage data.
- Circular flow distinguishes real flows (blue) from money flows (brown). The macro model preserves the original causal groups and outcomes.

## Retained data graphics

Historical GDP, demographic, newspaper and research charts retain their originals because reproducing them accurately requires their underlying data. They were not converted into illustrative curves. Original files not referenced by current slide sources are retained as archived assets.

## Additional textbook scans: migration audit

The 17 files initially labelled “unused” require three distinct classifications. See [the migration audit](TEXTBOOK-MIGRATION-AUDIT.md) for pinned original sources and slide-by-slide evidence.

- **8 restored diagrams:** confirmed migration omissions have been restored in Quarto using their original screenshots. Conversion to R remains pending.
- **7 already unreferenced diagrams:** the original Rmd decks did not use them.
- **2 unresolved diagrams:** the original Oferta y Demanda source could not be located; their old hosted deck returns 404.

| File | Migration audit finding |
| --- | --- |
| `slides/oferta-y-demanda/imgs/elasticidad.png` | Unresolved |
| `slides/oferta-y-demanda/imgs/extremos.png` | Unresolved |
| `slides/los-consumidores/imgs/excedente_2.png` | Already unused |
| `slides/los-consumidores/imgs/excedente_1.png` | Already unused |
| `slides/los-mercados/imgs/costos_crecientes.png` | Already unused |
| `slides/los-mercados/imgs/oferta_lp.png` | Already unused |
| `slides/los-mercados/imgs/oferta_costo_marginal.png` | Already unused |
| `slides/los-mercados/imgs/oferta_fija.png` | Already unused |
| `slides/los-mercados/imgs/costos_constantes.png` | Already unused |
| `slides/los-mercados/imgs/punto_de_cierre.png` | Restored screenshot; R conversion pending |
| `slides/los-mercados/imgs/tres_resultados.png` | Restored screenshot; R conversion pending |
| `slides/los-mercados-ii-monopolio/imgs/demanda_en_competencia_imperfecta.png` | Restored screenshot; R conversion pending |
| `slides/los-mercados-ii-monopolio/imgs/costos_y_estructura_de_mercado.png` | Restored screenshot; R conversion pending |
| `slides/las-empresas/imgs/mejora_tecnologica.png` | Restored screenshot; R conversion pending |
| `slides/las-empresas/imgs/productividad_costos.png` | Restored screenshot; R conversion pending |
| `slides/las-empresas/imgs/costos_beneficios.png` | Restored screenshot; R conversion pending |
| `slides/los-mercados-ii-monopolio/imgs/costos.png` | Restored screenshot; R conversion pending |

Additional archived copies of `flujo_circular.png` exist in `las-empresas`, `los-consumidores` and `mercado-de-trabajo`.
