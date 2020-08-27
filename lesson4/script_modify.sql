-- �������� �������, ������� ������ 2005 ���� (������ 15 ���)
select * from profiles where birthday > '2005-01-01';

-- �������� ���� �������� ������������� � ������� 800 ���� �� ���� �������� � ��� ��������, ������� ������ 2005 ����
-- ������ �������� ��������� ���, ���� �� �������� ����� ��������
update profiles set birthday = birthday - INTERVAL 800 DAY where birthday > '2005-01-01';

-- �������� ���� �� ���������, ������� �������� ������ ����
select * from messages where from_user_id = to_user_id ;

-- �������� ���� �� ������� �� ������, ������� ������� ������ ����
select * from friendship where user_id = friend_id ;

-- ��������, ���� �� ��������, ��� ������� ���� �������� ������, ��� ���� ����������
select * from communities where created_at > updated_at ;

-- �������� 360 ���� �� ���� �������� � ��������� ������ �� ��� ���, ���� ���� �������� �� ������ ������ ���� ����������
update communities set created_at = created_at - INTERVAL 360 DAY where created_at > updated_at;