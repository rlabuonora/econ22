# Reconstructed teaching diagrams, not digitized empirical data.
# Run from the repository root with scripts/with-project-env.sh.
library(ggplot2)
library(patchwork)
source("slides/_shared/chart-theme.R")
blue <- course_palette[["private"]]; brown <- course_palette[["social"]]
ink <- course_palette[["ink"]]; grey <- course_palette[["guide"]]
base <- function(xmax, ymax, xlab="Cantidad", ylab="Precio", xmin=0, ymin=0) {
  ggplot() + course_chart_theme() +
    scale_x_continuous(limits=c(xmin,xmax), expand=expansion(mult=c(0,.04))) +
    scale_y_continuous(limits=c(ymin,ymax), expand=expansion(mult=c(0,.05))) +
    labs(x=xlab,y=ylab)
}
line <- function(x,y,color=blue,type="solid") {
  geom_line(data=data.frame(x,y),aes(x,y),color=color,linewidth=1.1,linetype=type)
}
fun <- function(f,lo,hi,color=blue,type="solid") {
  x<-seq(lo,hi,length.out=401);line(x,f(x),color,type)
}
lab <- function(x,y,text,color=ink,align=0,size=6) {
  annotate("text",x=x,y=y,label=text,color=color,hjust=align,size=size)
}
point <- function(x,y,color=ink) annotate("point",x=x,y=y,color=color,size=3)
guide <- function(x,y,color=grey) list(
  annotate("segment",x=0,xend=x,y=y,yend=y,color=color,linetype="dotted"),
  annotate("segment",x=x,xend=x,y=0,yend=y,color=color,linetype="dotted"))
area <- function(lo,hi,lower,upper,color=blue) {
  x<-seq(lo,hi,length.out=201)
  geom_ribbon(data=data.frame(x,lo=lower(x),hi=upper(x)),aes(x=x,ymin=lo,ymax=hi),fill=color,alpha=.18)
}
arrow <- function(x,y,x2,y2,color=ink,both=FALSE) {
  annotate("segment",x=x,xend=x2,y=y,yend=y2,color=color,linewidth=.7,
           arrow=grid::arrow(length=grid::unit(.12,"inches"),ends=if(both) "both" else "last"))
}
save <- function(deck,name,p,width=13,height=6.7) {
  out<-file.path("slides",deck,"figs");dir.create(out,recursive=TRUE,showWarnings=FALSE)
  ggsave(file.path(out,paste0(name,".svg")),p,device=svglite::svglite,width=width,height=height,bg="white")
}
E<-"elasticidad-eficiencia-e-impuestos"
# Elasticity: identical supply shift meets steeper/flatter demand curves.
elasticity <- function(steep) {
 d<-if(steep) function(q) 60-4*q else function(q) 25-.5*q
 s<-function(q) 2*q
 s2<-function(q) 2*q-15
 qm<-uniroot(function(q)d(q)-s(q),c(0,25))$root
 qs<-uniroot(function(q)d(q)-s2(q),c(0,25))$root
 base(25,45,"Cantidad (pizzas por hora)","Precio") +
  fun(d,if(steep) 4 else 0,if(steep) 14 else 25) +
  fun(s,0,20,grey) + fun(s2,7.5,25,brown,"longdash") +
  guide(qm,d(qm)) + guide(qs,d(qs)) + point(qm,d(qm)) + point(qs,d(qs)) +
  arrow(qm,d(qm)+3,qs,d(qm)+3,brown) +
  lab(19,40,"Oferta inicial",grey,align=1,size=4.5) +
  lab(23,28,"Más oferta",brown,align=1,size=4.5) +
  labs(title=if(steep) "Demanda menos elástica" else "Demanda más elástica")
}
save(E,"elasticidad-cambio-oferta",elasticity(TRUE)+elasticity(FALSE),16,7)
# Three categories use the original A/B coordinates and exact rectangle areas.
a<-base(3.6,1250,"Cantidad (millones)","Precio") + fun(function(q)1250-250*q,0,3.5) +
 area(0,1,function(x)0*x,function(x)1000+0*x)+area(0,3,function(x)0*x,function(x)500+0*x,brown)+
 guide(1,1000)+guide(3,500)+point(1,1000)+point(3,500)+labs(title="Elástica: ingreso aumenta")
b<-base(2500,1.4,"Cantidad (millones)","Precio")+fun(function(q)1000/q,750,2500)+
 area(0,1000,function(x)0*x,function(x)1+0*x)+area(0,2000,function(x)0*x,function(x).5+0*x,brown)+
 guide(1000,1)+guide(2000,.5)+point(1000,1)+point(2000,.5)+labs(title="Unitaria: ingreso constante")
