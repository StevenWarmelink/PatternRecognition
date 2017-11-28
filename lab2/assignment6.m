%% Assignment 6
%posterior = (prior * likelihood) / evidence;
format long g;
% customers watches
% spam:
% 0.005     0.0003
% non-spam
% 0.0001    0.000004



p_spam = (0.005 * 0.0003 * 0.9) / ((0.005 * 0.0003 * 0.9) ... 
                          + (0.0001 * 0.000004 * 0.1))
p_nospam = (0.0001 * 0.000004 * 0.1) / ((0.005 * 0.0003 * 0.9) ... 
                          + (0.0001 * 0.000004 * 0.1))
                      
total = p_spam + p_nospam   

ratio = p_spam / p_nospam

%%
clear;
% fun       vacation
% spam:
% 0.00015   0.00025   
% non-spam:
% 0.0007    0.00014

p_spam = (0.00015 * 0.00025 * 0.9) / ((0.00015 * 0.00025 * 0.9) ... 
                          + (0.0007 * 0.00014 * 0.1))
p_nospam = (0.0007 * 0.00014 * 0.1) / ((0.00015 * 0.00025 * 0.9) ... 
                          + (0.0007 * 0.00014 * 0.1))
                      
total = p_spam + p_nospam   

ratio = p_spam / p_nospam