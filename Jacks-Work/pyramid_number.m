function [ nth ] = pyramid_number( n )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
nth = 0;

if n >= 0 && (n/1)

    for k = 1 : n
        nth = nth + k.^2;
    end
    % nth = sum((1:n).^2)
else
    errordlg('Input must be a positive integer');
end

end

