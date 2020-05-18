% 整理看門狗資料的日期形式
% 未來在再用這份資料做機器學習

% 讀取資料
dog = readcell("dog.xlsx");
dog(1,:) = [];  % 去掉欄位標題


% 整理日期 20190101 > 2019/01/01
date_str = string(dog(:,2));
new_date_str = insertBefore(date_str, 5, "/");
new_date_str = insertBefore(new_date_str, 8, "/");

% 將日期切換為數字型態 2019/01/01 > 43466
date_code  = datestr(new_date_str, 26);   % 指定合約日期符合matlab的日期格式     %  26參數代表yyyy/mm/dd
date_num   = m2xdate(date_code);        % 將合約日期由matlab日期格式轉換為excel的日期格式 (數字)

% 更新看門狗資料
new_dog = [];
new_dog(:,1) = cell2mat(dog(:,1));
new_dog(:,2) = date_num;

% 輸出日期更新好的看門狗資料
output_file_name = 'new_dog.xlsx';
writematrix(new_dog, output_file_name, 'sheet', '工作表1', 'range', 'A1');


