
% ��z2019�~�Ҧ��W���d���q���C��ѻ����

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ��X�Φ�
% (1) �Ѳ��N��
% (2) �Ʀr�Φ������
% (3) �~
% (4) ��
% (5) ��
% (6) ���L��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% �X�֪ѻ�����ɮ�
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
writematrix(stock, output_file_name, 'sheet', '�u�@��1', 'range', 'A1');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% �N����������Ʀr���A
date_code  = datestr(stock(:,2) ,26);   % ���w�X������ŦXmatlab������榡     %  26�ѼƥN��yyyy/mm/dd
date_num   = m2xdate(date_code);        % �N�X�������matlab����榡�ഫ��excel������榡 (�Ʀr)

output_file_name_1 = 'date_num.xlsx';
writematrix(date_num, output_file_name_1, 'sheet', '�u�@��1', 'range', 'A1');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% �N�ѻ���ƻP�Ʀr���A������X��
stock_1 = readtable('stock_price_all.xlsx', 'ReadVariableNames', 0);
date_num_1 = readtable('date_num.xlsx', 'ReadVariableNames', 0);

stock_1(:, 8) = date_num_1(:, 1);
stock_2 =  table2cell(stock_1);

% ���ΪѸ�
company = string(stock_2(:, 1));
company_split = regexp(company, ' ', 'split');

% �N���q�N��Ū�X
company_code = [];
for i = 1: length(company_split)
    company_code(i, 1) = company_split{i, 1}(1);
end

% �N���q�W��Ū�X
for i = 1: length(company_split)
    company_name(i, 1) = company_split{i, 1}(2);
end

% �ഫ�Ʀr�������ƫ��A
date_num_2 = table2cell(date_num_1);
date_num_f = cell2mat(date_num_2(:,1));

% ���Τ��
date = string(stock_2(:, 2));
date_split = regexp(date, '/', 'split');

% �~
year = [];
for i = 1: length(date_split)
    year(i, 1) = date_split{i, 1}(1);
end

% ��
month = [];
for i = 1: length(date_split)
    month(i, 1) = date_split{i, 1}(2);
end

% ��
day = [];
for i = 1: length(date_split)
    day(i, 1) = date_split{i, 1}(3);
end

% ���L��
closing_price = cell2mat(stock_2(:,6));

% �X�־�z�n�����
stock_final = [];
stock_final(:,1) = company_code;
stock_final(:,2) = date_num_f;
stock_final(:,3) = year;
stock_final(:,4) = month;
stock_final(:,5) = day;
stock_final(:,6) = closing_price;

% �h���Ѹ���NaN����ơ]��]�G�Ѹ����^��r�A���ݪ�������ƨS���o�����Ѳ��A�ҥH�����h���^
stock_nan = find(isnan(stock_final(:,1)));
stock_final(stock_nan, :) = [];

output_file_name = 'stock_price_step_1.xlsx';
writematrix(stock_final, output_file_name, 'sheet', '�u�@��1', 'range', 'A1');
