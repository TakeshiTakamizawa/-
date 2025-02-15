%% たわみ曲線 作成:たかみぃ, Mail:t.takeshi0624@outlook.com

clc         % コマンドウィンドウの初期化
clear       % ワークスペースの初期化
close all   % グラフを全部閉じる

E = 7845*10^6;
BL = 5840; % 全長
dL = 10; % 刻み幅
x1 = 20;
x2 = 20;
x3 = 1200;
x4 = 800;
x5 = 2570;
x6 = 3800-2570;
P1 = 0;
P2 = 0;
P3 = 0;
L = 873.620;
Lh = -27.880;
% G = 88*9.81;
G = 0;

d0 = 110; % 内径
Prepreg_thickness = 0.111;
lamination_distance = [0, 10, 140 , 135, 130, 120];
lamination_total = length(lamination_distance); % 積層数

Isump = Second_moment(d0, Prepreg_thickness, lamination_distance, lamination_total);

syms i_var; % 計算の変数
l = 0:dL:BL; % 計算回数に対する長さ

for i = 1:1:length(l)
    i_calc = l(1,i); % 計算時長さ
    if i_calc<= x1
        I1 = sum(Isump(1,1:lamination_total));
        f1 = @(i_var) -(-G*i_var)/(I1*E);
        deflection = Double_integral(f1, i_var, 0, i_calc); % 2回積分でたわみ
    elseif i_calc > x1 && i_calc <= x1 + x2
        I2 = sum(Isump(1,1:lamination_total));
        f2 = @(i_var) -(-G*i_var + L*(i_var - x1))/(I2*E);
        deflection = Double_integral(f2, i_var, 0, i_calc);
    elseif i_calc > x1 + x2 && i_calc <= x1 + x2 + x3
        I3 = sum(Isump(1,1:lamination_total-1));
        f3 = @(i_var) -(-G*i_var + L*(i_var - x1) - P1*(i_var - x1 - x2))/(I3*E);
        deflection = Double_integral(f3, i_var, 0, i_calc);
    elseif i_calc > x1 + x2 + x3 && i_calc <= x1 + x2 + x3 + x4
        I4 = sum(Isump(1,1:lamination_total-2));
        f4 = @(i_var) -(-G*i_var + L*(i_var - x1) ...
            - P1*(i_var - x1 - x2) - P2*(i_var - x1 - x2 - x3))/(I4*E);
        deflection = Double_integral(f4, i_var, 0, i_calc);
    elseif i_calc > x1 + x2 + x3 + x4 && i_calc <= x1 + x2 + x3 + x4 +x5
        I5 = sum(Isump(1,1:lamination_total-3));
        f5 = @(i_var) -(-G*i_var + L*(i_var - x1) - P1*(i_var - x1 - x2) ...
            - P2*(i_var - x1 - x2 - x3) - P3*(i_var - x1 - x2 - x3 -x4))/(I5*E);
        deflection = Double_integral(f5, i_var, 0, i_calc);
    elseif i_calc > x1 + x2 + x3 + x4 +x5 && i_calc <= x1 + x2 + x3 + x4 + x5 + x6
        I6 = sum(Isump(1,1:lamination_total-3));
        f6 = @(i_var) -(-G*i_var + L*(i_var - x1) - P1*(i_var - x1 - x2) ...
            - P2*(i_var - x1 - x2 - x3) - P3*(i_var - x1 - x2 - x3 -x4) ...
            - Lh*(i_var - x1 - x2 - x3 - x4 - x5))/(I6*E);
        deflection = Double_integral(f6, i_var, 0, i_calc);
    end
    deflection_angle_result(i) = deflection;
end

fprintf('積層数：%d',lamination_total)
plot(l,deflection_angle_result(1:length(i),:))