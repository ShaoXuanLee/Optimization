set trees pine.spruce.walnut.Hardwood /P, S, W, H/;
set site /1, 2, 3, 4/;

parameter
    Area(site, trees) area for each species /1.P 17, 1.S 14, 1.W 10, 1.H 9,
                                             2.P 15, 2.S 16, 2.W 12, 2.H 11,
                                             3.P 13, 3.S 12, 3.W 14, 3.H 8,
                                             4.P 10, 4.S 11, 4.W 8, 4.H 6/,
                                             
    req_tree(trees) required tree at each site /P 22500, S 9000, W 4800, H 3500/,
    
    net_profit(site,trees) profit at site 1 /1.P 16, 1.S 12, 1.W 20, 1.H 18,
     2.P 14, 2.S 13, 2.W 24, 2.H 20,
     3.P 17, 3.S 10, 3.W 28, 3.H 20,
     4.P 12, 4.S 11, 4.W 18, 4.H 17/,
    
    size(site) size of each site /1 1500, 2 1700, 3 900, 4 600/;
    
Variable
    pro1,
    pro2,
    pro3,
    pro4,
    profit;
    
positive variable
    grow(site, trees) "area planted of tree at site";
    
Equation
    obj,
    con_land(site) limitation on land,
    con_tree(trees) minimum of trees;
    

obj..
profit =e= sum((site,trees), grow(site, trees) * net_profit(site,trees));

con_land(site)..
    sum(trees, grow(site, trees)) =l= size(site);
    
con_tree(trees)..
    sum(site, Area(site,trees) * grow(site, trees)) =g= req_tree(trees);
    

    
model forest /all/;
solve forest using lp maximizing profit;
option limrow = 0, limcol = 0;
option solprint=off;
scalar mstat, sstat;
mstat = forest.modelstat;
sstat = forest.solvestat;
display mstat, sstat;
display profit.l, grow.l;