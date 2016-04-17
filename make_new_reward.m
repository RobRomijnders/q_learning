clear all
close all
clc

load task1.mat
reward_old = reward;

incr = 1.3;
x = 0:0.1:14;
y = (1-incr)/7*x+incr;
figure,plot(x,y)

for i = 1:100
    [ix,iy] = ind2sub([10,10],i);
    dist = sqrt(ix^2+iy^2);
    
    change = (1-incr)/7*dist+incr;
    for a = 1:4
        if reward(i,a) ~= -1
            reward(i,a) = round(reward(i,a)*change*1.18);
        end
    end
    
end

visQ(reward,true)
visQ(reward_old,true)