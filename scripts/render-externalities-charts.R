# Run from the repository root with scripts/with-project-env.sh.
# Equations reconstructed from the original lecture charts (illustrative units).
library(ggplot2)
source("slides/_shared/chart-theme.R")
out <- "slides/externalidades-y-bienes-p-blicos/figs"
dir.create(out, recursive = TRUE, showWarnings = FALSE)
pal <- course_palette
base <- function(xmax, ymax, xbreaks, ybreaks) {
  ggplot() + course_chart_theme() +
    scale_x_continuous(limits = c(0, xmax), breaks = xbreaks, expand = expansion(mult = c(0, .01))) +
    scale_y_continuous(limits = c(0, ymax), breaks = ybreaks, expand = expansion(mult = c(0, .03))) +
    labs(x = "Cantidad (Q)", y = "Valor marginal")
}
curve <- function(fun, end, color, type = "solid") {
  geom_function(fun = fun, xlim = c(0, end), color = color, linewidth = 1.1, linetype = type)
}
label <- function(x, y, text, color = pal[["ink"]]) {
  annotate("text", x = x, y = y, label = text, color = color, hjust = 0, size = 7)
}
point <- function(q, p, name = NULL) {
  layers <- list(
    annotate("segment", x = q, xend = q, y = 0, yend = p, color = pal[["guide"]], linetype = "dotted"),
    annotate("segment", x = 0, xend = q, y = p, yend = p, color = pal[["guide"]], linetype = "dotted"),
    annotate("point", x = q, y = p, size = 3.5, color = pal[["ink"]]))
  if (!is.null(name)) layers <- c(layers, list(label(q + .15, p + .07, name)))
  layers
}
loss <- function(lo, hi, lower, upper) {
  q <- seq(lo, hi, length.out = 201)
  geom_ribbon(data = data.frame(q, lower = lower(q), upper = upper(q)),
              aes(x = q, ymin = lower, ymax = upper), fill = pal[["social"]], alpha = .18)
}
save <- function(name, p, width = 13, height = 6.7) {
  ggsave(file.path(out, paste0(name, ".svg")), p, device = svglite::svglite,
         width = width, height = height, bg = "white")
}
# Public good: social benefit 4 - Q/2, marginal cost 1 + Q/2.
# Zero private provision is an assumed free-riding outcome, not a universal result.
pub_b <- function(q) 4 - q / 2
pub_c <- function(q) 1 + q / 2
q_pub <- uniroot(function(q) pub_b(q) - pub_c(q), c(0, 6))$root
pub <- base(6.5, 4.5, 0:6, 0:4) +
  curve(pub_b, 5.5, pal[["social"]], "longdash") + curve(pub_c, 5.5, pal[["ink"]]) +
  label(5.6, pub_b(5.5), "BMS", pal[["social"]]) + label(5.6, pub_c(5.5), "CMS") +
  point(q_pub, pub_b(q_pub)) + point(0, 0)
save("bien-publico", pub, width = 9.5, height = 7.2)
# Education: preserves the original different slopes of BMP and BMS.
bmp <- function(q) 20 - 2 * q / 3
bms <- function(q) 50 - 5 * q / 3
cms <- function(q) 5 + 4 * q / 3
q_m_pos <- uniroot(function(q) bmp(q) - cms(q), c(0, 25))$root
q_s_pos <- uniroot(function(q) bms(q) - cms(q), c(0, 25))$root
edu <- base(32, 52, seq(0, 30, 5), seq(0, 50, 10)) +
  curve(bmp, 27, pal[["private"]]) + curve(bms, 27, pal[["social"]], "longdash") +
  curve(cms, 25, pal[["ink"]]) + label(27.5, bmp(27), "BMP", pal[["private"]]) +
  label(27.5, bms(27), "BMS", pal[["social"]]) + label(25.5, cms(25), "CMS")
save("educacion-beneficios", edu + point(q_s_pos, bmp(q_s_pos)) + point(q_s_pos, bms(q_s_pos)))
save("educacion-mercado", edu + point(q_m_pos, bmp(q_m_pos)))
save("educacion-perdida", edu + loss(q_m_pos, q_s_pos, cms, bms) +
       point(q_m_pos, bmp(q_m_pos)) + point(q_s_pos, bms(q_s_pos)))
# Negative externality: demand 1600 - 100Q; CMP 400 + 100Q; CMS 400 + 200Q.
demand <- function(q) 1600 - 100 * q
cmp <- function(q) 400 + 100 * q
cms_neg <- function(q) 400 + 200 * q
q_m <- uniroot(function(q) demand(q) - cmp(q), c(0, 10))$root
q_s <- uniroot(function(q) demand(q) - cms_neg(q), c(0, 10))$root
tax <- cms_neg(q_s) - cmp(q_s)
neg <- base(10.5, 1950, seq(0, 10, 2), seq(0, 1800, 400)) +
  curve(demand, 8, pal[["ink"]]) + curve(cmp, 8, pal[["private"]]) +
  curve(cms_neg, 7, pal[["social"]], "longdash") +
  label(8.2, demand(8), "BMS = demanda") + label(8.2, cmp(8), "CMP", pal[["private"]]) +
  label(7.2, cms_neg(7), "CMS", pal[["social"]])
save("externalidad-costos", neg)
save("externalidad-mercado", neg + point(q_m, demand(q_m)))
save("externalidad-eficiente", neg + point(q_s, demand(q_s)))
save("externalidad-perdida", neg + loss(q_s, q_m, demand, cms_neg) +
       point(q_m, demand(q_m)) + point(q_s, demand(q_s)))
# A constant tax equals external marginal cost AT Q*, not at every quantity.
# Therefore CMP + t crosses CMS only at Q*, rather than coinciding everywhere.
save("externalidad-impuesto", neg +
       curve(function(q) cmp(q) + tax, 8, pal[["private"]], "dotdash") +
       label(8.2, cmp(8) + tax, "CMP + t", pal[["private"]]) +
       point(q_s, demand(q_s)) + point(q_s, cmp(q_s)) +
       annotate("segment", x = q_s, xend = q_s, y = cmp(q_s), yend = demand(q_s),
                linewidth = 1.5, color = pal[["social"]]) +
       label(q_s + .25, 1000, paste0("t = ", round(tax)), pal[["social"]]))
# Verify the reconstructed equilibria and welfare areas independently.
stopifnot(abs(q_pub - 3) < 1e-8, abs(q_m_pos - 7.5) < 1e-8,
          abs(q_s_pos - 15) < 1e-8, abs(q_m - 6) < 1e-8,
          abs(q_s - 4) < 1e-8, abs(tax - 400) < 1e-8,
          abs(integrate(function(q) bms(q) - cms(q), q_m_pos, q_s_pos)$value - 84.375) < 1e-6,
          abs(integrate(function(q) cms_neg(q) - demand(q), q_s, q_m)$value - 600) < 1e-6)
cat("Generated nine SVG charts; equilibrium, tax, and welfare checks passed.\n")
