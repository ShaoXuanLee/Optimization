set I /p1, p2/;
set R /s1, s2, s3/;

table a(R, I) "Per-Unit resource requirements"
        p1      p2
s1      5       10  
s2      9       2
s3      7       5   ;

Parameters
    c(I) /p1 108, p2 84/
    b(R) /s1 40, s2 40, s3 40/
    hours(I) /p1 10, p2 8/;
    
free variable Profit;
positive variable make(I) "number of p1 and p2 made";

equations
    profit_eq,
    resource_con(R);
    
profit_eq..
    Profit =e= sum(I, (make(I) * (c(I) - 5 * hours(I))));
    
resource_con(R)..
    sum(I, a(R,I)*make(I)) =l= b(R);
    
model prodmix /all/;
solve prodmix using lp maximize Profit;
display Profit.l, make.l;