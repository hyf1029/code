select * from Shops

select * from Categories
select * from CardLevels
select * from MemCards
select * from Users
select * from ConsumeOrders
select * from CategoryItems
--//S_ID, S_Name, S_Category, S_ContactName, S_ContactTel, S_Address, S_Remark, S_IsHasSetAdmin, S_CreateTime
--insert into Shops values('关谷天地店',2,'鹿晗','13586981854','湖北省武汉市洪山区关山大道光谷天地3-186','哈哈','true','2015/8/9')
--insert into Shops values('意大利店',3,'陈乔恩','13567451854','湖北省武汉市江岸区后湖大道','嘿嘿','false','2014/12/9')
--insert into Shops values('情人岛店',1,'鹿晗','13555858854','湖北省武汉市黄陂区','yeah','true','2004/8/9')

go
--用户登录        U_ID, S_ID, U_LoginName, U_Password, U_RealName, U_Sex, U_Telephone, U_Role, U_CanDelete
if exists(select * from  sys.sysobjects where name='P_UserLogin')
	drop proc P_UserLogin
go
create procedure P_UserLogin
	@U_LoginName nvarchar(20),
	@U_Password nvarchar(50)
as
	select * from Users where U_LoginName=@U_LoginName and U_Password=@U_Password
go

--获取店铺列表
if exists(select * from  sys.sysobjects where name='GetPageShopsByCondition')
	drop proc GetPageShopsByCondition
go
create procedure GetPageShopsByCondition
	@PageSize int,
	@CurrentIndexCount int,
	@RecordCount int output,
	@S_Name varchar(20),
	@S_ContactName varchar(20),
	@S_Address varchar(50)
as
	declare @sql nvarchar(1000),@sql1 nvarchar(800),@condition nvarchar(800)=''
	if @S_Name!=''
	begin
		set @condition=@condition+' and S_Name like ''%'+@S_Name+'%'''
	end
	if @S_ContactName!=''
	begin
		set @condition+=' and S_ContactName like ''%'+@S_ContactName+'%'''
	end
	if @S_Address!=''
	begin
		set @condition+=' and S_Address like ''%'+@S_Address+'%'''
	end
	set @sql='select top '+cast(@PageSize as varchar)+' * from Shops where 1=1 '+@condition+' and S_ID not in (select top '+cast(@PageSize*(@CurrentIndexCount-1) as varchar)+' S_ID from Shops where 1=1 '+@condition+' order by S_ID asc) order by S_ID asc'
	set @sql1='select @Rc=count(*) from Shops where 1=1 '+@condition+''
	exec sp_executesql @sql
	exec sp_executesql @sql1,N'@Rc int output',@RecordCount output
go
--declare @rc int
--exec GetPageShopsByCondition 1,1,@rc output,'光','',''
--select @rc
--select top 1 * from Shops where 1=1 and S_ID not in (select top (1*(1-1)) S_ID from Shops where 1=1 order by S_ID asc) order by S_ID asc

--添加店铺
if exists(select * from  sys.sysobjects where name='P_InsertShops')
	drop proc P_InsertShops
go
create procedure P_InsertShops
	@S_Name varchar(20),
	@S_Category int,
	@S_ContactName varchar(20),
	@S_ContactTel varchar(20),
	@S_Address varchar(50),
	@S_Remark varchar(100),
	@S_IsHasSetAdmin bit,
	@S_CreateTime datetime
as
	insert into Shops values(@S_Name,@S_Category,@S_ContactName,@S_ContactTel,@S_Address,@S_Remark,@S_IsHasSetAdmin,@S_CreateTime)
go
--删除店铺
if exists(select * from  sys.sysobjects where name='P_DeleteShops')
	drop proc P_DeleteShops
go
create procedure P_DeleteShops
	@S_ID int
as
	delete from Shops where S_ID=@S_ID
go
--修改店铺
if exists(select * from  sys.sysobjects where name='P_UpdateShops')
	drop proc P_UpdateShops
go
create procedure P_UpdateShops
	@S_ID int,
	@S_Name varchar(20),
	@S_Category int,
	@S_ContactName varchar(20),
	@S_ContactTel varchar(20),
	@S_Address varchar(50),
	@S_Remark varchar(100)
as
	update Shops set S_Name=@S_Name,S_Category=@S_Category,S_ContactName=@S_ContactName,S_ContactTel=@S_ContactTel,S_Address=@S_Address,S_Remark=@S_Remark where S_ID=@S_ID
go
--得到单个店铺信息
if exists(select * from  sys.sysobjects where name='P_GetSingleShop')
	drop proc P_GetSingleShop
go
create procedure P_GetSingleShop
	@S_ID int
as
	select * from Shops where S_ID=@S_ID
go

--分配管理员
if exists(select * from sys.sysobjects where name ='P_SetShopsAdmin')
	drop procedure P_SetShopsAdmin
go
create proc P_SetShopsAdmin
	@S_IsHasSetAdmin bit,
	@S_ID int,
	@US_ID int,
	@U_LoginName nvarchar(20),
	@U_PassWord nvarchar(50),
	@U_Role int,
	@U_CanDelete bit
as
	update Shops set S_IsHasSetAdmin=@S_IsHasSetAdmin where S_ID= @S_ID
	insert into Users(S_ID,U_LoginName,U_Password,U_Role,U_CanDelete) values(@US_ID,@U_LoginName,@U_PassWord,@U_Role,@U_CanDelete)
go



--CL_ID, CL_LevelName, CL_NeedPoint, CL_Point, CL_Percent
--insert into CardLevels values('普通会员',100,10,1)
--insert into CardLevels values('银卡会员',500,8,0.9)
--insert into CardLevels values('金卡会员',1000,6,0.8)
--insert into CardLevels values('至尊VIP',5000,5,0.7)
go

--获取等级列表
if exists(select * from  sys.sysobjects where name='P_GetCardLevelsList')
	drop proc P_GetCardLevelsList
go
create procedure P_GetCardLevelsList
	@PageSize int,
	@CurrentIndexCount int,
	@RecordCount int output,
	@CL_LevelName nvarchar(20)
as
	declare @sql nvarchar(1000),@sql1 nvarchar(800),@condition nvarchar(800)=''
	if @CL_LevelName!=''
	begin
		set @condition = @condition+' and CL_LevelName like ''%'+@CL_LevelName+'%'''
	end
	set @sql='select top '+cast(@PageSize as varchar)+' * from CardLevels where 1=1 '+@condition+' and CL_ID not in (select top '+cast(@PageSize*(@CurrentIndexCount-1) as varchar)+' CL_ID from CardLevels where 1=1 '+@condition+' order by CL_ID asc) order by CL_ID asc'
	set @sql1='select @Rc=count(*) from CardLevels where 1=1 '+@condition+''
	exec sp_executesql @sql
	exec sp_executesql @sql1,N'@Rc int output',@RecordCount output