c<-base(22,5,"Cantidad (millones)","Precio")+fun(function(q)8-.4*q,8,20)+
 area(0,10,function(x)0*x,function(x)4+0*x)+area(0,15,function(x)0*x,function(x)2+0*x,brown)+
 guide(10,4)+guide(15,2)+point(10,4)+point(15,2)+labs(title="Inelástica: ingreso disminuye")
save(E,"elasticidad-ingresos",a+b+c,18,7)
# Horizontal aggregation at a price of 1: Elisa 30, Nicolas 10, market 40.
elisa<-function(q)2.5-.05*q; nicolas<-function(q)1.5-.05*q
market<-function(q)ifelse(q<=20,2.5-.05*q,2-.025*q)
demand_panel<-function(f,qmax,qstar,title,shade=FALSE) {
 p<-base(qmax,3,"Rebanadas por mes","Precio por rebanada")+
  fun(f,0,qmax-5)+guide(qstar,1)+point(qstar,1)+
  geom_hline(yintercept=1,color=brown,linetype="longdash")+
  labs(title=title)
 if(shade)p<-p+area(0,qstar,function(x)1+0*x,f)
 p
}
d1<-demand_panel(elisa,45,30,"Elisa")
d2<-demand_panel(nicolas,25,10,"Nicolás")
d3<-demand_panel(market,65,40,"Mercado: 30 + 10 = 40")
save(E,"demanda-individual-mercado",d1+d2+d3,18,7)
save(E,"excedente-consumidor",
 demand_panel(elisa,45,30,"Elisa",TRUE)+demand_panel(nicolas,25,10,"Nicolás",TRUE)+
 demand_panel(market,65,40,"Mercado",TRUE),18,7)
# Individual supplies horizontally aggregate: 100 + 50 = 150 at price 15.
max_s<-function(q)5+.1*q; mario_s<-function(q).3*q; market_s<-function(q)ifelse(q<=100/6,.3*q,3.75+.075*q)
supply_panel<-function(f,qmax,qstar,title,shade=FALSE) {
 p<-base(qmax,32,"Pizzas por mes","Precio por pizza")+
  fun(f,0,qmax-20)+guide(qstar,15)+point(qstar,15)+
  geom_hline(yintercept=15,color=brown,linetype="longdash")+labs(title=title)
 if(shade)p<-p+area(0,qstar,f,function(x)15+0*x)
 p
}
save(E,"oferta-individual-mercado",supply_panel(max_s,220,100,"Max")+
 supply_panel(mario_s,120,50,"Mario")+supply_panel(market_s,300,150,"Mercado: 100 + 50 = 150"),18,7)
save(E,"excedente-productor",supply_panel(max_s,220,100,"Max",TRUE)+
 supply_panel(mario_s,120,50,"Mario",TRUE)+supply_panel(market_s,300,150,"Mercado",TRUE),18,7)
# Pizza market: D = 25-Q, S = 5+Q, efficient Q=10 and P=15.
D<-function(q)25-q; S<-function(q)5+q
pizza<-base(25,30,"Cantidad (miles de pizzas por día)","Precio por pizza")+
 fun(D,0,23,blue)+fun(S,0,23,brown,"longdash")+
 lab(21,3,"D = BMS",blue,align=1)+lab(21,28,"O = CMS",brown,align=1)+
 guide(10,15)+point(10,15)
save(E,"equilibrio-excedentes",pizza+area(0,10,function(x)15+0*x,D,blue)+
 area(0,10,S,function(x)15+0*x,brown))
save(E,"eficiencia",pizza+arrow(5,19,5,12)+arrow(15,12,15,19)+
 lab(1,23,"BMS > CMS",blue)+lab(14,6,"CMS > BMS",brown))
save(E,"sobreproduccion",pizza+area(0,10,S,D)+area(10,15,D,S,brown)+
 guide(15,20)+lab(15.5,17,"Pérdida de\neficiencia",brown))
save(E,"subproduccion",pizza+area(0,5,S,D)+area(5,10,S,D,brown)+
 guide(5,20)+lab(1,27,"Pérdida de eficiencia: Q = 5 a Q = 10",brown,size=5))
