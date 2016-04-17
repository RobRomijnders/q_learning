% Implementation of Q-learning by Rob Romijnders
% 18 april 2016
% 
% For references, see robromijnders.github.io 


clear all
close all
clc

%One example of a reward function
%Reward function is 100x4. Every row corresponds to an index in the 10x10
%maze. Every column corresponds to an action, oriented as
%UP-RIGHT-DOWN-LEFT
load reward_normal.mat

%% This block loops over multiple values for gamma and decay-functions
% The next block allows for one particular setting
gammas = [0.5,0.9];
l_gammas = length(gammas);

funcs = [1,2,3,4];
l_funcs = length(funcs);

tries = 10;


plt_toggle = false;

result = zeros(l_funcs,4*l_gammas);
for g = 1:l_gammas
    gamma = gammas(g);
    for f = 1:l_funcs
        func = funcs(f);
        reaches = zeros(tries,1);
        runtimes = zeros(tries,1);
        numtrials = zeros(tries,1);
        final_counts = zeros(tries,1);
        parfor i = 1:tries
            [opt_pol,Q,reach_final,numtrial,runtime,final_count,~,~] = Qlearning( reward,gamma,func,plt_toggle);
            reaches(i) = reach_final;
            runtimes(i) = runtime;
            numtrials(i) = numtrial
            final_counts(i) = final_count;
        end
        
        reach_sum = sum(reaches);
        av_runtime = mean(runtimes);
        med_numtrials = median(numtrials);
        med_final_count = median(final_counts);
        
        
        result(f,g) = reach_sum;
        result(f,g+l_gammas) = av_runtime;
        result(f,g+2*l_gammas) = med_final_count;
        result(f,g+3*l_gammas) = med_numtrials;
        disp(sprintf('Gamma %.2f - Func %2d - Reach_final %d  - trial_final %.0f out %.0f - Runtime %.3f',gamma,func,reach_sum,med_final_count,med_numtrials,av_runtime))
    end
end

result = [repmat(gammas,1,4);result];

cnames = {};
rnames = {};
rnames{1} = 'gamma';
for i = 1:l_funcs
    rnames{i+1} = strcat('func',num2str(funcs(i)));
end

%Every set of two column names correspong to gamma=0.5 and 0.9
%If you choose to take more gammas, also increase the repetition in here
cnames{1} = 'goal-reached runs';
cnames{2} = cnames{1};
cnames{3} = 'Execution time';
cnames{4} = cnames{3};
cnames{5} = 'goal-reached trials';
cnames{6} = cnames{5};
cnames{7} = 'num trials';
cnames{8} = cnames{7};

figure
uitable('Data', result, 'Position', [10 400 1200 300],'ColumnName',cnames,...
    'RowName',rnames);





%% This block allows for one particular setting.
%Make sure the "reward" matrix is in workspace

[opt_pol,Q,reach_final,numtrial,runtime,final_count,reward_path,return_path] = Qlearning( reward,0.5,2,true);