go

--select top 1 * from CardLevels where 1=1 and CL_ID not in (select top (1*(1-1)) CL_ID from CardLevels where 1=1 order by CL_ID asc) order by CL_ID asc
--declare @aa int
--exec P_GetCardLevelsList 2,1,@aa output,'通'
--select @aa
--获取所有的等级名称
if exists(select * from  sys.sysobjects where name='P_GetAllCardLevelName')
	drop proc P_GetAllCardLevelName
go
create procedure P_GetAllCardLevelName
as
	select * from CardLevels
go
--新增会员等级
if exists(select * from  sys.sysobjects where name='P_InsertCardLevels')
	drop proc P_InsertCardLevels
go
create procedure P_InsertCardLevels
	@CL_LevelName nvarchar(20),
	@CL_NeedPoint nvarchar(50),
	@CL_Point float,
	@CL_Percent float
as
	insert into CardLevels values(@CL_LevelName,@CL_NeedPoint,@CL_Point,@CL_Percent)
go

--删除会员等级
if exists(select * from  sys.sysobjects where name='P_DeleteCardLevels')
	drop proc P_DeleteCardLevels
go
create procedure P_DeleteCardLevels
	@CL_ID int
as
	delete from CardLevels where CL_ID=@CL_ID
go

--修改会员等级
if exists(select * from  sys.sysobjects where name='P_UpdateCardLevels')
	drop proc P_UpdateCardLevels
go
create procedure P_UpdateCardLevels
	@CL_ID int,
	@CL_LevelName nvarchar(20),
	@CL_NeedPoint nvarchar(50),
	@CL_Point float,
	@CL_Percent float
as
	update CardLevels set CL_LevelName=@CL_LevelName,CL_NeedPoint=@CL_NeedPoint,CL_Point=@CL_Point,CL_Percent=@CL_Percent where CL_ID=@CL_ID
go

--获取单个会员等级
if exists(select * from  sys.sysobjects where name='P_GetSingleCardLevel')
	drop proc P_GetSingleCardLevel
go
create procedure P_GetSingleCardLevel
	@CL_ID int
as
	select * from CardLevels where CL_ID=@CL_ID
go

--U_ID, S_ID, U_LoginName, U_Password, U_RealName, U_Sex, U_Telephone, U_Role, U_CanDelete
--insert into Users values(1,'zs','1','张三','男','1352894562',1,'false')
--insert into Users values(2,'ls','1','李四','男','1589654562',2,'true')
--insert into Users values(3,'xh','1','小红','女','1345894982',3,'false')
go
--创建查看用户的视图
if exists(select * from sys.sysobjects where name ='VW_Users')
	drop view VW_Users
go
create view VW_Users
as
	select Users.*,Shops.S_Name from Users inner join Shops on Users.S_ID=Shops.S_ID
go
--获取用户列表
if exists(select * from  sys.sysobjects where name='P_GetUserList')
	drop proc P_GetUserList
go
create procedure P_GetUserList
	@PageSize int,
	@CurrentIndexCount int,
	@RecordCount int output,	
	@U_LoginName nvarchar(20),
	@U_RealName nvarchar(20),
	@U_Telephone nvarchar(20),
	@S_ID int
as
	declare @sql nvarchar(1000),@sql1 nvarchar(800),@condition nvarchar(800)=''
	if @U_LoginName !=''
	begin
		set @condition += ' and U_LoginName like ''%'+@U_LoginName+'%'''
	end
	if @U_RealName !=''
	begin
		set @condition += ' and U_RealName like ''%'+@U_RealName+'%'''
	end
	if @U_Telephone!=''
	begin
		set @condition += ' and U_Telephone like ''%'+@U_Telephone+'%'''
	end
	if @S_ID!=0
	begin
		set @condition += ' and S_ID='+cast(@S_ID as varchar)+''
	end
    set @sql ='select top '+cast(@PageSize as varchar)+' * from VW_Users where 1=1 '+@condition+' and U_ID not in (select top '+cast(@PageSize*(@CurrentIndexCount-1) as varchar)+'U_ID from VW_Users where 1=1 '+@condition+' order by U_ID asc) order by U_ID asc'
	set @sql1='select @Rc=count(*) from VW_Users where 1=1 '+@condition+''
	exec sp_executesql @sql
	exec sp_executesql @sql1,N'@Rc int output',@RecordCount output
go

--select top 1 * from VW_Users where 1=1 and U_ID not in (select top (1*(1-1)) U_ID from VW_Users where 1=1 order by U_ID asc) order by U_ID asc
--declare @aa int
--exec P_GetUserList 1,1,@aa output,'','',''
--select @aa


--添加用户
if exists(select * from  sys.sysobjects where name='P_InsertUser')
	drop proc P_InsertUser
go
create procedure P_InsertUser
	@S_ID int,
	@U_LoginName nvarchar(20),
	@U_Password nvarchar(50),
	@U_RealName nvarchar(20),
	@U_Telephone nvarchar(20),
	@U_Sex nvarchar(20),
	@U_Role int,
	@U_CanDelete bit
as
	insert into Users values(@S_ID,@U_LoginName,@U_Password,@U_RealName,@U_Sex,@U_Telephone,@U_Role,@U_CanDelete)
go

--删除用户
if exists(select * from  sys.sysobjects where name='P_DeleteUser')
	drop proc P_DeleteUser
go
create procedure P_DeleteUser
	@U_ID int
as
	delete from Users where U_ID=@U_ID
go

--修改用户
if exists(select * from  sys.sysobjects where name='P_UpdateUser')
	drop proc P_UpdateUser
go
create procedure P_UpdateUser
	@U_ID int,
	@U_LoginName nvarchar(20),
	@U_Password nvarchar(50),
	@U_RealName nvarchar(20),
	@U_Telephone nvarchar(20),
	@U_Sex nvarchar(20),
	@U_Role int,
	@U_CanDelete bit
as
	update Users set U_LoginName=@U_LoginName,U_Password=@U_Password,U_RealName=@U_RealName,U_Sex=@U_Sex,U_Role=@U_Role,U_CanDelete=@U_CanDelete,U_Telephone=@U_Telephone where U_ID=@U_ID