# Gasoline tax: untaxed Q=100,P=2; taxed Q=80, buyer P=3.8, seller P=1.8.
Ds<-function(q)11-.09*q; Ss<-function(q)1+.01*q
p<-base(170,5,"Cantidad (miles de millones de galones)","Precio por galón")+
 fun(Ds,70,120,ink)+fun(Ss,40,160,blue)+fun(function(q)Ss(q)+2,40,160,brown,"longdash")+
 guide(80,3.8)+guide(80,1.8)+guide(100,2)+point(80,3.8)+point(80,1.8)+point(100,2)+
 arrow(80,1.8,80,3.8,brown,TRUE)+lab(85,3.3,"t = 2,00",brown)+
 lab(148,4.6,"O + t",brown)+lab(155,2.9,"O",blue)+lab(115,.55,"D",ink)+
 lab(2,4.5,"Compradores: 3,80\nVendedores: 1,80",ink,size=5)
save(E,"impuesto-incidencia",p)
# Production: original total product points, marginal increments from differences.
L<-0:5; TP<-c(0,2000,3000,3500,3800,3900); MP<-diff(TP)
p1<-base(5.5,4300,"Trabajo","Producto total")+line(L,TP)+
 geom_point(data=data.frame(L,TP),aes(L,TP),color=blue,size=3)+labs(title="Producto total")
p2<-base(5.5,2200,"Trabajo","Producto marginal")+
 geom_col(data=data.frame(L=1:5,MP),aes(L,MP),fill=blue,width=.65)+labs(title="Producto marginal")
save("las-empresas","funcion-produccion",p1+p2,16,7)
# Cost examples preserve relationships; exact data absent from raster sources.
# Coherent illustrative cubic variable cost, not a claim of original observations.
AVC<-function(q)7.2-.6*q+.035*q^2
MC<-function(q)7.2-1.2*q+.105*q^2
AFC<-function(q)25/q
ATC<-function(q)AVC(q)+AFC(q)
q_avc<- .6/.07
q_atc<-uniroot(function(q)MC(q)-ATC(q),c(8,16))$root
cost<-base(20,17,"Producción (camisas por día)","Costo por camisa")+
 fun(MC,1.5,16,brown,"longdash")+fun(AVC,1,17,blue)+fun(ATC,2.3,17,ink)+fun(AFC,2,17,grey,"dotted")+
 point(q_avc,AVC(q_avc))+point(q_atc,ATC(q_atc))+
 lab(16,15,"CMg",brown)+lab(17.2,ATC(17),"CTM",ink)+
 lab(17.2,AVC(17),"CVM",blue)+lab(17.2,AFC(17),"CFM",grey)+
 lab(7,16,"CTM = CFM + CVM",ink,size=5)
save("las-empresas","costos-medios-marginal",cost)
# Total-cost example uses the visible source anchors (Q=13,CV=100,CF=25).
cv<-splinefun(c(0,3,7,10,13,15,16),c(0,25,50,75,100,130,145),method="natural")
total<-base(19,180,"Producción (camisas por día)","Costo total por día")+
 fun(function(q)25+0*q,0,16,grey,"dotted")+fun(cv,0,16,blue)+fun(function(q)25+cv(q),0,16,brown,"longdash")+
 guide(13,100)+point(13,25)+point(13,100)+point(13,125)+
 lab(16.3,25,"CFT",grey)+lab(16.3,145,"CVT",blue)+lab(16.3,170,"CT",brown)+
 lab(1,170,"CT = CFT + CVT",ink,size=5)
save("las-empresas","curvas-costo-total",total)
# Competitive profit maximization: original q*=9, marginal revenue=25.
cm<-function(q)14+(11/20.25)*(q-4.5)^2
q_comp<-9
p<-base(13,38,"Cantidad (camisas por día)","Ingreso y costo marginal")+
 fun(cm,0,10.5,brown,"longdash")+
 geom_hline(yintercept=25,color=blue,linewidth=1.1)+guide(q_comp,25)+point(q_comp,25)+
 lab(10.5,32,"CMg",brown)+lab(10.5,26,"IMg = P",blue)+
 arrow(3,21,3,25)+lab(.5,32,"IMg > CMg:\nconviene aumentar Q",ink,size=5)+
 lab(6,5,"Máximo beneficio: IMg = CMg",ink,size=5)
