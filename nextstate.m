function [ next_s ] = nextstate( s,action )
%Function that updates the state, given an action. 

next_s = s;
switch action
    case 1
        next_s = s-1;
    case 2
         next_s = s+10;
    case 3
         next_s = s+1;
    case 4
         next_s = s-10;
    otherwise
        disp('Invalid action')
end

end