go

--获取单个用户
if exists(select * from  sys.sysobjects where name='P_GetSingleUser')
	drop proc P_GetSingleUser
go
create procedure P_GetSingleUser
	@U_ID int
as
	select * from Users where U_ID=@U_ID
go


--EG_ID, S_ID, EG_GiftCode, EG_GiftName, EG_Photo, EG_Point, EG_Number, EG_ExchangNum, EG_Remark
--创建查看礼品的视图
if exists(select * from sys.sysobjects where name ='VW_ExchangeGifts')
	drop view VW_ExchangeGifts
go
create view VW_ExchangeGifts
as
	select e.*,s.S_Name from ExchangGifts e inner join Shops s on e.S_ID=s.S_ID
go
--根据条件给礼品进行分页
if exists(select * from sys.sysobjects where name ='P_GetPageExchangeGiftsByCondition')
	drop proc P_GetPageExchangeGiftsByCondition
go
create proc P_GetPageExchangeGiftsByCondition
	@PageIndex int,
	@CurrentCountIndex int,
	@RecordeCount int output,
	@EG_GiftCode nvarchar(255),
	@EG_GiftName nvarchar(255),
	@S_ID int
as
	declare @sql nvarchar(2000),@sql1 nvarchar(1000),@condition nvarchar(1000)=''
	if @EG_GiftCode != ''
	begin
		set @condition+=' and EG_GiftCode like ''%'+@EG_GiftCode+'%'''
	end
	if @EG_GiftName !=''
	begin
		set @condition+=' and EG_GiftName like ''%'+@EG_GiftName+'%'''
	end
	if @S_ID!=0
	begin
		set @condition += ' and S_ID='+cast(@S_ID as varchar)+''
	end
	set @sql='select top '+cast(@PageIndex as nvarchar)+' * from VW_ExchangeGifts where 1=1 '+@condition+' and EG_ID not in (select top '+cast(@PageIndex*(@CurrentCountIndex-1) as nvarchar)+' EG_ID from VW_ExchangeGifts where 1=1 '+@condition+' order by EG_ID asc ) order by EG_ID asc'
	set @sql1='select @Rc=count(*) from VW_ExchangeGifts where 1=1 '+@condition+''
	exec sp_executesql @sql
	exec sp_executesql @sql1 ,N'@Rc int output',@RecordeCount output
go 
--declare @aa int
--exec P_GetPageExchangeGiftsByCondition 4,1,@aa output,'',''
--select @aa
--select top 1 * from VW_ExchangeGifts where 1=1 and EG_ID not in (select top (1*(2-1)) EG_ID from VW_ExchangeGifts where 1=1 order by EG_ID asc ) order by EG_ID asc

--新增礼品
if exists(select * from sys.sysobjects where name ='P_InsertGifts')
	drop proc P_InsertGifts
go
create proc P_InsertGifts
	@S_ID int,
	@EG_GiftCode nvarchar(255),
	@EG_GiftName nvarchar(255),
	@EG_Photo nvarchar(255),
	@EG_Point int,
	@EG_Number int,
	@EG_Remark nvarchar(255)
as
	insert into ExchangGifts(S_ID,EG_GiftCode,EG_GiftName,EG_Photo,EG_Point,EG_Number,EG_Remark) values(@S_ID,@EG_GiftCode,@EG_GiftName,@EG_Photo,@EG_Point,@EG_Number,@EG_Remark);
go

--删除礼品
if exists(select * from sys.sysobjects where name ='P_DeleteGifts')
	drop proc P_DeleteGifts
go
create proc P_DeleteGifts
	@EG_ID int
as
	delete from ExchangGifts where EG_ID=@EG_ID
go

--修改礼品
if exists(select * from sys.sysobjects where name ='P_UpdateGifts')
	drop proc P_UpdateGifts
go
create proc P_UpdateGifts
	@EG_ID int,
	@EG_GiftCode nvarchar(255),
	@EG_GiftName nvarchar(255),
	@EG_Photo nvarchar(255),
	@EG_Point int,
	@EG_Number int,
	@EG_Remark nvarchar(255)
as
	update ExchangGifts set EG_GiftCode=@EG_GiftCode,EG_GiftName=@EG_GiftName,EG_Photo=@EG_Photo,EG_Point=@EG_Point,EG_Number=@EG_Number,EG_Remark=@EG_Remark where EG_ID=@EG_ID
go

--获取单个礼品信息
if exists(select * from sys.sysobjects where name ='P_GetSingleGifts')
	drop proc P_GetSingleGifts
go
create proc P_GetSingleGifts
	@EG_ID int
as
	select * from ExchangGifts where EG_ID=@EG_ID
go



--MC_ID, CL_ID, S_ID, MC_CardID, MC_Password, MC_Name, MC_Sex, MC_Mobile, MC_Photo, MC_Birthday_Month, MC_Birthday_Day, MC_BirthdayType, MC_IsPast, MC_PastTime, MC_Point, MC_Money, MC_TotalMoney, MC_TotalCount, MC_OverCount, MC_State, MC_IsPointAuto, MC_RefererID, MC_RefererCard, MC_RefererName, MC_CreateTime
--创建查看会员的视图
if exists(select * from sys.sysobjects where name ='VW_MenCards')
	drop view VW_MenCards
go
create view VW_MenCards
as
	select m.*,s.S_Name,c.CL_LevelName from MemCards m inner join Shops s on m.S_ID=s.S_ID inner join CardLevels c on m.CL_ID= c.CL_ID
go
--根据条件给会员进行分页
if exists(select * from sys.sysobjects where name ='P_GetPageMenCardsByCondition')
	drop proc P_GetPageMenCardsByCondition
go
create proc P_GetPageMenCardsByCondition
	@PageSize int,
	@CurrentIndexCount int,
	@RecordCount int output,
	@MC_CardID nvarchar(50),
	@MC_Name nvarchar(20),
	@MC_Mobile nvarchar(50),
	@CL_ID int,
	@MC_State int,
	@S_ID int
