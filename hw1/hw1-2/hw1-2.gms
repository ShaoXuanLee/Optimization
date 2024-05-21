set I /"Light Beer", "Dark Beer"/;
set R /Malt, Hops, Yeast/;

table a(R, I) "Per-Unit resource requirements"
            "Light Beer"   "Dark Beer"
Malt            2            3
Hops            3            1
Yeast           2          [5/3] ;

parameters
    c(I) /"Light Beer" 2, "Dark Beer" 1/
    b(R) /Malt 90, Hops 40, Yeast 80/ ;
    
free variable Profit;

positive variable quant(I) "number of each beer";

Equations
    profit_eq "profit equations",
    resource_con(R) "resource limit";
    
profit_eq..
    Profit =e= sum(I, c(I)*quant(I));
    
resource_con(R)..
    sum(I, a(R,I)*quant(I)) =l= b(R);
    
model softsuds /all/;
solve softsuds using lp maximizing Profit;
display Profit.l, quant.l;
    
    