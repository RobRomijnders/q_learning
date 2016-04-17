clear all
close all
clc

iter = 100000;
ea_collect =zeros(4,iter);
for n = 1:4
    for k = 1:iter
        [e,a] = eak(k,n);
        ea_collect(n,k) = [e];
    end
end

hold on
plot(ea_collect(1,:))
plot(ea_collect(2,:))
plot(ea_collect(3,:))
plot(ea_collect(4,:))
legend('first','second','thrird','fourth')
xlabel('value of k')
ylabel('value of e_k and a_k')
hold off