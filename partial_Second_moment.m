% 各積層における断面2次極モーメントの計算
clc         % コマンドウィンドウの初期化
clear       % ワークスペースの初期化
close all   % グラフを全部閉じる

d0 = 110; % 内径
Prepreg_thickness = 0.111;
lamination_distance = [0, 10, 140 , 135, 130, 120]; % 各積層の幅
lamination_total = length(lamination_distance); % 積層数

Solution = Second_moment(d0, Prepreg_thickness, lamination_distance, lamination_total);