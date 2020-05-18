
% 整理2019年所有上市櫃公司的每日股價資料

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 輸出形式
% (1) 股票代號
% (2) 數字形式的日期
% (3) 年
% (4) 月
% (5) 日
% (6) 收盤價

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 合併股價資料檔案
stock = [ ];
% input_file_name = 'stock_Q1_2';
% table = table2array(readtable(strcat(input_file_name,'.xlsx')));
% stock(1,:) = table(3,:);

for i = 1:4
    for j = 0:2
        input_file_name = strcat('stock_Q', int2str(i), '_', int2str(j));
        stock_data      = table2array(readtable(strcat(input_file_name,'.xlsx')));
        stock_data(1:2,:) = [];
        stock = [stock; stock_data];
    end
end

% save results in an excel file
output_file_name = 'stock_price_all.xlsx';
writematrix(stock, output_file_name, 'sheet', '工作表1', 'range', 'A1');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 將日期切換為數字型態
date_code  = datestr(stock(:,2) ,26);   % 指定合約日期符合matlab的日期格式     %  26參數代表yyyy/mm/dd
date_num   = m2xdate(date_code);        % 將合約日期由matlab日期格式轉換為excel的日期格式 (數字)

output_file_name_1 = 'date_num.xlsx';
writematrix(date_num, output_file_name_1, 'sheet', '工作表1', 'range', 'A1');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 將股價資料與數字型態的日期合併
stock_1 = readtable('stock_price_all.xlsx', 'ReadVariableNames', 0);
date_num_1 = readtable('date_num.xlsx', 'ReadVariableNames', 0);

stock_1(:, 8) = date_num_1(:, 1);
stock_2 =  table2cell(stock_1);

% 切割股號
company = string(stock_2(:, 1));
company_split = regexp(company, ' ', 'split');

% 將公司代號讀出
company_code = [];
for i = 1: length(company_split)
    company_code(i, 1) = company_split{i, 1}(1);
end

% 將公司名稱讀出
for i = 1: length(company_split)
    company_name(i, 1) = company_split{i, 1}(2);
end

% 轉換數字日期的資料型態
date_num_2 = table2cell(date_num_1);
date_num_f = cell2mat(date_num_2(:,1));

% 切割日期
date = string(stock_2(:, 2));
date_split = regexp(date, '/', 'split');

% 年
year = [];
for i = 1: length(date_split)
    year(i, 1) = date_split{i, 1}(1);
end

% 月
month = [];
for i = 1: length(date_split)
    month(i, 1) = date_split{i, 1}(2);
end

% 日
day = [];
for i = 1: length(date_split)
    day(i, 1) = date_split{i, 1}(3);
end

% 收盤價
closing_price = cell2mat(stock_2(:,6));

% 合併整理好的資料
stock_final = [];
stock_final(:,1) = company_code;
stock_final(:,2) = date_num_f;
stock_final(:,3) = year;
stock_final(:,4) = month;
stock_final(:,5) = day;
stock_final(:,6) = closing_price;

% 去除股號為NaN的資料（原因：股號有英文字，但看門狗的資料沒有這類型股票，所以直接去除）
stock_nan = find(isnan(stock_final(:,1)));
stock_final(stock_nan, :) = [];

output_file_name = 'stock_price_step_1.xlsx';
writematrix(stock_final, output_file_name, 'sheet', '工作表1', 'range', 'A1');