as
	declare @sql nvarchar(2000),@sql1 nvarchar(1000),@condition nvarchar(1000)=''
	if @MC_CardID !=''
	begin
		set @condition += ' and MC_CardID like ''%'+@MC_CardID+'%'''
	end
	if @MC_Name !=''
	begin
		set @condition += ' and MC_Name like ''%'+@MC_Name+'%'''
	end
	if @MC_Mobile !=''
	begin
		set @condition += ' and MC_Mobile like ''%'+@MC_Mobile+'%'''
	end
	if @CL_ID!=0
	begin
		set @condition += ' and CL_ID = '+cast(@CL_ID as varchar)+''
	end
	if @MC_State!=0
	begin
		set @condition += ' and MC_State = '+cast(@MC_State as varchar)+''
	end
	if @S_ID!=0
	begin
		set @condition += ' and S_ID='+cast(@S_ID as varchar)+''
	end
	set @sql='select top '+cast(@PageSize as varchar)+' * from VW_MenCards where 1=1 '+@condition+' and MC_ID not in (select top '+cast(@PageSize*(@CurrentIndexCount-1) as varchar)+' MC_ID from VW_MenCards where 1=1 '+@condition+' order by MC_ID asc) order by MC_ID asc'
	set @sql1='select @RC =count(*) from VW_MenCards where 1=1 '+@condition+''
	exec sp_executesql @sql
	exec sp_executesql @sql1 ,N'@RC int output',@RecordCount output
go
--select * from VW_MenCards
--select top 5 * from VW_MenCards where 1=1 and MC_ID not in (select top (5*(2-1)) MC_ID from VW_MenCards where 1=1 order by MC_ID asc) order by MC_ID asc
--declare @aa int
--exec P_GetPageMenCardsByCondition 5,1,@aa output,'','','',4,0
--select @aa

--获取最后一个的会员卡号
if exists(select * from sys.sysobjects where name ='P_GetMaxMenCards')
	drop proc P_GetMaxMenCards
go
create proc P_GetMaxMenCards
as
	select top 1 * from MemCards order by MC_ID desc
go

--MC_ID, CL_ID, S_ID, MC_CardID, MC_Password, MC_Name, MC_Sex, MC_Mobile, MC_Photo, MC_Birthday_Month, MC_Birthday_Day, MC_BirthdayType, MC_IsPast, MC_PastTime, MC_Point, MC_Money, MC_TotalMoney, MC_TotalCount, MC_OverCount, MC_State, MC_IsPointAuto, MC_RefererID, MC_RefererCard, MC_RefererName, MC_CreateTime
--新增会员
if exists(select * from sys.sysobjects where name ='P_InsertMenCards')
	drop proc P_InsertMenCards
go
create proc P_InsertMenCards
	@CL_ID int,
	@S_ID int,
	@MC_CardID int,
	@MC_Password  nvarchar(20),
	@MC_Name nvarchar(20),
	@MC_Sex int,
	@MC_Mobile nvarchar(50),
	@MC_BirthdayType tinyint,
	@MC_Birthday_Month int,
	@MC_Birthday_Day int,
	@MC_IsPast bit,
	@MC_PastTime datetime,
	@MC_State int,
	@MC_Money real,
	@MC_Point int,
	@MC_IsPointAuto bit,
	@MC_RefererCard nvarchar(50),
	@MC_RefererName  nvarchar(50),
	@MC_CreateTime datetime
as
	insert into MemCards(CL_ID,S_ID,MC_CardID,MC_Password,MC_Name,MC_Sex,MC_Mobile,MC_Birthday_Month,MC_Birthday_Day,MC_BirthdayType,MC_IsPast,MC_PastTime,MC_Point,MC_Money,MC_State,MC_IsPointAuto,MC_RefererCard,MC_RefererName,MC_CreateTime) 
	values(@CL_ID,@S_ID,@MC_CardID,@MC_Password,@MC_Name,@MC_Sex,@MC_Mobile,@MC_Birthday_Month,@MC_Birthday_Day,@MC_BirthdayType,@MC_IsPast,@MC_PastTime,@MC_Point,@MC_Money,@MC_State,@MC_IsPointAuto,@MC_RefererCard,@MC_RefererName,@MC_CreateTime)
go

--exec P_InsertMenCards 1,1,1,'1','1','1','1','1','1','1','true','2018/8/8','1','1','1','true','','','2017/8/9'

--删除会员
if exists(select * from sys.sysobjects where name ='P_DeleteMenCard')
	drop proc P_DeleteMenCard
go
create proc P_DeleteMenCard
	@MC_CardID int
as
	delete from MemCards where MC_CardID=@MC_CardID
go



--修改会员
if exists(select * from sys.sysobjects where name ='P_UpdateMenCard')
	drop proc P_UpdateMenCard
go
create proc P_UpdateMenCard
	@CL_ID int,
	@MC_CardID int,
	@MC_Password  nvarchar(20),
	@MC_Name nvarchar(20),
	@MC_Sex int,
	@MC_Mobile nvarchar(50),
	@MC_BirthdayType tinyint,
	@MC_Birthday_Month int,
	@MC_Birthday_Day int,
	@MC_IsPast bit,
	@MC_PastTime datetime,
	@MC_State int,
	@MC_Money real,
	@MC_Point int,
	@MC_IsPointAuto bit,
	@MC_RefererCard nvarchar(50),
	@MC_RefererName  nvarchar(50)
as
	update MemCards set CL_ID=@CL_ID,MC_Password=@MC_Password,MC_Name=@MC_Name,MC_Sex=@MC_Sex,MC_Mobile=@MC_Mobile,MC_BirthdayType=@MC_BirthdayType,MC_Birthday_Month=@MC_Birthday_Month,MC_Birthday_Day=@MC_Birthday_Day,
	MC_IsPast=@MC_IsPast,MC_PastTime=@MC_PastTime,MC_State=@MC_State,MC_Money=@MC_Money,MC_Point=@MC_Point,MC_IsPointAuto=@MC_IsPointAuto,MC_RefererCard=@MC_RefererCard,MC_RefererName=@MC_RefererName where MC_CardID=@MC_CardID
go

--得到单个会员信息
if exists(select * from sys.sysobjects where name ='P_GetSingleMemCard')
	drop proc P_GetSingleMemCard
go
create proc P_GetSingleMemCard
	@MC_CardID int
as
	select * from MemCards where MC_CardID=@MC_CardID
go

--挂失/锁定
if exists(select * from sys.sysobjects where name ='P_UpdateState')
	drop proc P_UpdateState
go
create proc P_UpdateState
	@MC_CardID int,
	@MC_State int
	
as
	update MemCards set MC_State=@MC_State where MC_CardID=@MC_CardID
go

--TL_ID, S_ID, U_ID, TL_FromMC_ID, TL_FromMC_CardID, TL_ToMC_ID, TL_ToMC_CardID, TL_TransferMoney, TL_Remark, TL_CreateTime
--select * from TransferLogs
--select * from MemCards
--添加转账记录
if exists(select * from sys.sysobjects where name ='P_InsertTransferLogs')
	drop proc P_InsertTransferLogs
