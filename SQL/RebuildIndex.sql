use WGGC
go

set nocount on  
--使用游标重新组织指定库中的索引,消除索引碎片  
--R_T层游标取出当前数据库所有表  
declare R_T cursor  
    for select name from sys.tables  
declare @T varchar(50)  
open r_t  
fetch next from r_t into @t  
while @@fetch_status=0  
 begin  
 --R_index游标判断指定表索引碎片情况并优化  
 declare R_Index cursor  
 for select t.name,i.name,s.avg_fragmentation_in_percent from sys.tables t  
   join sys.indexes i on i.object_id=t.object_id  
   join sys.dm_db_index_physical_stats(db_id(),object_id(@T),null,null,'limited') s  
    on s.object_id=i.object_id and s.index_id=i.index_id  
 declare @TName varchar(50),@IName varchar(50),@avg int,@str varchar(500)  
 open r_index  
 fetch next from r_index into @TName,@Iname,@avg  
 while @@fetch_status=0  
 begin  


   begin  
    set @str='alter index '+rtrim(@Iname)+' on dbo.'+quotename(rtrim(@tname))+' rebuild'  
   end  
 
   print @str  
   exec (@str)  --执行  
   fetch next from r_index into @TName,@Iname,@avg  
 end  
 --结束r_index游标  
 close r_index  
 deallocate r_index  
 fetch next from r_t into @t  
 end  
 --结束R_T游标  
 close r_t  
 deallocate r_t  
 set nocount off 
 go


use OCRConfigDB
go

set nocount on  
--使用游标重新组织指定库中的索引,消除索引碎片  
--R_T层游标取出当前数据库所有表  
declare R_T cursor  
    for select name from sys.tables  
declare @T varchar(50)  
open r_t  
fetch next from r_t into @t  
while @@fetch_status=0  
 begin  
 --R_index游标判断指定表索引碎片情况并优化  
 declare R_Index cursor  
 for select t.name,i.name,s.avg_fragmentation_in_percent from sys.tables t  
   join sys.indexes i on i.object_id=t.object_id  
   join sys.dm_db_index_physical_stats(db_id(),object_id(@T),null,null,'limited') s  
    on s.object_id=i.object_id and s.index_id=i.index_id  
 declare @TName varchar(50),@IName varchar(50),@avg int,@str varchar(500)  
 open r_index  
 fetch next from r_index into @TName,@Iname,@avg  
 while @@fetch_status=0  
 begin  


   begin  
    set @str='alter index '+rtrim(@Iname)+' on dbo.'+quotename(rtrim(@tname))+' rebuild'  
   end  
 
   print @str  
   exec (@str)  --执行  
   fetch next from r_index into @TName,@Iname,@avg  
 end  
 --结束r_index游标  
 close r_index  
 deallocate r_index  
 fetch next from r_t into @t  
 end  
 --结束R_T游标  
 close r_t  
 deallocate r_t  
 set nocount off 
 go
 
use AUDIT
go

set nocount on  
--使用游标重新组织指定库中的索引,消除索引碎片  
--R_T层游标取出当前数据库所有表  
declare R_T cursor  
    for select name from sys.tables  
declare @T varchar(50)  
open r_t  
fetch next from r_t into @t  
while @@fetch_status=0  
 begin  
 --R_index游标判断指定表索引碎片情况并优化  
 declare R_Index cursor  
 for select t.name,i.name,s.avg_fragmentation_in_percent from sys.tables t  
   join sys.indexes i on i.object_id=t.object_id  
   join sys.dm_db_index_physical_stats(db_id(),object_id(@T),null,null,'limited') s  
    on s.object_id=i.object_id and s.index_id=i.index_id  
 declare @TName varchar(50),@IName varchar(50),@avg int,@str varchar(500)  
 open r_index  
 fetch next from r_index into @TName,@Iname,@avg  
 while @@fetch_status=0  
 begin  


   begin  
    set @str='alter index '+rtrim(@Iname)+' on dbo.'+quotename(rtrim(@tname))+' rebuild'  
   end  
 
   print @str  
   exec (@str)  --执行  
   fetch next from r_index into @TName,@Iname,@avg  
 end  
 --结束r_index游标  
 close r_index  
 deallocate r_index  
 fetch next from r_t into @t  
 end  
 --结束R_T游标  
 close r_t  
 deallocate r_t  
 set nocount off 
 go


use Printer
go

set nocount on  
--使用游标重新组织指定库中的索引,消除索引碎片  
--R_T层游标取出当前数据库所有表  
declare R_T cursor  
    for select name from sys.tables  
declare @T varchar(50)  
open r_t  
fetch next from r_t into @t  
while @@fetch_status=0  
 begin  
 --R_index游标判断指定表索引碎片情况并优化  
 declare R_Index cursor  
 for select t.name,i.name,s.avg_fragmentation_in_percent from sys.tables t  
   join sys.indexes i on i.object_id=t.object_id  
   join sys.dm_db_index_physical_stats(db_id(),object_id(@T),null,null,'limited') s  
    on s.object_id=i.object_id and s.index_id=i.index_id  
 declare @TName varchar(50),@IName varchar(50),@avg int,@str varchar(500)  
 open r_index  
 fetch next from r_index into @TName,@Iname,@avg  
 while @@fetch_status=0  
 begin  


   begin  
    set @str='alter index '+rtrim(@Iname)+' on dbo.'+quotename(rtrim(@tname))+' rebuild'  
   end  
 
   print @str  
   exec (@str)  --执行  
   fetch next from r_index into @TName,@Iname,@avg  
 end  
 --结束r_index游标  
 close r_index  
 deallocate r_index  
 fetch next from r_t into @t  
 end  
 --结束R_T游标  
 close r_t  
 deallocate r_t  
 set nocount off 
 go
