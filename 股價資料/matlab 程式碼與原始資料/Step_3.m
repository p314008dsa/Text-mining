% ��z�ݪ�����ƪ�����Φ�
% ���Ӧb�A�γo����ư������ǲ�

% Ū�����
dog = readcell("dog.xlsx");
dog(1,:) = [];  % �h�������D


% ��z��� 20190101 > 2019/01/01
date_str = string(dog(:,2));
new_date_str = insertBefore(date_str, 5, "/");
new_date_str = insertBefore(new_date_str, 8, "/");

% �N����������Ʀr���A 2019/01/01 > 43466
date_code  = datestr(new_date_str, 26);   % ���w�X������ŦXmatlab������榡     %  26�ѼƥN��yyyy/mm/dd
date_num   = m2xdate(date_code);        % �N�X�������matlab����榡�ഫ��excel������榡 (�Ʀr)

% ��s�ݪ������
new_dog = [];
new_dog(:,1) = cell2mat(dog(:,1));
new_dog(:,2) = date_num;

% ��X�����s�n���ݪ������
output_file_name = 'new_dog.xlsx';
writematrix(new_dog, output_file_name, 'sheet', '�u�@��1', 'range', 'A1');


