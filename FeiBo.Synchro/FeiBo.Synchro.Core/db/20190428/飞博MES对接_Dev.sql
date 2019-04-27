USE ZM_Dev ;


--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF

GO
--д��־_Tools
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
--д��־_api
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



-------------------------------------------------------------------������λ
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
GO
--����
CREATE PROCEDURE [dbo].[p_zzp_load_AA_ComputationUnit]
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    INSERT INTO ZM_Dev..AA_ComputationUnit (unitName, rate, en, zh, ts)
    --������λ
    SELECT      cu.cComunitCode unitName , --��λ���� Y
                ISNULL(cu.iChangRate, 0) rate , --���� 
                '' en , --Ӣ������ 
                cu.cComUnitName zh , --��������
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
--������ѯ
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



-------------------------------------------------------------------�ͻ�
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
GO
--����
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
    --������λ
    --�ͻ�����
    SELECT      cus.cCusCode customerCode , --�ͻ����� Y
                cus.cCusName customerName , --�ͻ����� Y
                cus.cCusAddress address , --��ַ 
                cus.cCusPerson contactor , --��ϵ�� 
                cus.cCusPhone phone , --��ϵ�绰 
                '' description , --���� 
                '' en , --Ӣ������ 
                cus.cCusName zh , --�������� 
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
--������ѯ
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