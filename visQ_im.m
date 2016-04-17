function [ figure1 ] = visQ_im( rew_mat )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
figure1 = figure
im = ones(800,800);
imshow(im);

for x = 1:10
    for y = 1:10
        xmat = x;
        ymat = 10-y+1;
        
        hor = 0.03;
        ver = 0.03
        off = 0.005;
        
        xll = (x-1)*0.1+off;
        yll = (y-1)*0.1+off;
        
        str1 = num2str(rew_mat(ymat,xmat,1));
        str2 = num2str(rew_mat(ymat,xmat,2));
        str3 = num2str(rew_mat(ymat,xmat,3));
        str4 = num2str(rew_mat(ymat,xmat,4));
        annotation(figure1,'textbox',[xll+hor yll+2*ver 0.03 0.02],'String',str1,'FitBoxToText','off');
        annotation(figure1,'textbox',[xll+2*hor yll+ver 0.03 0.02],'String',str2,'FitBoxToText','off');
        annotation(figure1,'textbox',[xll+hor yll 0.03 0.02],'String',str3,'FitBoxToText','off');
        annotation(figure1,'textbox',[xll yll+ver 0.03 0.02],'String',str4,'FitBoxToText','off');
        
    end
end

end

