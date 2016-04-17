function [ e,a ] = eak( k, func )
%EAK This function calculates the epsilon-greedy threshold probability and 
% the learning rate, alpha. For this implementation, epsilon and alpha are 
% equal. The second argument, "func", is a flag that signals which function
% to use. This directs the switch-statements.
switch func
    case 1
        a = 1/k;
        e = a;
    case 2
        e = 100./(100+k);
        a = e;
    case 3
        a = (1+log(k))/k;
        e=a;
    case 4
        a = (1+5*log(k))/k;
        e = a;
    otherwise
        disp('You are calling an unknown function for the a_k and e_k')
end
    e = min(e,1);
    a = min(a,1);
end

