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