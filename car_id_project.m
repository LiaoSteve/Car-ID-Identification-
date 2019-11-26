%----------------¨®µP¿ëÃÑ-----------------------------------------------
clc,clear;
[file, path] = uigetfile( ...
       {'*.png;*.jpg', 'All MATLAB Files (*.png, *.jpg)'; ...
        '*.*', 'All Files (*.*)'},  'Pick a file'); 
selectedfile = fullfile(path,file);
original=imread(selectedfile);

original=License_positioning(original)
identify(original)



