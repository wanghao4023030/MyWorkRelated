--This script is to insert the data to HIS system
--Then we can create the order and request information;
--This just a sample
--Ralf Wang

--for reqeust canel test--

use ECS
INSERT INTO Request VALUES
('R007', '0', 'O005', '���', '��ǻ', '1', '15', 'false', '001', '0', '����', '2016-09-13 00:00:00.000', '2016-09-14 00:00:00.000', NULL),
('R008', '0', 'O005', '����', '����', '3', '13', 'false', '004', '0', '�ж���', '2016-09-13 00:00:00.000', '2016-09-14 00:00:00.000', NULL)

--for payment test--
Insert Into PlaceOrder Values
('O006', '0', 'T003', '����ָ����', '0', '������', '2016-09-18 00:00:00.000', '��ʤ', 'Test', '΢�²��Ը���01', '0', '2016-09-18 00:00:00.000', NULL, NULL)

INSERT INTO Request VALUES
('R009', '0', 'O006', '�ڿƳ���', '����', '1', '65', 'false', '001', '0', '����ʯ', '2016-09-18 00:00:00.000', '2016-09-14 00:00:00.000', NULL)
--for payment test--

--for multi payment test--
Insert Into PlaceOrder Values
('O007', '0', 'T007', '����ָ����', '0', '���ܽ�ʯ', '2016-09-26 00:00:00.000', '���', 'Test', '΢�²��Ը���02', '0', '2016-09-26 00:00:00.000', NULL, NULL)

INSERT INTO Request VALUES
('R010', '0', 'O007', '����', '�ڿ���', '2', '150', 'false', '002', '0', '��ʯ', '2016-09-26 00:00:00.000', '2016-09-26 00:00:00.000', NULL),
('R011', '0', 'O007', '��ǻ', '��Ҷ', '1', '63', 'false', '001', '0', '������Ӳ��', '2016-09-26 00:00:00.000', '2016-09-26 00:00:00.000', NULL),
('R012', '0', 'O007', 'Ѫ����', 'ѪҺ', '1', '163', 'false', '002', '0', '����', '2016-09-26 00:00:00.000', '2016-09-26 00:00:00.000', NULL)

--for multi payment test--