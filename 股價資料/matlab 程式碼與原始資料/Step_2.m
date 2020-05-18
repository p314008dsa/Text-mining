% 將股價資料整理成依公司股號排列、再依時間排列的形式
% 計算事件發生日前後兩天收盤價的報酬（兩日報酬率）

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 輸出形式
% (1) 股票代號
% (2) 數字形式的日期
% (3) 年
% (4) 月
% (5) 日
% (6) 收盤價
% (7) 明日收盤價 / 昨日收盤價
% (8) 明日收盤價 / 昨日收盤價 - 1
% (9) 兩日報酬率(%)
% 1260 3062
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 讀取股價資料
stock_price = table2array(readtable('stock_price_step_1.xlsx','PreserveVariableNames', 1));
stock_price(:, 7) = 0;

% 找出相同股號的股價資料
same_stock = unique(stock_price(:,1)); 
[number_of_same_stock, number_of_column]= size(same_stock);

stock_price_sorted = [];
for i = 1: number_of_same_stock
    same_stock_data = find(stock_price(:,1) == same_stock(i));
    all_the_same_stock_unsort = stock_price(same_stock_data,:);
    all_the_same_stock = sortrows(all_the_same_stock_unsort, 2);
    [number_of_all_the_same_stock, number_of_column]= size(all_the_same_stock);
    
    % 部分股票同時出現在上市、上櫃、興櫃的資料中，因此需要篩掉重複加入的股價資料
    if all_the_same_stock(1,5) == all_the_same_stock(2,5)
        for k = number_of_all_the_same_stock: -2: 2
            all_the_same_stock(k, :) = [];
        end
    end
    
    [number_of_all_the_same_stock, number_of_column]= size(all_the_same_stock);
    
    for j = 2: number_of_all_the_same_stock - 1
        all_the_same_stock(j, 7) = all_the_same_stock(j+1, 6) / all_the_same_stock(j-1, 6);
    end
   
    stock_price_sorted = [stock_price_sorted; all_the_same_stock];
end

% (8) 明日收盤價 / 昨日收盤價 - 1
% (9) 兩日報酬率(%)
stock_price_sorted(:, 8) = (stock_price_sorted(:, 7) - 1);
stock_price_sorted(:, 9) = stock_price_sorted(:, 8) * 100;


% 輸出結果
output_file_name = 'stock_price_step_2.xlsx';

% 附上欄位標題
writematrix('股票代號', output_file_name, 'sheet', '工作表1', 'range', 'A1');
writematrix('數字形式的日期', output_file_name, 'sheet', '工作表1', 'range', 'B1');
writematrix('年', output_file_name, 'sheet', '工作表1', 'range', 'C1');
writematrix('月', output_file_name, 'sheet', '工作表1', 'range', 'D1');
writematrix('日', output_file_name, 'sheet', '工作表1', 'range', 'E1');
writematrix('收盤價', output_file_name, 'sheet', '工作表1', 'range', 'F1');
writematrix('明日收盤價 / 昨日收盤價', output_file_name, 'sheet', '工作表1', 'range', 'G1');
writematrix('明日收盤價 / 昨日收盤價 - 1', output_file_name, 'sheet', '工作表1', 'range', 'H1');
writematrix('兩日報酬率(%)', output_file_name, 'sheet', '工作表1', 'range', 'I1');

% 輸出資料
writematrix(stock_price_sorted, output_file_name, 'sheet', '工作表1', 'range', 'A2');
