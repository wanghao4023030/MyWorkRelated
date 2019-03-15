use WGGC
go

set nocount on  
--ʹ���α�������ָ֯�����е�����,����������Ƭ  
--R_T���α�ȡ����ǰ���ݿ����б�  
declare R_T cursor  
    for select name from sys.tables  
declare @T varchar(50)  
open r_t  
fetch next from r_t into @t  
while @@fetch_status=0  
 begin  
 --R_index�α��ж�ָ����������Ƭ������Ż�  
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
   exec (@str)  --ִ��  
   fetch next from r_index into @TName,@Iname,@avg  
 end  
 --����r_index�α�  
 close r_index  
 deallocate r_index  
 fetch next from r_t into @t  
 end  
 --����R_T�α�  
 close r_t  
 deallocate r_t  
 set nocount off 
 go


use OCRConfigDB
go

set nocount on  
--ʹ���α�������ָ֯�����е�����,����������Ƭ  
--R_T���α�ȡ����ǰ���ݿ����б�  
declare R_T cursor  
    for select name from sys.tables  
declare @T varchar(50)  
open r_t  
fetch next from r_t into @t  
while @@fetch_status=0  
 begin  
 --R_index�α��ж�ָ����������Ƭ������Ż�  
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
   exec (@str)  --ִ��  
   fetch next from r_index into @TName,@Iname,@avg  
 end  
 --����r_index�α�  
 close r_index  
 deallocate r_index  
 fetch next from r_t into @t  
 end  
 --����R_T�α�  
 close r_t  
 deallocate r_t  
 set nocount off 
 go
 
use AUDIT
go

set nocount on  
--ʹ���α�������ָ֯�����е�����,����������Ƭ  
--R_T���α�ȡ����ǰ���ݿ����б�  
declare R_T cursor  
    for select name from sys.tables  
declare @T varchar(50)  
open r_t  
fetch next from r_t into @t  
while @@fetch_status=0  
 begin  
 --R_index�α��ж�ָ����������Ƭ������Ż�  
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
   exec (@str)  --ִ��  
   fetch next from r_index into @TName,@Iname,@avg  
 end  
 --����r_index�α�  
 close r_index  
 deallocate r_index  
 fetch next from r_t into @t  
 end  
 --����R_T�α�  
 close r_t  
 deallocate r_t  
 set nocount off 
 go


use Printer
go

set nocount on  
--ʹ���α�������ָ֯�����е�����,����������Ƭ  
--R_T���α�ȡ����ǰ���ݿ����б�  
declare R_T cursor  
    for select name from sys.tables  
declare @T varchar(50)  
open r_t  
fetch next from r_t into @t  
while @@fetch_status=0  
 begin  
 --R_index�α��ж�ָ����������Ƭ������Ż�  
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
   exec (@str)  --ִ��  
   fetch next from r_index into @TName,@Iname,@avg  
 end  
 --����r_index�α�  
 close r_index  
 deallocate r_index  
 fetch next from r_t into @t  
 end  
 --����R_T�α�  
 close r_t  
 deallocate r_t  
 set nocount off 
 go
