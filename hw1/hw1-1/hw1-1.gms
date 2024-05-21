parameter x1val, x2val, x3val, objval;
*option limrow=0, limcol=0;
positive variables
x1, x2, x3;

free variable obj "min of x1, x2, x3"

equations
eq1 "equation1",
eq2 "equation2",
eq3 "equation3",
objeq "min of x1 x2 x3";

eq1..
    x1 - 4*x2 + 2*x3 =l= 10;
    
eq2..
    3*x1 + 6*x3 =e= 12;
    
eq3..
    9*x2 =g= 3 + 5*x1;
    
objeq..
    obj =e= 3*x1 + 4*x2 - 20*x3;
    
model question1 /all/;
solve question1 using lp minimizing obj;
objval = obj.l ; x1val = x1.l ; x2val = x2.l ; x3val = x3.l ;
display objval, x1val, x2val, x3val ;