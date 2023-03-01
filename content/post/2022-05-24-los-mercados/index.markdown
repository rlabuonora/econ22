---
title: "Los mercados I: Competencia Perfecta"
author: ''
date: '2023-04-03'
slug: los-mercados
categories: []
tags: []
---

<script src="{{< blogdown/postref >}}index_files/fitvids/fitvids.min.js"></script>
<style type="text/css">

.twitter-tweet {
  margin: 0 auto;
}

.img-wrap {
  display: flex;
  justify-content: center;
}

</style>

En este unidad analizamos las empresas que operan en mercados competitivos. En estos mercados, todos los agentes están bien informados, no hay diferenciación en los productos, y no hay barreras a la entrada y salida de empresas.

<div class="shareagain" style="min-width:300px;margin:1em auto;">
<iframe src="https://slides-mercados.netlify.app/" width="1600" height="900" style="border:2px solid currentColor;" loading="lazy" allowfullscreen></iframe>
<script>fitvids('.shareagain', {players: 'iframe'});</script>
</div>

# Ejercicio 1

El siguiente gráfico muestra las curvas de ingresos y costos de un productor de trigo.

<div class="img-wrap">

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-3-1.png" width="90%" />

</div>

-   ¿Cuánto es la cantidad producida si el productor maximiza beneficios?
-   ¿Qúe pasa si el productor decide vender su producción a \$2?¿Y a \$4?
-   ¿Cómo son los resultados económicos de este productor?¿Es factible que estos resultados se sostengan en el tiempo?

## Ejercicio 2

El siguiente gráfico muestra las curvas de costos de un productor de soja.

<div class="img-wrap>

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-4-1.png" width="90%" />

</div>

-   Hacer una tabla con la cantidad producida si el precio es \$1, \$2 y \$3. ¿Cómo se llama esta curva?
-   Explicar si la empresa tiene resultados económicos positivos o negativos en cada caso.

<!-- # Ejercicio 1 -->
<!-- Considere un mercado que funciona en competencia perfecta. Analice dos situaciones mostradas en los siguientes gráficos, explicando los resultados de las empresas y la situación de entrada y salida de empresas al mercado. -->
<!-- ```{r} -->
<!-- library(tidyverse) -->
<!-- library(tidyr) -->
<!-- datos <- tibble(  -->
<!--  q = c(0, 1000, 2000, 3000, 3999, 4000, 4001, 5000),  -->
<!--  CT = c(55000, 85000, 110000, 130000, 159960.01, 160000, 160040.01, 210000),  -->
<!--  CMg = c(NA, 27, 22, 21, 38.98, 40, 40.02, 60),  -->
<!--  Precio=40) %>%  -->
<!--   mutate(Cme=CT/q) %>%  -->
<!--   select(-CT) %>%  -->
<!--   pivot_longer(cols=-q) -->
<!-- ``` -->
<!-- ```{r} -->
<!-- library(patchwork) -->
<!-- a <- datos %>% -->
<!--   filter(name!="Precio") %>%  -->
<!--   ggplot(aes(q, value, color=name)) + -->
<!--   geom_hline(yintercept = 50, linetype="dashed") + -->
<!--   geom_line() +  -->
<!--   scale_color_discrete("") + -->
<!--   scale_x_continuous(limits = c(1e3, 5e3)) + -->
<!--   scale_y_continuous(breaks=c(20, 40, 50, 60, 80), -->
<!--                      labels=c("20", "40", "P=50", "60", "80")) + -->
<!--   theme_minimal() + -->
<!--   labs(x="Q", y="CMe, CMg, P", title="A") -->
<!-- b <- datos %>% -->
<!--   filter(name!="Precio") %>%  -->
<!--   ggplot(aes(q, value, color=name)) + -->
<!--   geom_hline(yintercept = 30, linetype="dashed") + -->
<!--   geom_line() +  -->
<!--   scale_color_discrete("") + -->
<!--   scale_x_continuous(limits = c(1e3, 5e3)) + -->
<!--   scale_y_continuous(breaks=c(20, 30, 40, 60, 80), -->
<!--                      labels=c("20", "P=30", "40", "60", "80")) + -->
<!--   theme_minimal() + -->
<!--   labs(x="Q", y="CMe, CMg, P", title="B") -->
<!-- a +  b -->
<!-- ``` -->
<!-- Ahora suponga que la entrada de empresas al sector aumenta la oferta y reduce los precios como se muestra en el siguiente gráfico. Explique la situación, y cuál es el resultado final esperado. -->

## Bibliografía

-   Parkin, M. y Loría. E. (2010). Microeconomía. Editorial: Pearson. Capítulo 12.