go
create proc P_InsertTransferLogs
	@S_ID int,
	@U_ID int,
	@TL_FromMC_ID int,
	@TL_FromMC_CardID nvarchar(50),
	@TL_ToMC_ID int,
	@TL_ToMC_CardID nvarchar(50),
	@TL_TransferMoney money,
	@TL_Remark varchar(200),
	@TL_CreateTime datetime
	
	
as
	insert into TransferLogs values(@S_ID,@U_ID,@TL_FromMC_ID,@TL_FromMC_CardID,@TL_ToMC_ID,@TL_ToMC_CardID,@TL_TransferMoney,@TL_Remark,@TL_CreateTime)
	update MemCards set MC_Point=MC_Point-@TL_TransferMoney where MC_CardID=@TL_FromMC_CardID
	update MemCards set MC_Point=MC_Point+@TL_TransferMoney where MC_CardID=@TL_ToMC_CardID

go

--换卡
if exists(select * from sys.sysobjects where name ='P_NewCard')
	drop proc P_NewCard
go
create proc P_NewCard
	@MC_ID int,
	@MC_CardID int,
	@MC_Password  nvarchar(20)
as
	update MemCards set MC_CardID=@MC_CardID,MC_Password=@MC_Password where MC_ID=@MC_ID
go


--查询会员卡密码
if exists(select * from sys.sysobjects where name ='P_SearchPwd')
	drop proc P_SearchPwd
go
create proc P_SearchPwd
	@MC_Name nvarchar(20)
as
	select MC_Password from MemCards where MC_Name=@MC_Name
go

--根据手机号/会员卡号查询
--select * from MemCards where MC_CardID=800014 or MC_Mobile=''
if exists(select * from sys.sysobjects where name ='P_SearchByCardIDOrTel')
	drop proc P_SearchByCardIDOrTel
go
create proc P_SearchByCardIDOrTel
	@MC_CardIDTel int
as
	select m.*,c.CL_LevelName,c.CL_Percent,c.CL_Point,c.CL_NeedPoint from MemCards m inner join CardLevels c on m.CL_ID = c.CL_ID where MC_CardID=@MC_CardIDTel or MC_Mobile=cast(@MC_CardIDTel as varchar)
go

--CO_ID, S_ID, U_ID, CO_OrderCode, CO_OrderType, MC_ID, MC_CardID, EG_ID, CO_TotalMoney, CO_DiscountMoney, CO_GavePoint, CO_Recash, CO_Remark, CO_CreateTime
--快速消费
if exists(select * from sys.sysobjects where name ='P_FastConsume')
	drop proc P_FastConsume
go
create proc P_FastConsume
	@S_ID int,
	@U_ID int,
	@CO_OrderCode nvarchar(20),
	@CO_OrderType int,
	@MC_ID int,
	@MC_CardID nvarchar(50),
	@CO_TotalMoney float, 
	@CO_DiscountMoney float,
	@CO_GavePoint int,
	@CO_CreateTime datetime,
	@MC_Point int,
	@MC_TotalCount int
as
	insert into ConsumeOrders(S_ID,U_ID,CO_OrderCode,CO_OrderType,MC_ID,MC_CardID,CO_TotalMoney,CO_DiscountMoney,CO_GavePoint,CO_CreateTime) values(@S_ID,@U_ID,@CO_OrderCode,@CO_OrderType,@MC_ID,@MC_CardID,@CO_TotalMoney,@CO_DiscountMoney,@CO_GavePoint,@CO_CreateTime)
	update MemCards set MC_TotalMoney=@CO_TotalMoney,MC_TotalCount=@MC_TotalCount,MC_Point=@MC_Point where MC_CardID=@MC_CardID
	
go

--减积分
if exists(select * from sys.sysobjects where name ='P_JianPoint')
	drop proc P_JianPoint
go
create proc P_JianPoint
	@S_ID int,
	@U_ID int,
	@CO_OrderCode nvarchar(20),
	@CO_OrderType int,
	@MC_ID int,
	@MC_CardID nvarchar(50),
	@CO_GavePoint int,
	@CO_CreateTime datetime,
	@CO_Remark nvarchar(255),
	@MC_Point int
	
as
	insert into ConsumeOrders(S_ID,U_ID,CO_OrderCode,CO_OrderType,MC_ID,MC_CardID,CO_GavePoint,CO_Remark,CO_CreateTime) values(@S_ID,@U_ID,@CO_OrderCode,@CO_OrderType,@MC_ID,@MC_CardID,@CO_GavePoint,@CO_Remark,@CO_CreateTime)
	update MemCards set MC_Point=@MC_Point where MC_CardID=@MC_CardID
	
go

--创建查看消费记录的视图
if exists(select * from sys.sysobjects where name ='VW_ConsumeOrders')
	drop view VW_ConsumeOrders
go
create view VW_ConsumeOrders
as
	select c.*,m.MC_Name,m.MC_Mobile,m.MC_TotalMoney from ConsumeOrders c,MemCards m where c.MC_ID=m.MC_ID
go


--根据条件给消费记录进行分页
if exists(select * from sys.sysobjects where name='GetPageConsumeOrdersByCondition')
	Drop proc GetPageConsumeOrdersByCondition
go
create proc GetPageConsumeOrdersByCondition
	@PageSize int,
	@CurrentByIndex int,
	@RecordCount int output,
	@MC_CardTel nvarchar(50)
