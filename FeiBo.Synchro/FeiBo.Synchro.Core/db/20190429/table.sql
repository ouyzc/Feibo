USE [ZM_Dev]
GO
/****** Object:  Table [dbo].[PP_workOrderRequirement]    Script Date: 04/28/2019 23:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PP_workOrderRequirement](
	[pk_id] [int] IDENTITY(1,1) NOT NULL,
	[MoId] [int] NOT NULL,
	[MoDId] [int] NULL,
	[opCode] [varchar](255) NULL,
	[location] [varchar](255) NULL,
	[component] [varchar](255) NULL,
	[keyPartsFlag] [varchar](50) NULL,
	[trackerFlag] [varchar](50) NULL,
	[inputFlag] [varchar](50) NULL,
	[validateTimes] [varchar](50) NULL,
	[usage] [varchar](50) NULL,
	[ts] [bigint] NULL,
	[iStatus] [int] NOT NULL,
	[bFlag] [bit] NOT NULL,
	[errcode] [varchar](50) NULL,
	[errmsg] [nvarchar](max) NULL,
	[dCreateTime] [datetime] NOT NULL,
	[dUpdateTime] [datetime] NULL,
	[dPostTime] [datetime] NULL,
	[cMemo] [nvarchar](max) NULL,
	[define1] [int] NULL,
	[define2] [varchar](max) NULL,
	[define3] [nvarchar](max) NULL,
 CONSTRAINT [PK_PP_workOrderRequirement] PRIMARY KEY CLUSTERED 
(
	[pk_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PP_workOrder_SNS]    Script Date: 04/28/2019 23:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PP_workOrder_SNS](
	[pk_id] [int] IDENTITY(1,1) NOT NULL,
	[MoId] [int] NOT NULL,
	[MoDId] [int] NULL,
	[sn] [nvarchar](255) NULL,
	[virtualSN] [nvarchar](255) NULL,
	[ts] [bigint] NULL,
	[iStatus] [int] NOT NULL,
	[bFlag] [bit] NOT NULL,
	[errcode] [varchar](50) NULL,
	[errmsg] [nvarchar](max) NULL,
	[dCreateTime] [datetime] NOT NULL,
	[dUpdateTime] [datetime] NULL,
	[dPostTime] [datetime] NULL,
	[cMemo] [nvarchar](max) NULL,
	[define1] [int] NULL,
	[define2] [varchar](max) NULL,
	[define3] [nvarchar](max) NULL,
 CONSTRAINT [PK_PP_workOrder_SNS] PRIMARY KEY CLUSTERED 
(
	[pk_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PP_workOrder]    Script Date: 04/28/2019 23:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PP_workOrder](
	[MoId] [int] NOT NULL,
	[MoDId] [int] NULL,
	[salesOrder] [varchar](255) NULL,
	[workOrderName] [nvarchar](30) NULL,
	[linkWorkOrderName] [varchar](255) NULL,
	[workshopDepartment] [nvarchar](255) NULL,
	[materialItem] [varchar](255) NULL,
	[type] [varchar](255) NULL,
	[status] [varchar](255) NULL,
	[preWorkOrder] [varchar](255) NULL,
	[routing] [varchar](255) NULL,
	[description] [varchar](255) NULL,
	[bomRevision] [varchar](255) NULL,
	[routingRevision] [varchar](255) NULL,
	[quantity] [decimal](28, 6) NULL,
	[scheduleStartDate] [datetime] NULL,
	[dueDate] [datetime] NULL,
	[en] [varchar](255) NULL,
	[zh] [nvarchar](255) NULL,
	[ts] [bigint] NULL,
	[iStatus] [int] NOT NULL,
	[bFlag] [bit] NOT NULL,
	[errcode] [varchar](50) NULL,
	[errmsg] [nvarchar](max) NULL,
	[dCreateTime] [datetime] NOT NULL,
	[dUpdateTime] [datetime] NULL,
	[dPostTime] [datetime] NULL,
	[cMemo] [nvarchar](max) NULL,
	[define1] [int] NULL,
	[define2] [varchar](max) NULL,
	[define3] [nvarchar](max) NULL,
 CONSTRAINT [PK_PP_workOrder] PRIMARY KEY CLUSTERED 
(
	[MoId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Log_Tools]    Script Date: 04/28/2019 23:07:52 ******/
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
/****** Object:  Table [dbo].[Log_Del]    Script Date: 04/28/2019 23:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Log_Del](
	[pk_id] [int] IDENTITY(1,1) NOT NULL,
	[cTable] [varchar](100) NULL,
	[cUID] [nvarchar](100) NULL,
	[dDelTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Log_Del] PRIMARY KEY CLUSTERED 
(
	[pk_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Log_Api]    Script Date: 04/28/2019 23:07:52 ******/
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
/****** Object:  Table [dbo].[DL_DispatchList]    Script Date: 04/28/2019 23:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DL_DispatchList](
	[workOrderName] [nvarchar](30) NULL,
	[customerCode] [nvarchar](20) NULL,
	[sn] [varchar](255) NOT NULL,
	[virtualSN] [varchar](255) NULL,
	[deliveryTime] [datetime] NULL,
	[en] [varchar](255) NULL,
	[zh] [nvarchar](255) NULL,
	[ts] [bigint] NULL,
	[iStatus] [int] NOT NULL,
	[bFlag] [bit] NOT NULL,
	[errcode] [varchar](50) NULL,
	[errmsg] [nvarchar](max) NULL,
	[dCreateTime] [datetime] NOT NULL,
	[dUpdateTime] [datetime] NULL,
	[dPostTime] [datetime] NULL,
	[cMemo] [nvarchar](max) NULL,
	[define1] [int] NULL,
	[define2] [varchar](max) NULL,
	[define3] [nvarchar](max) NULL,
 CONSTRAINT [PK_DL_DispatchList] PRIMARY KEY CLUSTERED 
(
	[sn] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AA_Vendor]    Script Date: 04/28/2019 23:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AA_Vendor](
	[vendorCode] [nvarchar](20) NOT NULL,
	[verdorName] [nvarchar](255) NULL,
	[address] [nvarchar](255) NULL,
	[contactor] [nvarchar](50) NULL,
	[phone] [nvarchar](100) NULL,
	[description] [nvarchar](255) NULL,
	[en] [varchar](255) NULL,
	[zh] [nvarchar](255) NULL,
	[ts] [bigint] NULL,
	[iStatus] [int] NOT NULL,
	[bFlag] [bit] NOT NULL,
	[errcode] [varchar](50) NULL,
	[errmsg] [nvarchar](max) NULL,
	[dCreateTime] [datetime] NOT NULL,
	[dUpdateTime] [datetime] NULL,
	[dPostTime] [datetime] NULL,
	[cMemo] [nvarchar](max) NULL,
	[define1] [int] NULL,
	[define2] [varchar](max) NULL,
	[define3] [nvarchar](max) NULL,
 CONSTRAINT [PK_AA_Vendor] PRIMARY KEY CLUSTERED 
(
	[vendorCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AA_InventoryClass]    Script Date: 04/28/2019 23:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AA_InventoryClass](
	[categoryName] [varchar](11) NULL,
	[typeName] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[en] [varchar](255) NULL,
	[zh] [nvarchar](255) NULL,
	[ts] [bigint] NULL,
	[iStatus] [int] NOT NULL,
	[bFlag] [bit] NOT NULL,
	[errcode] [varchar](50) NULL,
	[errmsg] [nvarchar](max) NULL,
	[dCreateTime] [datetime] NOT NULL,
	[dUpdateTime] [datetime] NULL,
	[dPostTime] [datetime] NULL,
	[cMemo] [nvarchar](max) NULL,
	[define1] [int] NULL,
	[define2] [varchar](max) NULL,
	[define3] [nvarchar](max) NULL,
 CONSTRAINT [PK_AA_InventoryClass] PRIMARY KEY CLUSTERED 
(
	[typeName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AA_Inventory]    Script Date: 04/28/2019 23:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AA_Inventory](
	[itemNo] [nvarchar](60) NOT NULL,
	[itemName] [nvarchar](255) NULL,
	[categoryName] [varchar](50) NULL,
	[typeName] [nvarchar](50) NULL,
	[statusName] [nvarchar](255) NULL,
	[unitName] [nvarchar](50) NULL,
	[batchControl] [varchar](50) NULL,
	[userName] [nvarchar](20) NULL,
	[vendorCode] [nvarchar](20) NULL,
	[customerCode] [varchar](255) NULL,
	[packingSpec] [nvarchar](255) NULL,
	[currentBomRevision] [varchar](255) NULL,
	[photo] [ntext] NULL,
	[specification] [nvarchar](255) NULL,
	[dSDate] [datetime] NULL,
	[dEDate] [datetime] NULL,
	[en] [varchar](255) NULL,
	[zh] [nvarchar](255) NULL,
	[ts] [bigint] NULL,
	[iStatus] [int] NOT NULL,
	[bFlag] [bit] NOT NULL,
	[errcode] [varchar](50) NULL,
	[errmsg] [nvarchar](max) NULL,
	[dCreateTime] [datetime] NOT NULL,
	[dUpdateTime] [datetime] NULL,
	[dPostTime] [datetime] NULL,
	[cMemo] [nvarchar](max) NULL,
	[define1] [int] NULL,
	[define2] [varchar](max) NULL,
	[define3] [nvarchar](max) NULL,
 CONSTRAINT [PK_AA_Inventory] PRIMARY KEY CLUSTERED 
(
	[itemNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AA_Department]    Script Date: 04/28/2019 23:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AA_Department](
	[departmentCode] [nvarchar](12) NOT NULL,
	[departmentName] [nvarchar](255) NULL,
	[description] [nvarchar](255) NULL,
	[en] [varchar](255) NULL,
	[zh] [nvarchar](255) NULL,
	[ts] [bigint] NULL,
	[iStatus] [int] NOT NULL,
	[bFlag] [bit] NOT NULL,
	[errcode] [varchar](50) NULL,
	[errmsg] [nvarchar](max) NULL,
	[dCreateTime] [datetime] NOT NULL,
	[dUpdateTime] [datetime] NULL,
	[dPostTime] [datetime] NULL,
	[cMemo] [nvarchar](max) NULL,
	[define1] [int] NULL,
	[define2] [varchar](max) NULL,
	[define3] [nvarchar](max) NULL,
 CONSTRAINT [PK_AA_Department] PRIMARY KEY CLUSTERED 
(
	[departmentCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AA_Customer]    Script Date: 04/28/2019 23:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AA_Customer](
	[customerCode] [nvarchar](20) NOT NULL,
	[customerName] [nvarchar](255) NULL,
	[address] [nvarchar](255) NULL,
	[contactor] [nvarchar](50) NULL,
	[phone] [nvarchar](100) NULL,
	[description] [nvarchar](255) NULL,
	[en] [varchar](255) NULL,
	[zh] [nvarchar](255) NULL,
	[ts] [bigint] NULL,
	[iStatus] [int] NOT NULL,
	[bFlag] [bit] NOT NULL,
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
/****** Object:  Table [dbo].[AA_ComputationUnit]    Script Date: 04/28/2019 23:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AA_ComputationUnit](
	[unitName] [nvarchar](50) NOT NULL,
	[rate] [decimal](28, 6) NULL,
	[en] [varchar](100) NULL,
	[zh] [nvarchar](100) NULL,
	[ts] [bigint] NULL,
	[iStatus] [int] NOT NULL,
	[bFlag] [bit] NOT NULL,
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
/****** Object:  Table [dbo].[AA_BomComponentSubstitute]    Script Date: 04/28/2019 23:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AA_BomComponentSubstitute](
	[pk_id] [int] IDENTITY(1,1) NOT NULL,
	[BomId] [int] NOT NULL,
	[substituteItem] [nvarchar](60) NULL,
	[substituteQuantity] [decimal](28, 6) NULL,
	[en] [varchar](255) NULL,
	[zh] [nvarchar](255) NULL,
	[ts] [bigint] NULL,
	[iStatus] [int] NOT NULL,
	[bFlag] [bit] NOT NULL,
	[errcode] [varchar](50) NULL,
	[errmsg] [nvarchar](max) NULL,
	[dCreateTime] [datetime] NOT NULL,
	[dUpdateTime] [datetime] NULL,
	[dPostTime] [datetime] NULL,
	[cMemo] [nvarchar](max) NULL,
	[define1] [int] NULL,
	[define2] [varchar](max) NULL,
	[define3] [nvarchar](max) NULL,
 CONSTRAINT [PK_AA_BomComponentSubstitute] PRIMARY KEY CLUSTERED 
(
	[pk_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AA_BomBillComponent]    Script Date: 04/28/2019 23:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AA_BomBillComponent](
	[pk_id] [int] IDENTITY(1,1) NOT NULL,
	[BomId] [int] NOT NULL,
	[opCode] [varchar](50) NULL,
	[location] [varchar](255) NULL,
	[componentItem] [nvarchar](60) NULL,
	[componentQuantity] [decimal](28, 6) NULL,
	[lowQuantity] [decimal](28, 6) NULL,
	[highQuantity] [decimal](28, 6) NULL,
	[keyPartsFlag] [varchar](50) NULL,
	[trackerFlag] [varchar](50) NULL,
	[inputFlag] [varchar](50) NULL,
	[validateTime] [varchar](50) NULL,
	[en] [varchar](255) NULL,
	[zh] [nvarchar](255) NULL,
	[ts] [bigint] NULL,
	[iStatus] [int] NOT NULL,
	[bFlag] [bit] NOT NULL,
	[errcode] [varchar](50) NULL,
	[errmsg] [nvarchar](max) NULL,
	[dCreateTime] [datetime] NOT NULL,
	[dUpdateTime] [datetime] NULL,
	[dPostTime] [datetime] NULL,
	[cMemo] [nvarchar](max) NULL,
	[define1] [int] NULL,
	[define2] [varchar](max) NULL,
	[define3] [nvarchar](max) NULL,
 CONSTRAINT [PK_AA_BomBillComponent] PRIMARY KEY CLUSTERED 
(
	[pk_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AA_Bom]    Script Date: 04/28/2019 23:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AA_Bom](
	[BomId] [int] NOT NULL,
	[materialItem] [nvarchar](60) NULL,
	[bomType] [varchar](50) NULL,
	[revision] [varchar](50) NULL,
	[activeDate] [datetime] NULL,
	[disableDate] [datetime] NULL,
	[fromECN] [varchar](255) NULL,
	[en] [varchar](255) NULL,
	[zh] [nvarchar](255) NULL,
	[ts] [bigint] NULL,
	[iStatus] [int] NOT NULL,
	[bFlag] [bit] NOT NULL,
	[errcode] [varchar](50) NULL,
	[errmsg] [nvarchar](max) NULL,
	[dCreateTime] [datetime] NOT NULL,
	[dUpdateTime] [datetime] NULL,
	[dPostTime] [datetime] NULL,
	[cMemo] [nvarchar](max) NULL,
	[define1] [int] NULL,
	[define2] [varchar](max) NULL,
	[define3] [nvarchar](max) NULL,
 CONSTRAINT [PK_AA_Bom] PRIMARY KEY CLUSTERED 
(
	[BomId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Default [DF_AA_Bom_iStatus]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_Bom] ADD  CONSTRAINT [DF_AA_Bom_iStatus]  DEFAULT ((0)) FOR [iStatus]
GO
/****** Object:  Default [DF_AA_Bom_bFlag]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_Bom] ADD  CONSTRAINT [DF_AA_Bom_bFlag]  DEFAULT ((0)) FOR [bFlag]
GO
/****** Object:  Default [DF_AA_Bom_dCreateTime]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_Bom] ADD  CONSTRAINT [DF_AA_Bom_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_AA_BomBillComponent_iStatus]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_BomBillComponent] ADD  CONSTRAINT [DF_AA_BomBillComponent_iStatus]  DEFAULT ((0)) FOR [iStatus]
GO
/****** Object:  Default [DF_AA_BomBillComponent_bFlag]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_BomBillComponent] ADD  CONSTRAINT [DF_AA_BomBillComponent_bFlag]  DEFAULT ((0)) FOR [bFlag]
GO
/****** Object:  Default [DF_AA_BomBillComponent_dCreateTime]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_BomBillComponent] ADD  CONSTRAINT [DF_AA_BomBillComponent_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_AA_BomComponentSubstitute_iStatus]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_BomComponentSubstitute] ADD  CONSTRAINT [DF_AA_BomComponentSubstitute_iStatus]  DEFAULT ((0)) FOR [iStatus]
GO
/****** Object:  Default [DF_AA_BomComponentSubstitute_bFlag]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_BomComponentSubstitute] ADD  CONSTRAINT [DF_AA_BomComponentSubstitute_bFlag]  DEFAULT ((0)) FOR [bFlag]
GO
/****** Object:  Default [DF_AA_BomComponentSubstitute_dCreateTime]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_BomComponentSubstitute] ADD  CONSTRAINT [DF_AA_BomComponentSubstitute_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_AA_ComputationUnit_istatus]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_ComputationUnit] ADD  CONSTRAINT [DF_AA_ComputationUnit_istatus]  DEFAULT ((0)) FOR [iStatus]
GO
/****** Object:  Default [DF_AA_ComputationUnit_bflag]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_ComputationUnit] ADD  CONSTRAINT [DF_AA_ComputationUnit_bflag]  DEFAULT ((0)) FOR [bFlag]
GO
/****** Object:  Default [DF_AA_ComputationUnit_dCreateTime]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_ComputationUnit] ADD  CONSTRAINT [DF_AA_ComputationUnit_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_AA_Customer_iStatus]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_Customer] ADD  CONSTRAINT [DF_AA_Customer_iStatus]  DEFAULT ((0)) FOR [iStatus]
GO
/****** Object:  Default [DF_AA_Customer_bFlag]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_Customer] ADD  CONSTRAINT [DF_AA_Customer_bFlag]  DEFAULT ((0)) FOR [bFlag]
GO
/****** Object:  Default [DF_AA_Customer_dCreateTime]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_Customer] ADD  CONSTRAINT [DF_AA_Customer_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_AA_Department_iStatus]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_Department] ADD  CONSTRAINT [DF_AA_Department_iStatus]  DEFAULT ((0)) FOR [iStatus]
GO
/****** Object:  Default [DF_AA_Department_bFlag]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_Department] ADD  CONSTRAINT [DF_AA_Department_bFlag]  DEFAULT ((0)) FOR [bFlag]
GO
/****** Object:  Default [DF_AA_Department_dCreateTime]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_Department] ADD  CONSTRAINT [DF_AA_Department_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_AA_Inventory_iStatus]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_Inventory] ADD  CONSTRAINT [DF_AA_Inventory_iStatus]  DEFAULT ((0)) FOR [iStatus]
GO
/****** Object:  Default [DF_AA_Inventory_bFlag]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_Inventory] ADD  CONSTRAINT [DF_AA_Inventory_bFlag]  DEFAULT ((0)) FOR [bFlag]
GO
/****** Object:  Default [DF_AA_Inventory_dCreateTime]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_Inventory] ADD  CONSTRAINT [DF_AA_Inventory_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_AA_InventoryClass_iStatus]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_InventoryClass] ADD  CONSTRAINT [DF_AA_InventoryClass_iStatus]  DEFAULT ((0)) FOR [iStatus]
GO
/****** Object:  Default [DF_AA_InventoryClass_bFlag]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_InventoryClass] ADD  CONSTRAINT [DF_AA_InventoryClass_bFlag]  DEFAULT ((0)) FOR [bFlag]
GO
/****** Object:  Default [DF_AA_InventoryClass_dCreateTime]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_InventoryClass] ADD  CONSTRAINT [DF_AA_InventoryClass_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_AA_Vendor_iStatus]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_Vendor] ADD  CONSTRAINT [DF_AA_Vendor_iStatus]  DEFAULT ((0)) FOR [iStatus]
GO
/****** Object:  Default [DF_AA_Vendor_bFlag]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_Vendor] ADD  CONSTRAINT [DF_AA_Vendor_bFlag]  DEFAULT ((0)) FOR [bFlag]
GO
/****** Object:  Default [DF_AA_Vendor_dCreateTime]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[AA_Vendor] ADD  CONSTRAINT [DF_AA_Vendor_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_DL_DispatchList_iStatus]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[DL_DispatchList] ADD  CONSTRAINT [DF_DL_DispatchList_iStatus]  DEFAULT ((0)) FOR [iStatus]
GO
/****** Object:  Default [DF_DL_DispatchList_bFlag]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[DL_DispatchList] ADD  CONSTRAINT [DF_DL_DispatchList_bFlag]  DEFAULT ((0)) FOR [bFlag]
GO
/****** Object:  Default [DF_DL_DispatchList_dCreateTime]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[DL_DispatchList] ADD  CONSTRAINT [DF_DL_DispatchList_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_Log_Api_dCreateTime]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[Log_Api] ADD  CONSTRAINT [DF_Log_Api_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_Log_Del_dDelTime]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[Log_Del] ADD  CONSTRAINT [DF_Log_Del_dDelTime]  DEFAULT (getdate()) FOR [dDelTime]
GO
/****** Object:  Default [DF_Log_Tools_dCreateTime]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[Log_Tools] ADD  CONSTRAINT [DF_Log_Tools_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_PP_workOrder_iStatus]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[PP_workOrder] ADD  CONSTRAINT [DF_PP_workOrder_iStatus]  DEFAULT ((0)) FOR [iStatus]
GO
/****** Object:  Default [DF_PP_workOrder_bFlag]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[PP_workOrder] ADD  CONSTRAINT [DF_PP_workOrder_bFlag]  DEFAULT ((0)) FOR [bFlag]
GO
/****** Object:  Default [DF_PP_workOrder_dCreateTime]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[PP_workOrder] ADD  CONSTRAINT [DF_PP_workOrder_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_PP_workOrder_SNS_iStatus]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[PP_workOrder_SNS] ADD  CONSTRAINT [DF_PP_workOrder_SNS_iStatus]  DEFAULT ((0)) FOR [iStatus]
GO
/****** Object:  Default [DF_PP_workOrder_SNS_bFlag]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[PP_workOrder_SNS] ADD  CONSTRAINT [DF_PP_workOrder_SNS_bFlag]  DEFAULT ((0)) FOR [bFlag]
GO
/****** Object:  Default [DF_PP_workOrder_SNS_dCreateTime]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[PP_workOrder_SNS] ADD  CONSTRAINT [DF_PP_workOrder_SNS_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
/****** Object:  Default [DF_PP_workOrderRequirement_iStatus]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[PP_workOrderRequirement] ADD  CONSTRAINT [DF_PP_workOrderRequirement_iStatus]  DEFAULT ((0)) FOR [iStatus]
GO
/****** Object:  Default [DF_PP_workOrderRequirement_bFlag]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[PP_workOrderRequirement] ADD  CONSTRAINT [DF_PP_workOrderRequirement_bFlag]  DEFAULT ((0)) FOR [bFlag]
GO
/****** Object:  Default [DF_PP_workOrderRequirement_dCreateTime]    Script Date: 04/28/2019 23:07:52 ******/
ALTER TABLE [dbo].[PP_workOrderRequirement] ADD  CONSTRAINT [DF_PP_workOrderRequirement_dCreateTime]  DEFAULT (getdate()) FOR [dCreateTime]
GO
