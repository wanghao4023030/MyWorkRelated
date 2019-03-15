--This script is to insert the data to HIS system
--Then we can create the order and request information;
--This just a sample
--Ralf Wang

--for reqeust canel test--

use ECS
INSERT INTO Request VALUES
('R007', '0', 'O005', '鼻窦', '鼻腔', '1', '15', 'false', '001', '0', '鼻咽', '2016-09-13 00:00:00.000', '2016-09-14 00:00:00.000', NULL),
('R008', '0', 'O005', '耳朵', '耳廓', '3', '13', 'false', '004', '0', '中耳炎', '2016-09-13 00:00:00.000', '2016-09-14 00:00:00.000', NULL)

--for payment test--
Insert Into PlaceOrder Values
('O006', '0', 'T003', '门诊指引单', '0', '胆囊炎', '2016-09-18 00:00:00.000', '陈胜', 'Test', '微新测试付费01', '0', '2016-09-18 00:00:00.000', NULL, NULL)

INSERT INTO Request VALUES
('R009', '0', 'O006', '内科超声', '胆囊', '1', '65', 'false', '001', '0', '胆结石', '2016-09-18 00:00:00.000', '2016-09-14 00:00:00.000', NULL)
--for payment test--

--for multi payment test--
Insert Into PlaceOrder Values
('O007', '0', 'T007', '门诊指引单', '0', '胆管结石', '2016-09-26 00:00:00.000', '吴广', 'Test', '微新测试付费02', '0', '2016-09-26 00:00:00.000', NULL, NULL)

INSERT INTO Request VALUES
('R010', '0', 'O007', '胆管', '内窥镜', '2', '150', 'false', '002', '0', '结石', '2016-09-26 00:00:00.000', '2016-09-26 00:00:00.000', NULL),
('R011', '0', 'O007', '胸腔', '肺叶', '1', '63', 'false', '001', '0', '肺粥样硬化', '2016-09-26 00:00:00.000', '2016-09-26 00:00:00.000', NULL),
('R012', '0', 'O007', '血常规', '血液', '1', '163', 'false', '002', '0', '发炎', '2016-09-26 00:00:00.000', '2016-09-26 00:00:00.000', NULL)

--for multi payment test--