as
	declare @sql nvarchar(2000),@sql1 nvarchar(1000),@condition nvarchar(1000)=''
	if @MC_CardTel !=''
	begin
		set @condition+=' and MC_CardID='''+@MC_CardTel+''' or MC_Mobile='''+@MC_CardTel+''''
		--set @condition+=' and MC_CardID='+cast(@MC_CardTel as varchar)+''
	end
	set  @sql='select top '+cast(@PageSize as varchar)+' * from VW_ConsumeOrders where 1=1 '+@condition+' and CO_ID not in (select top '+cast(@PageSize*(@CurrentByIndex-1) as varchar)+' CO_ID from VW_ConsumeOrders where 1=1 '+@condition+' order by CO_ID asc) order by CO_ID asc'
	set  @sql1='select @RC=count(*) from VW_ConsumeOrders where 1=1 '+@condition+''
	
	exec sp_executesql @sql
	exec sp_executesql @sql1,N'@RC int output',@RecordCount output
go
--declare @a int
--exec GetPageConsumeOrdersByCondition 4,1,@a output,'800000'
--select @a


--EL_ID, S_ID, U_ID, MC_ID, MC_CardID, MC_Name, EG_ID, EG_GiftCode, EG_GiftName, EL_Number, EL_Point, EL_CreateTime
--积分兑换
if exists(select * from sys.sysobjects where name='P_PointExchange')
	drop proc P_PointExchange
go
create proc P_PointExchange
	@S_ID int,
	@U_ID int,
	@MC_ID int,
	@MC_CardID nvarchar(50),
	@MC_Name nvarchar(20),
	@EG_ID int,
	@EG_GiftCode nvarchar(50),
	@EG_GiftName nvarchar(50),
	@EL_Number int,
	@EL_Point int,
	@EL_CreateTime datetime,
	@MC_Point int,
	@EG_Number int,
    @EG_ExchangNum int
as
	insert into ExchangLogs values(@S_ID,@U_ID,@MC_ID,@MC_CardID,@MC_Name,@EG_ID,@EG_GiftCode,@EG_GiftName,@EL_Number,@EL_Point,@EL_CreateTime)
	update MemCards set MC_Point=@MC_Point where MC_CardID=@MC_CardID
	update ExchangGifts set EG_ExchangNum=@EG_ExchangNum,EG_Number=@EG_Number where EG_ID=@EG_ID
go

--select * from ConsumeOrders
--select * from CardLevels
--select * from CategoryItems

--积分返现
if exists(select * from sys.sysobjects where name ='P_PointCash')
	drop proc P_PointCash
go
create proc P_PointCash
	@S_ID int,
	@U_ID int,
	@CO_OrderCode nvarchar(20),
	@CO_OrderType int,
	@MC_ID int,
	@MC_CardID nvarchar(50),
	@CO_GavePoint int,
	@CO_CreateTime datetime,
	@CO_Recash nvarchar(255),
	@MC_Point int
	
as
	insert into ConsumeOrders(S_ID,U_ID,CO_OrderCode,CO_OrderType,MC_ID,MC_CardID,CO_GavePoint,CO_Recash,CO_CreateTime) values(@S_ID,@U_ID,@CO_OrderCode,@CO_OrderType,@MC_ID,@MC_CardID,@CO_GavePoint,@CO_Recash,@CO_CreateTime)
	update MemCards set MC_Point=@MC_Point where MC_CardID=@MC_CardID
	
go


--创建查看兑换记录的视图
if exists(select * from sys.sysobjects where name ='VW_ExchangLogs')
	drop view VW_ExchangLogs
go
create view VW_ExchangLogs
as
	select el.*,eg.EG_Point,m.MC_Mobile from ExchangLogs el,ExchangGifts eg,MemCards m where el.EG_ID=eg.EG_ID and el.MC_ID=m.MC_ID
	
go
--根据条件给兑换记录进行分页
if exists(select * from sys.sysobjects where name='GetPageExchangLogsByCondition')
	Drop proc GetPageExchangLogsByCondition
go
create proc GetPageExchangLogsByCondition
	@PageSize int,
	@CurrentByIndex int,
	@RecordCount int output,
	@MC_CardTel nvarchar(50)
as
	declare @sql nvarchar(2000),@sql1 nvarchar(1000),@condition nvarchar(1000)=''
	if @MC_CardTel !=''
	begin
		set @condition+=' and MC_CardID='''+@MC_CardTel+''' or MC_Mobile='''+@MC_CardTel+''''
	end
	set  @sql='select top '+cast(@PageSize as varchar)+' * from VW_ExchangLogs where 1=1 '+@condition+' and EL_ID not in (select top '+cast(@PageSize*(@CurrentByIndex-1) as varchar)+' EL_ID from VW_ExchangLogs where 1=1 '+@condition+' order by EL_ID asc) order by EL_ID asc'
	set  @sql1='select @RC=count(*) from VW_ExchangLogs where 1=1 '+@condition+''
	
	exec sp_executesql @sql
	exec sp_executesql @sql1,N'@RC int output',@RecordCount output
go

declare  @aa int
exec GetPageExchangLogsByCondition 4,1,@aa output,'800016'
select @aa


--select * from ConsumeOrders
--select * from MemCards
--select * from ExchangLogs

--修改个人资料U_ID, S_ID, U_LoginName, U_Password, U_RealName, U_Sex, U_Telephone, U_Role, U_CanDelete
if exists(select * from sys .sysobjects where name = 'P_UpdatePersonalInfo')
	drop proc P_UpdatePersonalInfo
go
create proc P_UpdatePersonalInfo
	@U_ID int,
	@U_LoginName nvarchar(20),
	@U_RealName nvarchar(20),
	@U_Sex nvarchar(10),
	@U_Telephone nvarchar(20)
as
	update Users set U_LoginName=@U_LoginName,U_RealName=@U_RealName,U_Sex=@U_Sex,U_Telephone=@U_Telephone where U_ID=@U_ID
go
--查看用户密码
if exists(select * from sys.sysobjects where name ='P_SearchUserPwd')
	drop proc P_SearchUserPwd
go
create proc P_SearchUserPwd
	@U_ID int
as
	select U_Password from Users where U_ID=@U_ID
go
--修改个人密码
if exists(select * from sys.sysobjects where name ='P_UpdatePersonalPwd')
	drop proc P_UpdatePersonalPwd
go
create proc P_UpdatePersonalPwd
	@U_ID int,
	@U_Password nvarchar(50)
as
	update Users set U_Password=@U_Password where U_ID=@U_ID
go

--select * from MemCards
--update Users set U_Password=1 where U_ID=1

--创建查看减积分统计视图
if exists(select * from sys.sysobjects where name='VW_JianPoint')
	drop view VW_JianPoint
go
create view VW_JianPoint
as
	select c.*,m.MC_Name,m.MC_Mobile,m.CL_ID from ConsumeOrders c inner join MemCards m on c.MC_ID=m.MC_ID where CO_OrderType=3
go
--------------------------------------------------减积分统计存储过程-----------------------------------------------
if exists(select * from sys.objects where name ='P_GetPageSubintPointByCondition')
 drop proc P_GetPageSubintPointByCondition
 go
create proc P_GetPageSubintPointByCondition
	@pageSize int,
	@CurrentIndexCount int,
	@RecordCount int output,
	@beginTime datetime,
	@endTime datetime,
	@fuhao varchar(10),
	@CO_GavePoint varchar(50),
	@MC_CardTel varchar(50),
	@CL_ID int,
	@CO_OrderCode nvarchar(20)
as

declare @sql nvarchar(max),@sql1 nvarchar(max),@condition varchar(500)=''
      if @beginTime !=''
		 begin
			set @condition =@condition+ ' and CO_CreateTime >='''+cast(@beginTime as varchar)+''''
		 end
      if @endTime !=''
		begin
			set @condition =@condition+' and  CO_CreateTime <= '''+cast(@endTime as varchar)+''''
		 end
	   if @CO_GavePoint!=''
		begin
			set @condition =@condition+' and CO_GavePoint '+@fuhao+''''+@CO_GavePoint+''''
		end
     if @MC_CardTel !=''
		begin
			set @condition+=' and MC_CardID='''+@MC_CardTel+''' or MC_Mobile='''+@MC_CardTel+''''
        end
	 if @CL_ID!=0
		begin
	       set @condition =@condition+' and CL_ID= '+cast (@CL_ID as varchar)+''
		end
	 if @CO_OrderCode!=''
		begin
			set @condition =@condition+' and  CO_OrderCode= '''+@CO_OrderCode+''''
		end
	 set @sql='select top '+cast(@pageSize as varchar)+' * from VW_JianPoint where 1=1 '+@condition+' and CO_ID not in(select top '+cast(@pageSize*(@CurrentIndexCount-1) as varchar)+' CO_ID from VW_JianPoint where 1=1 '+@condition+' order by CO_ID asc) order by CO_ID asc'
	 set @sql1='select @Rc=Count(*) from VW_JianPoint where 1=1  '+@condition+''
	 print @sql
	 print @sql1
	 exec sp_executesql @sql
	 exec sp_executesql @sql1, N'@Rc int out',@RecordCount output
	 
go
--declare @aa int 
--exec P_GetPageSubintPointByCondition 10,1,@aa output,'2016-9-9','2016-12-30','','','800014',0,''
--select @aa
--select * from CategoryItems

--创建查看快速消费统计视图
if exists(select * from sys.sysobjects where name='VW_FastComsumeSum')
	drop view VW_FastComsumeSum
go
create view VW_FastComsumeSum
as
	select c.*,m.MC_Name,m.MC_Mobile,m.CL_ID from ConsumeOrders c inner join MemCards m on c.MC_ID=m.MC_ID where CO_OrderType=5
go
--------------------------------------------------快速消费统计存储过程-----------------------------------------------
if exists(select * from sys.objects where name ='P_GetPageFastComsumeSumByCondition')
 drop proc P_GetPageFastComsumeSumByCondition
 go
create proc P_GetPageFastComsumeSumByCondition
	@pageSize int,
	@CurrentIndexCount int,
	@RecordCount int output,
	@beginTime datetime,
	@endTime datetime,
	@fuhao varchar(10),
	@CO_GavePoint varchar(50),
	@MC_CardTel varchar(50),
	@CL_ID int,
	@CO_OrderCode nvarchar(20)
as

declare @sql nvarchar(max),@sql1 nvarchar(max),@condition varchar(500)=''
      if @beginTime !=''
		 begin
			set @condition =@condition+ ' and CO_CreateTime >='''+cast(@beginTime as varchar)+''''
		 end
      if @endTime !=''
		begin
			set @condition =@condition+' and  CO_CreateTime <= '''+cast(@endTime as varchar)+''''
		 end
	   if @CO_GavePoint!=''
		begin
			set @condition =@condition+' and CO_DiscountMoney '+@fuhao+''''+@CO_GavePoint+''''
		end
     if @MC_CardTel !=''
		begin
			set @condition+=' and MC_CardID='''+@MC_CardTel+''' or MC_Mobile='''+@MC_CardTel+''''
        end
	 if @CL_ID!=0
		begin
	       set @condition =@condition+' and CL_ID= '+cast (@CL_ID as varchar)+''
		end
	 if @CO_OrderCode!=''
		begin
			set @condition =@condition+' and  CO_OrderCode= '''+@CO_OrderCode+''''
		end
	 set @sql='select top '+cast(@pageSize as varchar)+' * from VW_FastComsumeSum where 1=1 '+@condition+' and CO_ID not in(select top '+cast(@pageSize*(@CurrentIndexCount-1) as varchar)+' CO_ID from VW_FastComsumeSum where 1=1 '+@condition+' order by CO_ID asc) order by CO_ID asc'
	 set @sql1='select @Rc=Count(*) from VW_FastComsumeSum where 1=1  '+@condition+''
	 print @sql
	 print @sql1
	 exec sp_executesql @sql
	 exec sp_executesql @sql1, N'@Rc int out',@RecordCount output
	 
go

--declare @aa int 
--exec P_GetPageFastComsumeSumByCondition 10,1,@aa output,'2016-9-9','2016-12-30','','','800014',0,''
--select @aa 

--创建查看积分返现统计视图
if exists(select * from sys.sysobjects where name='VW_PointReCashSum')
	drop view VW_PointReCashSum
go
create view VW_PointReCashSum
as
	select c.*,m.MC_Name,m.MC_Mobile,m.CL_ID from ConsumeOrders c inner join MemCards m on c.MC_ID=m.MC_ID where CO_OrderType=2
go
--------------------------------------------------积分返现统计存储过程-----------------------------------------------
if exists(select * from sys.objects where name ='P_GetPagePointReCashSumByCondition')
 drop proc P_GetPagePointReCashSumByCondition
 go
create proc P_GetPagePointReCashSumByCondition
	@pageSize int,
	@CurrentIndexCount int,
	@RecordCount int output,
	@beginTime datetime,
	@endTime datetime,
	@fuhao varchar(10),
	@CO_GavePoint varchar(50),
	@MC_CardTel varchar(50),
	@CL_ID int,
	@CO_OrderCode nvarchar(20)
as

declare @sql nvarchar(max),@sql1 nvarchar(max),@condition varchar(500)=''
      if @beginTime !=''
		 begin
			set @condition =@condition+ ' and CO_CreateTime >='''+cast(@beginTime as varchar)+''''
		 end
      if @endTime !=''
		begin
			set @condition =@condition+' and  CO_CreateTime <= '''+cast(@endTime as varchar)+''''
		 end
	   if @CO_GavePoint!=''
		begin
			set @condition =@condition+' and CO_GavePoint '+@fuhao+''''+@CO_GavePoint+''''
		end
     if @MC_CardTel !=''
		begin
			set @condition+=' and MC_CardID='''+@MC_CardTel+''' or MC_Mobile='''+@MC_CardTel+''''
        end
	 if @CL_ID!=0
		begin
	       set @condition =@condition+' and CL_ID= '+cast (@CL_ID as varchar)+''
		end
	 if @CO_OrderCode!=''
		begin
			set @condition =@condition+' and  CO_OrderCode= '''+@CO_OrderCode+''''
		end
	 set @sql='select top '+cast(@pageSize as varchar)+' * from VW_PointReCashSum where 1=1 '+@condition+' and CO_ID not in(select top '+cast(@pageSize*(@CurrentIndexCount-1) as varchar)+' CO_ID from VW_PointReCashSum where 1=1 '+@condition+' order by CO_ID asc) order by CO_ID asc'
	 set @sql1='select @Rc=Count(*) from VW_PointReCashSum where 1=1  '+@condition+''
	 print @sql
	 print @sql1
	 exec sp_executesql @sql
	 exec sp_executesql @sql1, N'@Rc int out',@RecordCount output
	 
go

declare @aa int 
exec P_GetPagePointReCashSumByCondition 10,1,@aa output,'2016-9-9','2016-12-30','','','800014',0,''
select @aa 
--CO_ID, S_ID, U_ID, CO_OrderCode, CO_OrderType, MC_ID, MC_CardID, EG_ID, CO_TotalMoney, CO_DiscountMoney, CO_GavePoint, CO_Recash, CO_Remark, CO_CreateTime

--------------------------------------------------礼品兑换统计存储过程-----------------------------------------------
if exists(select * from sys.sysobjects where name='P_GetPageExchangLogsSumByCondition')
	Drop proc P_GetPageExchangLogsSumByCondition
go
create proc P_GetPageExchangLogsSumByCondition
	@PageSize int,
	@CurrentIndexCount int,
	@RecordCount int output,
	@beginTime datetime,
	@endTime datetime,
	@MC_CardTel nvarchar(50)
as
	declare @sql nvarchar(2000),@sql1 nvarchar(1000),@condition nvarchar(1000)=''
	 if @beginTime !=''
		 begin
			set @condition =@condition+ ' and EL_CreateTime >='''+cast(@beginTime as varchar)+''''
		 end
      if @endTime !=''
		begin
			set @condition =@condition+' and  EL_CreateTime <= '''+cast(@endTime as varchar)+''''
		 end
	if @MC_CardTel !=''
	begin
		set @condition+=' and MC_CardID='''+@MC_CardTel+''' or MC_Mobile='''+@MC_CardTel+''''
	end
	set  @sql='select top '+cast(@PageSize as varchar)+' * from VW_ExchangLogs where 1=1 '+@condition+' and EL_ID not in (select top '+cast(@PageSize*(@CurrentIndexCount-1) as varchar)+' EL_ID from VW_ExchangLogs where 1=1 '+@condition+' order by EL_ID asc) order by EL_ID asc'
	set  @sql1='select @RC=count(*) from VW_ExchangLogs where 1=1 '+@condition+''
	
	exec sp_executesql @sql
	exec sp_executesql @sql1,N'@RC int output',@RecordCount output
go
--declare @aa int 
--exec P_GetPageExchangLogsSumByCondition 10,1,@aa output,'','',''
--select @aa 

----------------------------------根据店铺编号查找会员存储过程----------------------------------------------
if exists(select * from sys.sysobjects where name='P_SearchMenCardByS_ID')
	drop proc P_SearchMenCardByS_ID
go
create proc P_SearchMenCardByS_ID
	@PageSize int,
	@CurrentIndexCount int,
	@RecordCount int output,
	@S_ID int
as
    declare @sql nvarchar(2000),@sql1 nvarchar(1000),@condition nvarchar(1000)=''
	set  @sql='select top '+cast(@PageSize as varchar)+' * from MemCards where 1=1 and S_ID= '+cast(@S_ID as varchar)+' and MC_ID not in (select top '+cast(@PageSize*(@CurrentIndexCount-1) as varchar)+' MC_ID from MemCards where 1=1 and S_ID='+cast(@S_ID as varchar)+' order by MC_ID asc) order by MC_ID asc'
	set  @sql1='select @RC=count(*) from MemCards where 1=1 and S_ID= '+cast(@S_ID as varchar)+' '
	
	exec sp_executesql @sql
	exec sp_executesql @sql1,N'@RC int output',@RecordCount output
go
--declare @aa int 
--exec P_SearchMenCardByS_ID 1,1,@aa output,2
--select @aa 
----------------------------------消费统计存储过程----------------------------------------------
if exists(select * from sys.sysobjects where name='P_GetPageConsumeOrdersSumByCondition')
	Drop proc P_GetPageConsumeOrdersSumByCondition
go
create proc P_GetPageConsumeOrdersSumByCondition
	@PageSize int,
	@CurrentByIndex int,
	@RecordCount int output,
	@beginTime datetime,
	@endTime datetime,
	@MC_CardTel nvarchar(50),
	@Type int
as
	declare @sql nvarchar(2000),@sql1 nvarchar(1000),@condition nvarchar(1000)=''
	 if @beginTime !=''
		 begin
			set @condition =@condition+ ' and CO_CreateTime >='''+cast(@beginTime as varchar)+''''
		 end
     if @endTime !=''
		begin
			set @condition =@condition+' and  CO_CreateTime <= '''+cast(@endTime as varchar)+''''
		 end
	 if @MC_CardTel !=''
		begin
			set @condition+=' and MC_CardID='''+@MC_CardTel+''' or MC_Mobile='''+@MC_CardTel+''''
		
		end
	 if @Type!=0
		begin
		set @condition+=' and CO_OrderType='+cast(@Type as varchar)+''
		end
	set  @sql='select top '+cast(@PageSize as varchar)+' * from VW_ConsumeOrders where 1=1 '+@condition+' and CO_ID not in (select top '+cast(@PageSize*(@CurrentByIndex-1) as varchar)+' CO_ID from VW_ConsumeOrders where 1=1 '+@condition+' order by CO_ID asc) order by CO_ID asc'
	set  @sql1='select @RC=count(*) from VW_ConsumeOrders where 1=1 '+@condition+''
	
	exec sp_executesql @sql
	exec sp_executesql @sql1,N'@RC int output',@RecordCount output
go

declare @aa int 
exec P_GetPageConsumeOrdersSumByCondition 50,1,@aa output,'2016/9/9','2016/12/29','',5
select @aa 

