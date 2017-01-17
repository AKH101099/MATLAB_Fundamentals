function [P,N] = Pyramid(V,varargin)

N = nargin
varargin

if isa(V,'integer')
    warning('entered an integer, should be okay though')
end

if (V < 0)
    error('no negativity allowed');
end

if V ~= round(V)
    warning('rounding to whole number');
    V = round(V);
end

P = sum((1:V).^2);