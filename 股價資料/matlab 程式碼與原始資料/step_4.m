% 將股價與報酬資料與看門狗資料合併

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 讀取資料
new_dog = cell2mat(readcell('new_dog.xlsx'));
stock_price = stock_price_sorted;
% stock_price = table2array(readtable('stock_price_step_2.xlsx','PreserveVariableNames', 1));

% 將股價資料合併到看門狗資料
[number_of_new_dog, number_of_column_2]= size(new_dog);
% new_dog_2 = [];
for i = 1: number_of_new_dog
    same_code = find(stock_price(:,1) == new_dog(i, 1));
    all_the_same_code = stock_price(same_code, :);
    same_date = find(all_the_same_code(:,2) == new_dog(i, 2));
    all_the_same_date = all_the_same_code(same_date, :);
    
    % 若新聞發生在假日，則放入放假前工作日的股價與報酬率資料
    date = new_dog(i, 2);
    if isempty(same_date) == 1
        for j = 1: 30
            date = date - 1;
            same_date = find(all_the_same_code(:,2) == date);
            all_the_same_date = all_the_same_code(same_date, :);
            if isempty(same_date) == 0
                break
            end
        end
    end
    % 若有股價資料，才新增資料
    if isempty(same_date) == 0
        new_dog(i, 3:9) = all_the_same_date(:,3:9);
    end
end

% 輸出結果
output_file_name = 'new_dog_step_4.xlsx';

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
writematrix(new_dog, output_file_name, 'sheet', '工作表1', 'range', 'A2');

