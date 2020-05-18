% �N�ѻ���ƾ�z���̤��q�Ѹ��ƦC�B�A�̮ɶ��ƦC���Φ�
% �p��ƥ�o�ͤ�e���Ѧ��L�������S�]�����S�v�^

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ��X�Φ�
% (1) �Ѳ��N��
% (2) �Ʀr�Φ������
% (3) �~
% (4) ��
% (5) ��
% (6) ���L��
% (7) ���馬�L�� / �Q�馬�L��
% (8) ���馬�L�� / �Q�馬�L�� - 1
% (9) �����S�v(%)
% 1260 3062
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ū���ѻ����
stock_price = table2array(readtable('stock_price_step_1.xlsx','PreserveVariableNames', 1));
stock_price(:, 7) = 0;

% ��X�ۦP�Ѹ����ѻ����
same_stock = unique(stock_price(:,1)); 
[number_of_same_stock, number_of_column]= size(same_stock);

stock_price_sorted = [];
for i = 1: number_of_same_stock
    same_stock_data = find(stock_price(:,1) == same_stock(i));
    all_the_same_stock_unsort = stock_price(same_stock_data,:);
    all_the_same_stock = sortrows(all_the_same_stock_unsort, 2);
    [number_of_all_the_same_stock, number_of_column]= size(all_the_same_stock);
    
    % �����Ѳ��P�ɥX�{�b�W���B�W�d�B���d����Ƥ��A�]���ݭn�z�����ƥ[�J���ѻ����
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

% (8) ���馬�L�� / �Q�馬�L�� - 1
% (9) �����S�v(%)
stock_price_sorted(:, 8) = (stock_price_sorted(:, 7) - 1);
stock_price_sorted(:, 9) = stock_price_sorted(:, 8) * 100;


% ��X���G
output_file_name = 'stock_price_step_2.xlsx';

% ���W�����D
writematrix('�Ѳ��N��', output_file_name, 'sheet', '�u�@��1', 'range', 'A1');
writematrix('�Ʀr�Φ������', output_file_name, 'sheet', '�u�@��1', 'range', 'B1');
writematrix('�~', output_file_name, 'sheet', '�u�@��1', 'range', 'C1');
writematrix('��', output_file_name, 'sheet', '�u�@��1', 'range', 'D1');
writematrix('��', output_file_name, 'sheet', '�u�@��1', 'range', 'E1');
writematrix('���L��', output_file_name, 'sheet', '�u�@��1', 'range', 'F1');
writematrix('���馬�L�� / �Q�馬�L��', output_file_name, 'sheet', '�u�@��1', 'range', 'G1');
writematrix('���馬�L�� / �Q�馬�L�� - 1', output_file_name, 'sheet', '�u�@��1', 'range', 'H1');
writematrix('�����S�v(%)', output_file_name, 'sheet', '�u�@��1', 'range', 'I1');

% ��X���
writematrix(stock_price_sorted, output_file_name, 'sheet', '�u�@��1', 'range', 'A2');
