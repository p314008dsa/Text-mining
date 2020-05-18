% �N�ѻ��P���S��ƻP�ݪ�����ƦX��

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ū�����
new_dog = cell2mat(readcell('new_dog.xlsx'));
stock_price = stock_price_sorted;
% stock_price = table2array(readtable('stock_price_step_2.xlsx','PreserveVariableNames', 1));

% �N�ѻ���ƦX�֨�ݪ������
[number_of_new_dog, number_of_column_2]= size(new_dog);
% new_dog_2 = [];
for i = 1: number_of_new_dog
    same_code = find(stock_price(:,1) == new_dog(i, 1));
    all_the_same_code = stock_price(same_code, :);
    same_date = find(all_the_same_code(:,2) == new_dog(i, 2));
    all_the_same_date = all_the_same_code(same_date, :);
    
    % �Y�s�D�o�ͦb����A�h��J�񰲫e�u�@�骺�ѻ��P���S�v���
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
    % �Y���ѻ���ơA�~�s�W���
    if isempty(same_date) == 0
        new_dog(i, 3:9) = all_the_same_date(:,3:9);
    end
end

% ��X���G
output_file_name = 'new_dog_step_4.xlsx';

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
writematrix(new_dog, output_file_name, 'sheet', '�u�@��1', 'range', 'A2');

