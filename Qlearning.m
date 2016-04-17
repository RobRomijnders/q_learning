function [opt_pol,Q,reach_final,trial,runtime,final_count,reward_path,return_path] = Qlearning( reward,gamma,func,plt_toggle )
%Qlearning Function to execute one run of Q-learning. Takes in:
% - reward matrix, 100x4
% - discount value gamma
% - func, a categorical flag 1-4 to indicate which decay function to use
% - plt_toggle: a boolean flag to indicate if we want to see plots for this
% execution
% RL project


%Do tic-toc to measure the execution time
tic

% Initialize Q and N
Q = zeros(size(reward));
N = zeros(size(reward));

%---Initial settings---%
s_final = 100;      %Final state
max_trials = 3000;      %Maximum trials
Q_converged = false;
trial = 1;

if plt_toggle
    plt = 4;
    Q_collect = zeros(plt^2, max_trials);
    plt_ind = randperm(numel(Q),plt^2);
end

final_count = 0;

while ~Q_converged & trial < max_trials %This loops over many trials until Q converges
    %Initialize the state
    s = 1;
    k=1;
    
    %Initialize epsilon and alpha for the first time
    [e,a] = eak(k,func);
    
    Q_old = Q;      % Save the Q_old to asses convergence later on
    
    
    %--Start trial--%
    while (~isequal(s,s_final)) & a > 0.005
        [e,a] = eak(k,func);
        
        
        %--Select action--%
        % For both exploration and exploitation we end up with a vector
        %of indices to pick from
        %For exploration: we always have a vector of actions
        %For eploitation: we have a vector of actions when Q_max is achieved at
        %multiple actions
        
        %Therefore, we have an if-else system to construct these vector of
        %actions, being action_vec
        %Later on, we either sample randomly from this vector or if length
        %== 1, we push that action
        p = rand();
        av_actions = available_action(s);
        Q_max = max(Q(s,av_actions));       %The maximal Q value
        ind_Q_max = find(Q(s,av_actions) == Q_max);  %Indices of av_actions where Q_max is achieved
        ind_not_Q_max = find(Q(s,av_actions) ~= Q_max);  %Other indices
        if p < e
            % -- Exploration
            if isempty(ind_not_Q_max) %If Q_max is achieved at all available actions, 
                                       % then we pick from these indices
                action_vec = av_actions(ind_Q_max);
            else
                action_vec = av_actions(ind_not_Q_max);
            end
        else
            % -- Exploitation
            action_vec = av_actions(ind_Q_max);
        end
        
        %Either sample randomly from action_vec or if length ==1, just take
        %that action
        if length(action_vec)>1
            action = randsample(action_vec,1);
        else
            action = action_vec;
        end
        
        %Calculate nextstate and the available actions at nextstate
        next_s = nextstate(s,action);
        av_actions_next = available_action(next_s);
        
        
        %--Apply action, receive rewards, update Q--%
        Q(s,action) = Q(s,action) + a*(reward(s,action)+gamma*max(Q(next_s,av_actions_next)) -Q(s,action) );
        
        %Update N
        N(s,action) = N(s,action)+1;
        
        s = next_s;
        if isequal(s,s_final)
            final_count = final_count+1;
        end
        
        k=k+1;
    end
    
    
    
    %--Convergence criterion of Q--%
    %Calculate the sum of squared differences
    Q_diff = (Q_old-Q).^2;
    Q_diff = mean(Q_diff(:));
    
    %Initialize running mean
    if trial == 1
        Q_diff_running = Q_diff;
    end
    %Update running mean
    Q_diff_running = 0.95*Q_diff_running+0.05*Q_diff;
    
    
    if Q_diff_running<0.01
        Q_converged = true;
    end
    
    trial = trial+1;
    
    if plt_toggle
        %Save some Q-values
        Q_collect(:,trial) = Q(plt_ind);
        %Save running mean to visualize later
        Q_collect(plt^2,trial) = Q_diff_running;
    end
    
end

if plt_toggle
    %Plot the evolution of random Q entries
    figure
    for p = 1:plt^2
        subplot(plt,plt,p)
        plot(Q_collect(p,1:trial-1))
        ylabel('Q value')
        xlabel('Trial')
        if p == plt^2
            ylabel('Running measure of convergence')
        end
    end
end

%--Optimal policy--%
%Calculate the optimal policy
[~,opt_pol] = max(Q,[],2);
[reach_final,reward_path,return_path] = plot_pol(opt_pol,reward,gamma);

runtime = toc;
end

