function velasco_117CurveFitting()
%%
%Cmsc 117 LE2 PAPER
%%
%CURVE FITTING / LEAST SQUARES FITTING%
%Linear Curve Fit
%Quadratic Curve Fit
%Exponential Curve Fitting
%%
%%%%%%%%%%%%
%2012-58922
%VELASCO, Gimel David F.
%May 23, 2016
%Cmsc 117
%%%%%%%%%%%%
%%
%This matlab code for finding the Least Square Fit is based on how the
%Curve Fit is explained in Numerical Methods Using MatLab 3rd Ed. and Least
%Squares Fitting in Wolfram MathWorld
%The experiment is based on the article "A 142 Million Philippine Population
%by 2045?" by LISA GRACE S. BERSALES, Ph. D. found in
%https://psa.gov.ph/content/142-million-philippine-population-2045
%%
%%%%%%%%%%%%%%Initialize dataset here%%%%%%%%%%%%
Data = [0 93135100;%2010
        1 94823800;%2011
        2 96510900;%2012
        3 98196500;%2013
        4 99880300;%2014
        5 101562300;%2015
        6 103242900;%2016
        7 104921400;%2017
        8 106598600;%2018
        9 108274300;%2019
        10 109947900];%2020
%%
%%%%%%%%%%%%%%%%%%%%%Linear Curve Fit%%%%%%%%%%%%%%%%%%%%%%
%Step 1: Computing the coefficients a and b
L = length(Data);
Ex0 = length(Data);
Ex1 = 0;
for i=1:1:L
    Ex1 = Ex1 + Data(i,1);
end
Ex2 = 0;
for i=1:1:L
    Ex2 = Ex2 + Data(i,1)^2;
end
Ey1 = 0;
Ex1y1 = 0;
for i=1:1:L
    Ey1 = Ey1 + Data(i,2);
end
for i=1:1:L
    Ex1y1 = Ex1y1 + Data(i,1)*Data(i,2);
end
%%
%Step 2: Substitute the values to the matrix form Ax=B
A = [Ex0 Ex1;
     Ex1 Ex2];
B = [Ey1;
     Ex1y1];
X = A\B;
%%
%Step 3: Plug the values of a and b to the function f = ax + b
b = X(1);
a = X(2);
fprintf('\nThe Linear Curve Function therefore is:\nf = ax + b\nf(x) = %fx + %f\n',a,b);
%Step 4: Compute for the Error err
err = 0;
for i=1:1:L
    err = err + ((a*Data(i,1)+b) - Data(i,2))^2;
end
fprintf('With Error of err = %f\n\n',err);
%%%%%%%%%%%%%%%%%%%%end of linear curve fitting%%%%%%%%%%%%%%%%%%%%%


%%
%%%%%%%%%%%%%%%%%%%%%%Quadratic Curve Fitting%%%%%%%%%%%%%%%%%%%
%Step 1: Computing the coefficients a and b
Ex3 = 0;
for i=1:1:L
    Ex3 = Ex3 + Data(i,1)^3;
end
Ex4 = 0;
for i=1:1:L
    Ex4 = Ex4 + Data(i,1)^4;
end
Ex2y1 = 0;
for i=1:1:L
    Ex2y1 = Ex2y1 + (Data(i,1)^2)*Data(i,2);
end
%%
%Step 2: Substitute the values to the matrix form Ax=B
A = [Ex0 Ex1 Ex2;
     Ex1 Ex2 Ex3;
     Ex2 Ex3 Ex4];
B = [Ey1;
     Ex1y1;
     Ex2y1];
X = A\B;
%%
%Step 3: Plug the values of a and b to the function f = a2x^2 + a1x + a0
a0 = X(1);
a1 = X(2);
a2 = X(3);
fprintf('\nThe Quadratic Curve Function therefore is:\nf = a2x^2 + a1x + a0\nf(x) = %fx^2 + %fx + %f\n',a2,a1,a0);
%Step 4: Compute for the Error err
err = 0;
for i=1:1:L
    err = err + ((a2*Data(i,1)^2 + a1*Data(i,1) + a0) - Data(i,2))^2;
end
fprintf('With Error of err = %f\n\n',err);
%%%%%%%%%%%%%%%%%end of Quadratic curve fitting%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%Exponential Curve Fitting%%%%%%%%%%%%%%%%%
%Step 1: Computing the coefficients a and b
Eylny = 0;
Exylny = 0;
for i=1:1:L
    Eylny = Eylny + Data(i,2)*log(Data(i,2));
end
for i=1:1:L
    Exylny = Exylny + Data(i,1)*Data(i,2)*log(Data(i,2));
end
%Step 2: Substitute the values to the matrix form Ax=B
A = [Ey1 Ex1y1;
     Ex1y1 Ex2y1];
B = [Eylny;
     Exylny];
X = A\B;
%Step 3: Plug the values of a and b to the function f = A*exp(B*x)
ae = X(1);
be = X(2);
B = be;
A = exp(ae);
fprintf('\nThe Exponential Curve Function therefore is:\nf = Aexp(Bx)\nf(x) = %fexp(%fx)\n',A,B);
%Step 4: Compute for the Error err
err = 0;
for i=1:1:L
    err = err + ((A*exp(B*Data(i,1))) - Data(i,2))^2;
end
fprintf('With Error of err = %f\n\n',err);
%%%%%%%%%%%%%%%%%%end of Exponential Curve Fit%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%Predicting Population in 2045%%%%%%%%%%%
x = 35;
linear_cf2045 = a*x + b;
quadratic_cf2045 = a2*x^2 + a1*x + a0;
exponential_cf2045 = A*exp(B*x);
%%
%%%%%%%%%%%%Comparing Results from PSA Prediction of Population by 2045%%%%
err_lin = abs(linear_cf2045 - 142095100)/142095100;
err_quad = abs(quadratic_cf2045 - 142095100)/142095100;
err_exp = abs(exponential_cf2045 - 142095100)/142095100;
%%
%%%%%%%%Display Results

fprintf('The Predicted Population by 2045 is the ff:\n');
fprintf('Using Linear Curve Fit: %f\nwith error = %f\n\n',linear_cf2045,err_lin);
fprintf('Using Quadratic Curve Fit: %f\nwith error = %f\n\n',quadratic_cf2045,err_quad);
fprintf('Using Exponential Curve Fit: %f\nwith error = %f\n\n',exponential_cf2045,err_exp);
end%main