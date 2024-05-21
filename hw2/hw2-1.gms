set P set of processes /p1, p2, p3/;
set R set of resources /r1, r2, f/;
set C set of chemicals /c1 ,c2/;

free Variable
    blend;
    
positive Variable
    num_proc(P) amount of process,
    num_chem(C) amount of chem;
    
Parameters
    res_proc(R,P) resources per process /r1.p1 9, r1.p2 6, r1.p3 4,
                                         r2.p1 5, r2.p2 8, r2.p3 11,
                                         f.p1 50, f.p2 75, f.p3 100/,
                                         
    constraint(R) /r1 200, r2 400, f 1850/,
    
    chemical(C ,P) /c1.p1 9, c2.p1 6,
                    c1.p2 7, c2.p2 10,
                    c1.p3 10, c2.p3 6/;                               
Equation
    obj1 objective,
    obj2 objective,
    resource_con(R) resource constraint,
    chem(C) number of chemicals;
    
obj1..
    5* blend =l= num_chem("c1");
obj2..
    2* blend =l= num_chem("c2");
                                         
resource_con(R)..
    sum(P, res_proc(R,P)*num_proc(P)) =l= constraint(R);
    
chem(C)..
    num_chem(C) =e= sum(P, chemical(C, P)* num_proc(P));
    
model chemmod /all/;
solve chemmod using lp maximize blend;
scalar mstat, sstat;
mstat = chemmod.modelstat;
sstat = chemmod.solvestat;
parameter proctime(P);
proctime(P) = num_proc.l(P);
display mstat, sstat, blend.l, proctime;
                                                