set items Bed. Desk. Chair. bedFrame.CoFfeetable /B, D, C, F, CF/;
set r resources. Hours.Metal.Wood /H, M, W/;

Parameter
    net_p(items) profit of each item /B 19, D 13, C 12, F 17, CF 14/,
    constrain(r) constrain on each resources /H 225, M 117, W 420/,
    build(r, items) resource require to build an item /H.B 3, H.D 2, H.C 1, H.F 2, H.CF 3,
                                                       M.B 1, M.D 1, M.C 1, M.F 1, M.CF 1,
                                                       W.B 4, W.D 3, W.C 3, W.F 4, W.CF 2/;
free Variable
    profit;
    
positive Variable
    produce(items);
    
equations
    profit_eq,
    resource_con(r);
    
profit_eq..
    profit =e= sum(items, net_p(items) * produce(items));
    
resource_con(r)..
    sum(items, build(r,items)*produce(items) ) =l= constrain(r);
    
model books /all/;
produce.up("CF") = 0;
solve books using lp maximizing profit;
parameter resprof(*);
resprof('2.1') = profit.l;

net_p("D") = 15;
solve books using lp maximizing profit;
resprof('2.2.1') = profit.l;

constrain("M") = 125;
solve books using lp maximizing profit;
resprof('2.2.2') = profit.l;

produce.up("CF") = +INF;
solve books using lp maximizing profit;
resprof('2.2.3') = profit.l;
display resprof, produce.l;