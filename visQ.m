function [ vis,rew_mat ] = visQ( matrix, plot_toggle )
%Visualize the matrix of any Q or N matrix
% Made by Rob Romijnders on 8 april 2016

% Function takes in
% - A matrix to be visualized. Either 100x4 or 10x10x4
% - plot_toggle: a boolean value deciding if you want a plot or not
s = size(matrix);
if length(s) == 3
    rew_mat = matrix;
elseif length(s) == 2
    disp('Make Tensor from rewards')
    rew_mat = zeros(10,10,4);
    for i = 1:100
        [x,y] = ind2sub([10 10],i);
        rew_mat(x,y,:) = matrix(i,:);  
    end
end


vis = zeros(40,40);
for i=1:100
    [x,y] = ind2sub([10 10],i);
    x_cent = (y-1)*4+2;
    y_cent = (x-1)*4+2;
    
    vis(y_cent-1,x_cent) = rew_mat(x,y,1);
    vis(y_cent,x_cent+1) = rew_mat(x,y,2);
    vis(y_cent+1,x_cent) = rew_mat(x,y,3);
    vis(y_cent,x_cent-1) = rew_mat(x,y,4);
    for n = 1:10
        vis((n-1)*4+4,:) = NaN;
        vis(:,(n-1)*4+4) = NaN;
    end
end

if plot_toggle
    disp('Visualize Tensor')
    figure
    uitable('data',vis,'Position',[10 10 2000 800],'ColumnWidth',{40});
end
end

