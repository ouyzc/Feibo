USE [ZM_Dev]
GO
/****** Object:  Table [dbo].[Log_Tools]    Script Date: 04/28/2019 05:22:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Log_Tools](
	[pk_id] [int] IDENTITY(1,1) NOT NULL,
	[cType] [varchar](50) NULL,
	[cMethod] [varchar](max) NULL,
	[errcode] [int] NULL,
	[errmsg] [nvarchar](max) NULL,
	[dCreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Log_Tools] PRIMARY KEY CLUSTERED 
(
	[pk_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Log_Api]    Script Date: 04/28/2019 05:22:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Log_Api](
	[pk_id] [int] IDENTITY(1,1) NOT NULL,
	[ip] [varchar](50) NULL,
	[cIdentity] [varchar](255) NULL,
	[cType] [varchar](50) NULL,
	[cMethod] [varchar](max) NULL,
	[errcode] [int] NULL,
	[errmsg] [nvarchar](max) NULL,
	[cParams] [nvarchar](max) NULL,
	[dCreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Log_Api] PRIMARY KEY CLUSTERED 
(
	[pk_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AA_Customer]    Script Date: 04/28/2019 05:22:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AA_Customer](
	[customerCode] [nvarchar](20) NOT NULL,
	[customerName] [nvarchar](98) NULL,
	[address] [nvarchar](255) NULL,
	[contactor] [nvarchar](50) NULL,
	[phone] [nvarchar](100) NULL,
	[description] [nvarchar](255) NOT NULL,
	[en] [varchar](1) NOT NULL,
	[zh] [nvarchar](255) NULL,
	[ts] [bigint] NULL,
	[iStatus] [int] NOT NULL,
	[bFlag] [bit] NOT NULL,
	[bDel] [bit] NOT NULL,
	[errcode] [varchar](50) NULL,
	[errmsg] [nvarchar](max) NULL,
	[dCreateTime] [datetime] NOT NULL,
	[dUpdateTime] [datetime] NULL,
	[dPostTime] [datetime] NULL,
	[cMemo] [nvarchar](max) NULL,
	[define1] [int] NULL,
	[define2] [varchar](max) NULL,
	[define3] [nvarchar](max) NULL,
 CONSTRAINT [PK_AA_Customer] PRIMARY KEY CLUSTERED 
(
	[customerCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[p_zzp_load_AA_Customer]    Script Date: 04/28/2019 05:22:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--增量
CREATE PROCEDURE [dbo].[p_zzp_load_AA_Customer]
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    INSERT INTO ZM_Dev..AA_Customer ([customerCode] ,
                                     [customerName] ,
                                     [address] ,
                                     [contactor] ,
                                     [phone] ,
                                     [description] ,
                                     [en] ,
                                     [zh] ,
                                     [ts])
    --计量单位
    --客户档案
    SELECT      cus.cCusCode customerCode , --客户编码 Y
                cus.cCusName customerName , --客户名称 Y
                cus.cCusAddress address , --地址 
                cus.cCusPerson contactor , --联系人 
                cus.cCusPhone phone , --联系电话 
                '' description , --描述 
                '' en , --英文描述 
                cus.cCusName zh , --中文描述 
                CAST(cus.pubufts AS BIGINT) ts
    FROM        UFDATA_999_2019..Customer cus
    LEFT JOIN   ZM_Dev..AA_Customer acus ON acus.customerCode = cus.cCusCode
    WHERE       acus.customerCode IS NULL ;
END ;
GO
/****** Object:  Table [dbo].[AA_ComputationUnit]    Script Date: 04/28/2019 05:22:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AA_ComputationUnit](
	[unitName] [nvarchar](50) NOT NULL,
	[rate] [decimal](28, 6) NOT NULL,
	[en] [varchar](100) NOT NULL,
	[zh] [nvarchar](50) NOT NULL,
	[ts] [bigint] NULL,
	[iStatus] [int] NOT NULL,
	[bFlag] [bit] NOT NULL,
	[bDel] [bit] NOT NULL,
	[errcode] [varchar](50) NULL,
	[errmsg] [nvarchar](max) NULL,
	[dCreateTime] [datetime] NOT NULL,
	[dUpdateTime] [datetime] NULL,
	[dPostTime] [datetime] NULL,
	[cMemo] [nvarchar](max) NULL,
	[define1] [int] NULL,
	[define2] [varchar](max) NULL,
	[define3] [nvarchar](max) NULL,
 CONSTRAINT [PK_AA_ComputationUnit_1] PRIMARY KEY CLUSTERED 
(
	[unitName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[p_zzp_load_AA_ComputationUnit]    Script Date: 04/28/2019 05:22:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--增量
CREATE PROCEDURE [dbo].[p_zzp_load_AA_ComputationUnit]
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    INSERT INTO ZM_Dev..AA_ComputationUnit (unitName, rate, en, zh, ts)
    --计量单位
    SELECT      cu.cComunitCode unitName , --单位名称 Y
                ISNULL(cu.iChangRate, 0) rate , --比率 
                '' en , --英文描述 
                cu.cComUnitName zh , --中文描述
                CAST(cu.pubufts AS BIGINT) ts
    FROM        UFDATA_999_2019..ComputationUnit cu
    LEFT JOIN   ZM_Dev..AA_ComputationUnit acu ON acu.unitName = cu.cComunitCode
    WHERE       acu.unitName IS NULL ;
END ;
GO
/****** Object:  View [dbo].[v_zzp_Get_AA_Customer]    Script Date: 04/28/2019 05:22:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--增量查询
CREATE VIEW [dbo].[v_zzp_Get_AA_Customer]
--WITH ENCRYPTION, SCHEMABINDING, VIEW_METADATA
AS
SELECT  [customerCode] ,
        [customerName] ,
        [address] ,
        [contactor] ,
        [phone] ,
        [description] ,
        [en] ,
        [zh] ,
        [ts]
FROM    ZM_Dev..AA_Customer
WHERE   iStatus = 0 ;
-- WITH CHECK OPTION
GO
/****** Object:  View [dbo].[v_zzp_Get_AA_ComputationUnit]    Script Date: 04/28/2019 05:22:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--增量查询
CREATE VIEW [dbo].[v_zzp_Get_AA_ComputationUnit]
--WITH ENCRYPTION, SCHEMABINDING, VIEW_METADATA
AS
SELECT  unitName ,
        rate ,
        en ,
        zh ,
        ts
FROM    ZM_Dev..AA_ComputationUnit
WHERE   iStatus = 0 ;
-- WITH CHECK OPTION
GO
/****** Object:  StoredProcedure [dbo].[p_zzp_log_tools]    Script Date: 04/28/2019 05:22:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--写日志_Tools
CREATE PROCEDURE [dbo].[p_zzp_log_tools]
    @cType AS   VARCHAR(50) ,
    @cMethod AS VARCHAR(MAX) ,
    @errcode AS INT ,
    @errmsg AS  NVARCHAR(MAX)
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    INSERT INTO dbo.Log_Tools (cType, cMethod, errcode, errmsg)
    VALUES (@cType , -- cType - varchar(50)
            @cMethod , -- cMethod - varchar(max)
            @errcode , -- errcode - int
            @errmsg -- errmsg - nvarchar(max) 
        ) ;
END ;
GO
/****** Object:  StoredProcedure [dbo].[p_zzp_log_api]    Script Date: 04/28/2019 05:22:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--写日志_api
CREATE PROCEDURE [dbo].[p_zzp_log_api]
    @ip        VARCHAR(50) ,
    @cIdentity VARCHAR(255) ,
    @cType     VARCHAR(50) ,
    @cMethod   VARCHAR(MAX) ,
    @errcode   INT ,
    @errmsg    NVARCHAR(MAX) ,
    @cParams   NVARCHAR(MAX)
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    INSERT INTO dbo.Log_Api (ip, cIdentity, cType, cMethod, errcode, errmsg, cParams)
    VALUES (@ip , -- ip - varchar(50)
            @cIdentity , -- cIdentity - varchar(255)
            @cType , -- cType - varchar(50)
            @cMethod , -- cMethod - varchar(max)
            @errcode , -- errcode - int
            @errmsg , -- errmsg - nvarchar(max)
            @cParams -- cParams - nvarchar(max) 
        ) ;
END ;
GO
/****** Object:  Default [DF_AA_ComputationUnit_istatus]    Script Date: 04/28/2019 05:22:26 ******/
ALTER TABLE [dbo].[AA_ComputationUnit] ADD  CONSTRAINT [DF_AA_ComputationUnit_istatus]  DEFAULT ((0)) FOR [iStatus]
GO
/****** Object:  Default [DF_AA_ComputationUnit_bflag]    Script Date: 04/28/2019 05:22:26 ******/
ALTER TABLE [dbo].[AA_ComputationUnit] ADD  CONSTRAINT [DF_AA_ComputationUnit_bflag]  DEFAULT ((0)) FOR [bFlag]
GO
/****** Object:  Default [DF_AA_ComputationUnit_bDel]    Script Date: 04/28/2019 05:22:26 ******/
ALTER TABLE [dbo].[AA_ComputationUnit] ADD  CONSTRAINT [DF_AA_ComputationUnit_bDel]  DEFAULT ((0)) FOR [bDel]
GO
/****** Object:  Default [DF_AA_ComputationUnit_dCreateTime]    Script Date: 04/28/2019 05:22:26 ******/
ALTER TABLE [dbo].[AA_ComputationUnit] ADD  CONSTRAINT [DF_AA_ComputationUnit_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_AA_Customer_iStatus]    Script Date: 04/28/2019 05:22:26 ******/
ALTER TABLE [dbo].[AA_Customer] ADD  CONSTRAINT [DF_AA_Customer_iStatus]  DEFAULT ((0)) FOR [iStatus]
GO
/****** Object:  Default [DF_AA_Customer_bFlag]    Script Date: 04/28/2019 05:22:26 ******/
ALTER TABLE [dbo].[AA_Customer] ADD  CONSTRAINT [DF_AA_Customer_bFlag]  DEFAULT ((0)) FOR [bFlag]
GO
/****** Object:  Default [DF_AA_Customer_bDel]    Script Date: 04/28/2019 05:22:26 ******/
ALTER TABLE [dbo].[AA_Customer] ADD  CONSTRAINT [DF_AA_Customer_bDel]  DEFAULT ((0)) FOR [bDel]
GO
/****** Object:  Default [DF_AA_Customer_dCreateTime]    Script Date: 04/28/2019 05:22:26 ******/
ALTER TABLE [dbo].[AA_Customer] ADD  CONSTRAINT [DF_AA_Customer_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_Log_Api_dCreateTime]    Script Date: 04/28/2019 05:22:26 ******/
ALTER TABLE [dbo].[Log_Api] ADD  CONSTRAINT [DF_Log_Api_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_Log_Tools_dCreateTime]    Script Date: 04/28/2019 05:22:26 ******/
ALTER TABLE [dbo].[Log_Tools] ADD  CONSTRAINT [DF_Log_Tools_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
