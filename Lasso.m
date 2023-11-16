clc;
clear all;
%% Read dataset
data=csvread('data_for_LASSO1.csv',1,1);
x=data(:,2:end);
x=log10(x);
y=data(:,1);
ind = find(y==2 | y==0);
y1=y(ind);
x1=x(ind,:);

row = FSMarker(x1,y1);
data_lasso = data(:,row');
save index20.mat row data_lasso