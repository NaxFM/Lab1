clear;
clc;
close all;

my_array = readmatrix("../C/cresult.txt");
my_thd = thd(my_array)
x = linspace(1,201,201);
plot(x,my_array,"b")
hold on;
