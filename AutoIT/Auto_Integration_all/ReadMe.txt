功能改进及Bug修复
1、GetPatientInfo存储过程完善：
1.1、增加卡号转换示例代码；
1.2、存储过程执行异常时，提示修改为“您的胶片报告尚未完成，请稍后再试！”
1.3、时间限制提醒存在多个时，使用最早的时间进行提示；
2、GetAllowPrint存储过程完善
3、sp_Integration_GetPrintStatusAndPrintMode存储过程Bug修复
4、sp_Integration_SetExamInfo存储过程优化


新增功能
1、OCR识别信息，在指定时间内查询的功能，可启用和关闭，并增加数据库实现方式
2、可同时支持报告合并和拆分


注意事项：
1、由之前版本的标准集成场地升级至此版集成程序，请先依次执行数据库脚本，再替换标准集成程序。
2、由之前版本的非标集成场地升级成此版集成程序，请联系当区IS。

From Ralf
Install:
Click the exe file to install