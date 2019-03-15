﻿USE [WGGC]
GO

INSERT INTO [WGGC].[dbo].[T_Integration_Dictionary]
([TagType],[Key],[Value],[Comment],[Optional0],[Optional1],[Optional2])
SELECT'PrintMode','0','门诊病人','PrintMode: 0-both, 1-film, 2-report, 3-any, 4-do not print.','','',''
union all SELECT'PrintMode','1','住院病人','','','',''
union all SELECT'PrintMode','2','体检病人','','','',''
union all SELECT'PrintMode','3','急诊病人','','','',''
union all SELECT'PrintMode','4','Other','','','',''
union all SELECT'PatientType','1','住院病人','PatientType: 1-in patient, 2-out patient, 3-emergency, 4-physical examination, 5-other.','','',''
union all SELECT'PatientType','2','门诊病人','','','',''
union all SELECT'PatientType','3','急诊病人','','','',''
union all SELECT'PatientType','4','体检病人','','','',''
union all SELECT'PatientType','5','Other','','','',''
union all SELECT'MSG','aaaaa','请稍等！','GetPatientInfo() MSG Key: PrintMode(1bit)+FilmStoreFlag(1bit)+ReportStoreFlag(1bit)+FilmPrintFlag(1bit)+ReportPrintFlag(1bit), 0-unprinted,1-Printed, 2-do not printed,3-printing,9-stored.','','',''
union all SELECT'MSG','bbbbb','您还有部分检查结果尚未准备好，请稍后再试！','','','',''
union all SELECT'MSG','ccccc','您有部分检查结果已准备好，请稍等！','','','',''
union all SELECT'MSG','*00**','您胶片和报告尚未准备好，请稍后再试！','','','',''
union all SELECT'MSG','***33','您胶片和报告正在打印，谢谢！','','','',''
union all SELECT'MSG','009**','您胶片尚未准备好，请稍后再试！','','','',''
union all SELECT'MSG','10***','您胶片尚未准备好，请稍后再试！','','','',''
union all SELECT'MSG','090**','您报告尚未审核，谢谢！','','','',''
union all SELECT'MSG','2*0**','您报告尚未审核，谢谢！','','','',''
union all SELECT'MSG','***11','您胶片和报告已经打印，谢谢！','','','',''
union all SELECT'MSG','***12','您胶片和报告已经打印，谢谢！','','','',''
union all SELECT'MSG','***21','您胶片和报告已经打印，谢谢！','','','',''
union all SELECT'MSG','***22','您胶片和报告已经打印，谢谢！','','','',''
union all SELECT'MSG','19*1*','您胶片已经打印，谢谢！','','','',''
union all SELECT'MSG','19*2*','您胶片已经打印，谢谢！','','','',''
union all SELECT'MSG','2*9*1','您报告已经打印，谢谢！','','','',''
union all SELECT'MSG','2*9*2','您报告已经打印，谢谢！','','','',''
union all SELECT'MSG','3901*','您胶片已经打印, 但是报告尚未审核。请稍后再试！','','','',''
union all SELECT'MSG','3902*','您胶片已经打印, 但是报告尚未审核。请稍后再试！','','','',''
union all SELECT'MSG','309*1','您报告已经打印, 但是胶片尚未准备好。请稍后再试！','','','',''
union all SELECT'MSG','309*2','您报告已经打印, 但是胶片尚未准备好。请稍后再试！','','','',''
union all SELECT'MSG','*9900','您胶片和报告已经准备好，请稍等！','','','',''
union all SELECT'MSG','19*0*','您胶片已经准备好，请稍等！','','','',''
union all SELECT'MSG','2*9*0','您报告已经审核，请稍等！','','','',''
union all SELECT'MSG','09901','您胶片和报告已经准备好，但是报告已经打印。请稍等！','','','',''
union all SELECT'MSG','09902','您胶片和报告已经准备好，但是报告已经打印。请稍等！','','','',''
union all SELECT'MSG','39901','您胶片和报告已经准备好，但是报告已经打印。请稍等！','','','',''
union all SELECT'MSG','39902','您胶片和报告已经准备好，但是报告已经打印。请稍等！','','','',''
union all SELECT'MSG','09910','您胶片和报告已经准备好，但是胶片已经打印。请稍等！','','','',''
union all SELECT'MSG','09920','您胶片和报告已经准备好，但是胶片已经打印。请稍等！','','','',''
union all SELECT'MSG','39910','您胶片和报告已经准备好，但是胶片已经打印。请稍等！','','','',''
union all SELECT'MSG','39920','您胶片和报告已经准备好，但是胶片已经打印。请稍等！','','','',''
union all SELECT'MSG','309*0','您报告已经审核，但是胶片尚未准备好。请稍等！','','','',''
union all SELECT'MSG','3900*','您胶片已经准备好，但是报告尚未审核。请稍等！','','','',''
union all SELECT'MSG','EEEEE','您有胶片或报告可打印，请稍等！','','','',''
union all SELECT'MSG','DDDDD','您没有可打印的胶片和报告，请稍后再试！','','','',''