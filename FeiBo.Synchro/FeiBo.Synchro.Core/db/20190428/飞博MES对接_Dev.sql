USE ZM_Dev ;


--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF

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
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO

--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
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
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO



-------------------------------------------------------------------计量单位
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
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
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO

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



-------------------------------------------------------------------客户
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
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
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO

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