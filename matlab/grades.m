function [x i] = grades(y, phi, s, tol, niters, weight)
if (nargin < 6)
    weight = 1 + 1/3;
end;
if (nargin < 5)
    niters = 3e3;
end;
if (nargin < 4)
    tol = 1e-10;
end;
if (nargin < 3) 
    disp('Error:  too few arguments');
    return;
end;

y2 = sum(y.*y);
r = y; 
r2 = y2;
r_last = r2 + 1;
n = size(phi, 2);
x = zeros(n, 1);
i = 0;
while ((r2 / y2 > tol) && (i < niters) && (r2 / y2 < 1e5) && (r2 < r_last * (1+0.1)))
    x = x + phi' * r / weight;
    [xsorted inds] = sort(abs(x), 'descend');
    x(inds(s+1:n)) = 0;
    r = y - phi * x;
    r_last = r2;
    r2 = sum(r.*r);
    i = i+1;
end;
end