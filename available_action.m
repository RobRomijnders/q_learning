function [ a ] = available_action( s )
%Function takes a state and returns the available actions
[sx,sy] = ind2sub([10,10],s);
a = 1:4;
if sx == 1
    a(a == 1) = [];
elseif sx == 10
    a(a==3) = [];
end

if sy == 1
    a(a == 4) = [];
elseif sy == 10
    a(a==2) = [];
end 

end

