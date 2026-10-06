# Reproducible lecture charts

Run `make slides-charts` from the repository root to regenerate the nine SVGs.
`make slides-render` runs this automatically using the isolated project R 4.5.3.

Source: `scripts/render-externalities-charts.R`.
Shared style: `slides/_shared/chart-theme.R`.

The equations below reconstruct the original PNG diagrams; they are illustrative,
not empirical estimates. Original PNGs remain available as references.

| Example | Curves | Market quantity | Efficient quantity |
| --- | --- | --- | --- |
| Public good | BMS = 4 − Q/2; CMS = 1 + Q/2 | 0, explicitly assumed | 3 |
| Education | BMP = 20 − 2Q/3; BMS = 50 − 5Q/3; CMS = 5 + 4Q/3 | 7.5 | 15 |
| Negative externality | BMS = 1600 − 100Q; CMP = 400 + 100Q; CMS = 400 + 200Q | 6 | 4 |

The education welfare loss is 84.375 illustrative monetary units; the negative
externality welfare loss is 600. The script checks these areas and the equilibria.

The corrective tax is CMS(4) − CMP(4) = 400 per unit. A constant per-unit tax
shifts CMP to CMP + 400; that curve equals CMS only at Q = 4 because the external
marginal cost varies with quantity. Consumer price is 1200 and net producer price
is 800. Blue represents private curves; dashed brown represents social curves;
dark ink represents the remaining benefit or cost curve. Shading marks welfare
loss, not tax revenue. Labels and line styles supplement color.