save("los-mercados","maximizacion-beneficio",p)
# Monopoly: exact original D=200-20Q, MR=200-40Q, Q*=4, P*=120.
# MC crosses MR at (4,40); AC(4)=60 gives profit 240.
MD<-function(q)200-20*q; MR<-function(q)200-40*q
MMC<-function(q)20+5*(q-2)^2
MVC<-function(q)40*q-10*q^2+(5/3)*q^3
MAC<-function(q)(MVC(q)+400/3)/q
p<-base(11,230,"Cantidad (Q)","Precio y costo por unidad",ymin=-60)+
 fun(MD,0,10,ink)+fun(MR,0,6.5,grey,"dotted")+fun(MMC,.2,8,brown,"longdash")+fun(MAC,.8,9,blue)+
 annotate("rect",xmin=0,xmax=4,ymin=60,ymax=120,fill=blue,alpha=.18)+
 guide(4,120)+point(4,120)+point(4,40)+point(4,60)+
 lab(8,200,"CMg",brown)+lab(8.5,MAC(8.5),"CTM",blue)+
 lab(9,30,"D",ink)+lab(5,-40,"IMg",grey)+lab(.3,95,"Beneficio",blue,size=5)
save("los-mercados-ii-monopolio","monopolio-beneficio",p)
# Aggregate expenditure components add horizontally at a fixed price level.
p<-base(5.5,3.7,"PIB real","Nivel de precios")
for(i in 1:4)p<-p+fun(function(q).2+(i+.8)/q,(i+.8)/3.5,5,if(i==4)blue else grey)
p<-p+geom_hline(yintercept=1.5,color=ink,linetype="dotted")+
 arrow(0,1.5,1.8/1.3,1.5)+arrow(1.8/1.3,1.5,2.8/1.3,1.5)+
 arrow(2.8/1.3,1.5,3.8/1.3,1.5)+arrow(3.8/1.3,1.5,4.8/1.3,1.5)+
 lab(.4,1.75,"C",size=5)+lab(1.65,1.75,"I",size=5)+lab(2.45,1.75,"G",size=5)+
 lab(3.2,1.75,"X netas",size=5)+lab(4.8,1.25,"DA",blue)+guide(4.8/1.3,1.5)
save("macroeconomia","componentes-demanda-agregada",p)
AD<-function(q)450000/q; AS<-function(q)75+75*exp((q-3000)/400)
move<-base(5500,300,"PIB real (miles de millones)","Nivel de precios")+
 fun(AD,1600,5500,blue)+guide(3000,150)+guide(2250,200)+point(3000,150)+point(2250,200)+
 arrow(2500,185,2800,163)+labs(title="Movimiento: cambia P")
shift<-base(5500,300,"PIB real (miles de millones)","Nivel de precios")+
 fun(AD,1600,5500,blue)+fun(function(q)600000/q,2100,5500,brown,"longdash")+
 arrow(3000,150,4000,150,brown)+labs(title="Desplazamiento: cambia DA")
save("macroeconomia","movimientos-demanda-agregada",move+shift,16,7)
p<-base(5500,300,"PIB real (miles de millones)","Nivel de precios")+
 fun(AD,1600,5500,blue)+fun(AS,0,3350,brown,"longdash")+
 guide(3000,150)+point(3000,150)+point(2250,200)+point(3000+400*log(125/75),200)+
 arrow(3000,200,3000,155)+
 lab(4400,AD(4400)+15,"DA",blue)+lab(3300,270,"OA",brown)+lab(3100,140,"E",ink)
save("macroeconomia","equilibrio-agregado",p)
# Positive DA shock increases output and price in the short run; potential stays fixed.
newAD<-function(q)600000/q
qnew<-uniroot(function(q)newAD(q)-AS(q),c(3000,3350))$root
p<-base(5500,300,"PIB real","Nivel de precios")+
 fun(AD,1600,5500,blue)+fun(newAD,2100,5500,blue,"dotdash")+
 fun(AS,0,3350,brown,"longdash")+
 geom_vline(xintercept=3300,color=grey,linetype="dotted")+
 guide(3000,150)+guide(qnew,newAD(qnew))+point(3000,150)+point(qnew,newAD(qnew))+
 lab(3400,285,"Producción\npotencial",grey,size=5)+lab(4700,100,"DA",blue)+lab(4500,155,"DA′",blue)+
 lab(3050,135,"E",ink)+lab(qnew+90,newAD(qnew)+10,"E′",ink)
save("macroeconomia","shock-demanda-agregada",p)
# Segmented labor markets: almost fixed supply/high wage vs elastic supply/low wage.
ql<-210/88
surgeon<-base(8,110,"Cantidad de trabajadores","Salario por hora")+
 fun(function(q)100-8*q,.5,7.5,blue)+fun(function(q)10+80*(q-1.5),1.5,2.7,brown,"longdash")+
 guide(ql,100-8*ql)+point(ql,100-8*ql)+labs(title="Cirujanos")
