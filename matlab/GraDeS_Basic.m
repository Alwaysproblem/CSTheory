function [ x ] = GraDeS_Basic( y,Phi,s,gama,epsilon,loopmax )
    %GraDeS_Basic Summary of this function goes here
    %Version: 1.0 written by jbb0523 @2016-07-28
    %Reference:Garg R, Khandekar R. Gradient descent with sparsification: an iterative 
    %algorithm for sparse recovery with restricted isometry property[C]//Proceedings of 
    %the 26th Annual International Conference on Machine Learning. ACM, 2009: 337-344
    %Available at:http://people.cse.iitd.ernet.in/~rohitk/research/sparse.pdf
    %   Detailed explanation goes here
        if nargin < 6
            loopmax = 3000;
        end
        if nargin < 5  
            epsilon = 1e-3;  
        end 
        if nargin < 4  
            gama = 1+1/3;  
        end 
        [y_rows,y_columns] = size(y);  
        if y_rows<y_columns  
            y = y';%y should be a column vector  
        end
        n = size(Phi,2);
        x = zeros(n,1);%Initialize x=0
        loop = 0;
        while(norm(y-Phi*x)>epsilon && loop < loopmax)
            x = x + Phi'*(y-Phi*x)/gama;%update x
            %the following two lines of code realize functionality of Hs(.)
            %1st: permute absolute value of x in descending order
            [xsorted inds] = sort(abs(x), 'descend');
            %2nd: set all but s largest coordinates to zeros
            x(inds(s+1:n)) = 0;
            loop = loop + 1;
        end
    end
    