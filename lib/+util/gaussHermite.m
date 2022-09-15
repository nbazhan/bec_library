function [xs, ws] = gaussHermite(n)
    % range enough for 400 Hermite polynomials
    x = linspace(-30, 30, 5000);
    h = util.hermite(x, n);
    xs = nonzeros(0.5*(x(2:end) + x(1:end-1)).*(h(2:end).*h(1:end-1) <= 0))';
    if size(xs, 2) < n
        xs(end + 1) = 0;
        xs = sort(xs);
    end
    ws = 2^(n-1)*factorial(n)*sqrt(pi)./(n^2.*util.hermite(xs, n-1).^2);
end