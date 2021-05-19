# NonlinearMethods
### CE #3 ChE-348 Prof. Lynd Sp21
#### Q1. randomSolve
##### (a) Write out the method's procedure in steps:
###### 1. Given some starting point x_0, draw a secant line with a random slope between -1000 and +1000. 
###### 2. Draw a line of this slope through the starting point. Find the x-value where this line crosses the x-axis.
###### 3. Save this x-value in a root placeholder variable and reiterate this random-slope loop.
###### 4. If a closer value is found during 1000 iterations, the placeholder's value is changed to that closer root.
##### (b) Here is the end result method:
```matlab
clear all
[x, ERR] = randomSolve(@(x)(-2+0.5*x+x.^2),0.01)
-2+.5*x+x.^2
function [root, err] = randomSolve(y, tol)
x0 = 0.; x1 = x0 + rand; err = 0.;
if abs(y(x0)) < abs(tol)
    root = x0; err = x0;
    return
elseif abs(y(x1)) < abs(tol)
    root = x1; err = x1;
    return
end
x2 = 0.; 
% Any line connecting from some central point should hit a root directly. 
% The probability of this happening keeping x0 constant is higher than if we pick random x0 each time.
iter = 1; root = x2; roots = transpose(ones(1,1000))*root; errs = transpose(ones(1,1000))*err;
while abs(y(x2)) > abs(tol)
    if iter > 1000
        err = abs(abs(y(root)) - abs(tol));
        break
    end
    x2 = y(x0)*(rand*2000-1000)+x0;
    if abs(y(x2)) < abs(y(root))
        root = x2;
        err = abs(y(root)) - abs(tol);
    end
    roots(iter) = root;
    errs(iter) = err;
    iter=iter+1;
end
clf
plot(transpose(linspace(1,1000,1000)),roots);
hold on
plot(transpose(linspace(1,1000,1000)),errs);
legend("root x-value","error value on y-axis");
end
```
##### (c) Find the root of f(x) = –2 + 0.5x + x2 on 0 < x < 2.
###### The root is approximately 1. This root finding function isn't that great.
##### (d) Reflect on what went wrong. Next steps?
###### The random slope calculation left out too many values of slope. 
###### Because there are infinite values of slope in any given interval of real numbers, the function here could improve by...
###### (i) while staying random, the function output would improve if random digits were both made integers and not reused.
###### (ii) while removing randomness, if the slope from the unchanging center point were instead incremented in a radial fashion, 
###### so as to rotate the line across a 180-degree interval, the function would return accurate output.
```
>> randomguessing

x =

    1.2562


ERR =

    0.1961


ans =

    0.2061
```


#### Q2. falsePosition
```matlab
clear all
[x, err] = falsePosition(@(x)(sin(x+0.4)),-0.5,2*pi(),1e-12);
function [root, err] = falsePosition(y,x0,x1,tol)
if abs(y(x0)) < abs(tol)
    root = x0; err = y(x0);
elseif abs(y(x1)) < abs(tol)
    root = x1; err = y(x1);
end
x2 = 0.; iter = 0; err = 0.;
while abs(y(x2)) > abs(tol)
    y(x2), x0, x1
    if iter > 15
        error("Too many iterations")
    end
    x2 = (x0-y(x0))*(x1-x0)/(y(x1)-y(x0));
    % x2 = y(0)*(x0-x1)/(y(x0)-y(x1));
    if y(x0) > 0
        if y(x2) < 0
            x1 = x2;
        else
            x0 = x2;
        end
    elseif y(x0) < 0
        if y(x2) > 0
            x1 = x2;
        else
            x0 = x2;
        end
    end
    iter=iter+1;
end
if abs(y(x2)) < abs(tol)
   root = x2; err = y(x2);
end

end
```
#### Q3. secantSolve
```matlab
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
 ```
 #### Q4. Now apply your Secant method root finder on the function: x^2*exp(x)-1 
 ##### How does your initial guess change the answer? Confirm that your answer is correct. This equation is somewhat pathological, why?
 ###### With an initial guess of 0.0, the method returns the root with value NaN. This means that the denominator was likely 0 at some point. 
 ###### However, if an initial guess greater than 0 is entered, such as 0.5, a numeric output is observed. With a threshold of .01 and a step size .00001, the output becomes:
 ```
 x^2*exp(x)-1 -->

x =

   3.6446e-04


err =

    0.0096
 ```
#### Q5. Consider the reactions
#### A + B --> V
#### A + 2B --> W
to be conducted in a continuous stirred tank reactor (CSTR). The reaction is to be conducted at 100 °C for which 
k1 = 1.0 (L/mol)1/2 h–1 and k2 = 0.25 L/(mol hr). You have been asked to prepare plots of the concentration of the four 
species as a function of residence time τ from 0–4 hours. 
Prepare a plot for inlet concentrations of CA0 = 1.0 mol/L and CB0 = 2.0 mol/L. Clearly label your plot.
##### This will be solved by successive substitution.
