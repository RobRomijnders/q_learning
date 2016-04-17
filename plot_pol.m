function [reach_final,reward_path,return_path] = plot_pol( opt_pol,reward , gamma)
%Plot_pol visualizes the optimal policy given an optimal_policy vector
% Input: 100x1 vector of optimal actions per state
% Output: plot of the policy
% The three output arguments relate to:
% - reach_final: a boolean flag if the path reaches the final state
% - reward_path: the reward associated with the path
% - return_path: the return associated with the path

figure
grid on
axis([0 10 0 10])

s = 1;
s_hist = [];
loop = false;

final = false;

k = 0; %The counter for the discount factor, gamma
reward_path = 0;
return_path = 0;
while (~loop) && (~final)
    [sx,sy] = ind2sub([10,10],s);
    sx = 10-sx;
    action = opt_pol(s);
    switch action
        case 1
            text(sy - 0.5, sx + 0.5, '^')
        case 2
            text(sy - 0.5, sx + 0.5, '>')
        case 3
            text(sy - 0.5, sx + 0.5, 'v')
        case 4
            text(sy - 0.5, sx + 0.5, '<')
        otherwise
            disp('Invalid action')
    end
    
    %Calculate the reward and return
    reward_path = reward_path + reward(s,action);
    return_path = return_path + gamma^k*reward(s,action);
    k = k+1;
    
    
    s = nextstate(s,action);
    if s == 100
        final = true;
    end
    
    %The following if-statement checks if some state has already been taken
    % If so, we terminate the process for the following reason: By the
    % principle of optimality, pi will follow argmax(). This argmax will
    % return the same action every time the path encounters this state.
    % Therefore, when one state is visited twice, it will be visited
    % infinitely often.
    if any(s == s_hist)
        loop = true;
    end
    
    %Append the state
    s_hist = [s_hist s];
    
    
end

reach_final = final;

end