food<-base(8,110,"Cantidad de trabajadores","Salario por hora")+
 fun(function(q)70-10*q,0,7,blue)+fun(function(q)5+q,0,7.8,brown,"longdash")+
 guide(65/11,5+65/11)+point(65/11,5+65/11)+labs(title="Comida rápida")
save("mercado-de-trabajo","mercados-segmentados",surgeon+food,16,7)
# Semantic checks for original anchor points and internal economic consistency.
stopifnot(elisa(30)==1,nicolas(10)==1,market(40)==1,
 max_s(100)==15,mario_s(50)==15,market_s(150)==15,D(10)==15,S(10)==15,
 abs(MR(4)-MMC(4))<1e-9,MD(4)==120,abs(MAC(4)-60)<1e-9,
 abs(ATC(q_atc)-MC(q_atc))<1e-6,abs(AVC(q_avc)-MC(q_avc))<1e-6,
 abs(cv(13)-100)<1e-9,abs(Ds(80)-Ss(80)-2)<1e-9,Ds(100)==2,Ss(100)==2,
 qnew>3000,newAD(qnew)>150)
cat("Generated 21 curve diagrams; economic consistency checks passed.\n")
# Vector schematics use the same palette and typography as the curve charts.
canvas <- function() ggplot()+theme_void(base_family="sans")+
  coord_cartesian(xlim=c(0,1),ylim=c(0,1),clip="off")+
  theme(plot.margin=margin(20,20,20,20))
box <- function(x,y,w,h,text,color=blue,size=6) list(
 annotate("rect",xmin=x-w/2,xmax=x+w/2,ymin=y-h/2,ymax=y+h/2,
          fill=color,alpha=.12,color=color,linewidth=.8),
 lab(x,y,text,color,align=.5,size=size))
p<-canvas()+box(.12,.5,.22,.22,"Empresas")+box(.88,.5,.22,.22,"Hogares")+
 box(.5,.86,.30,.18,"Mercado de bienes\ny servicios")+
 box(.5,.14,.30,.18,"Mercado de factores\nde producción")+
 arrow(.20,.62,.35,.80,blue)+arrow(.65,.80,.80,.62,blue)+
 arrow(.80,.38,.65,.20,blue)+arrow(.35,.20,.20,.38,blue)+
 arrow(.80,.70,.65,.94,brown)+arrow(.35,.94,.20,.70,brown)+
 arrow(.20,.30,.35,.06,brown)+arrow(.65,.06,.80,.30,brown)+
 lab(.27,.62,"Bienes\nvendidos",blue,.5,5)+lab(.73,.62,"Bienes\ncomprados",blue,.5,5)+
 lab(.27,.40,"Factores\ndemandados",blue,.5,5)+lab(.73,.40,"Factores\nofrecidos",blue,.5,5)+
 lab(.20,.92,"Ingresos",brown,.5,5)+lab(.80,.92,"Gasto",brown,.5,5)+
 lab(.20,.07,"Pagos a factores",brown,.5,5)+lab(.80,.07,"Renta",brown,.5,5)
save("introduccion","flujo-circular",p,13,8)
p<-canvas()+box(.13,.76,.25,.30,"Política monetaria\nPolítica fiscal\nOtras fuerzas",grey,5.5)+
 box(.13,.25,.25,.32,"Precios y costos\nProducción potencial\nCapital, trabajo\ny tecnología",grey,5.5)+
 box(.40,.76,.20,.18,"Demanda\nagregada",blue)+box(.40,.25,.20,.18,"Oferta\nagregada",brown)+
 box(.65,.50,.20,.24,"Interacción\nde OA y DA",ink,5.5)+
 arrow(.26,.76,.29,.76,blue)+arrow(.26,.25,.29,.25,brown)+
 arrow(.50,.72,.55,.60,blue)+arrow(.50,.30,.55,.40,brown)
for(i in 1:4) {
 y<-c(.89,.63,.37,.11)[i]
 p<-p+box(.91,y,.17,.19,c("Producción\n(PIB real)","Empleo y\ndesempleo","Precios e\ninflación","Comercio\nexterior")[i],grey,5)+
 arrow(.75,.5,.81,y,ink)
}
save("macroeconomia","modelo-oferta-demanda",p,15,8)
cat("Generated two additional flow diagrams (23 diagrams total).\n")
