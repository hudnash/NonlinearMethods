disp("sin(x^2-2*x+5)^4 -->")
[x, err] = secantSolve(@(x)(sin(x^2-2*x+5)^4),-5.,.00001,.01)
disp("x^2*exp(x)-1 -->")
[x, err] = secantSolve(@(x)(x^2*exp(x)-1),.5,.0001,.01)
 function [root, err] = secantSolve(y,x0,step,tol)
 if abs(y(x0)) < abs(tol)
     root = x0; err = x0;
 end
 iter = 0; x1 = x0;
 while abs(y(x1)) > abs(tol)
     x0 = x1;
     if iter > 15
         error("Iterations exceed 15")
     end
     x1 = x0 - y(x0)*step/(y(x0)-y(x0-step));
     iter=iter+1;
 end
 root = y(x1); err = abs(abs(y(x1))-abs(tol));
 end