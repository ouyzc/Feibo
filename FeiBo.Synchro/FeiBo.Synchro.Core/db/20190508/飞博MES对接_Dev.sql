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


GO
--取数视图
ALTER VIEW [dbo].[v_zzp_Take_AA_ComputationUnit]
AS
--计量单位
SELECT  cu.cComunitCode unitName , --单位名称 Y
        ISNULL(cu.iChangRate, 0) rate , --比率 
        cu.cEnSingular en , --英文描述 
        cu.cComUnitName zh , --中文描述
        CAST(cu.pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..ComputationUnit cu ;
GO

GO
--增量
ALTER PROCEDURE [dbo].[p_zzp_load_AA_ComputationUnit]
AS
BEGIN
    INSERT INTO ZM_Dev..AA_ComputationUnit (unitName, rate, en, zh, ts)
    --计量单位
    SELECT      cu.*
    FROM        [dbo].[v_zzp_Take_AA_ComputationUnit] cu
    LEFT JOIN   ZM_Dev..AA_ComputationUnit acu ON acu.unitName = cu.unitName
    WHERE       acu.unitName IS NULL ;
END ;
GO

GO
--标记修改
ALTER PROCEDURE [dbo].[p_zzp_modify_AA_ComputationUnit]
AS
BEGIN ;
    WITH tmp AS (SELECT     cu.*
                 FROM       ZM_Dev..AA_ComputationUnit acu
                 INNER JOIN [dbo].[v_zzp_Take_AA_ComputationUnit] cu ON cu.unitName = acu.unitName
                 WHERE      acu.iStatus = 1
                            AND acu.ts <> cu.ts)
    UPDATE      acu
    SET         acu.unitName = cu.unitName , --单位名称 Y
                acu.rate = ISNULL(cu.rate, 0) , --比率 
                acu.en = cu.en , --英文描述 
                acu.zh = cu.zh , --中文描述
                acu.ts = CAST(cu.ts AS BIGINT) ,
                acu.iStatus = 2 ,
                acu.bFlag = 1 ,
                acu.cMemo = '被修改'
    FROM        ZM_Dev..AA_ComputationUnit acu
    INNER JOIN  tmp cu ON cu.unitName = acu.unitName ;
END ;
GO

GO
--标记删除
ALTER PROCEDURE [dbo].[p_zzp_del_AA_ComputationUnit]
AS
BEGIN ;
    WITH tmp AS (SELECT     acu.unitName --单位名称 Y     
                 FROM       ZM_Dev..AA_ComputationUnit acu
                 LEFT JOIN  [dbo].[v_zzp_Take_AA_ComputationUnit] cu ON cu.unitName = acu.unitName
                 WHERE      acu.iStatus = 1
                            AND cu.unitName IS NULL)
    UPDATE      acu
    SET         acu.iStatus = 3 , 
                acu.cMemo = '被删除'
    FROM        ZM_Dev..AA_ComputationUnit acu
    INNER JOIN  tmp cu ON cu.unitName = acu.unitName ;
END ;
GO

GO
--查询
ALTER VIEW [dbo].[v_zzp_Get_AA_ComputationUnit]
AS
SELECT  unitName ,
        rate ,
        en ,
        zh ,
        ts ,
        iStatus --0新增,2,修改,3,删除,1--已提交
FROM    ZM_Dev..AA_ComputationUnit ;
GO
-------------------------------------------------------------------客户


GO
--取数视图
ALTER VIEW [dbo].[v_zzp_Take_AA_Customer]
AS
--客户档案
SELECT  cus.cCusCode customerCode , --客户编码 Y
        cus.cCusName customerName , --客户名称 Y
        cus.cCusAddress address , --地址 
        cus.cCusPerson contactor , --联系人 
        cus.cCusPhone phone , --联系电话 
        cus.cMemo description , --描述 
        cus.cCusEnName en , --英文描述 
        cus.cCusName zh , --中文描述 
        CAST(cus.pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..Customer cus ;
GO

GO
--增量
ALTER PROCEDURE [dbo].[p_zzp_load_AA_Customer]
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
    --客户档案
    SELECT      cus.*
    FROM        [dbo].[v_zzp_Take_AA_Customer] cus
    LEFT JOIN   ZM_Dev..AA_Customer acus ON acus.customerCode = cus.customerCode
    WHERE       acus.customerCode IS NULL ;
END ;
GO

GO
--标记修改
ALTER PROCEDURE [dbo].[p_zzp_modify_AA_Customer]
AS
BEGIN ;
    WITH tmp AS (SELECT     cus.*
                 FROM       ZM_Dev..AA_Customer acus
                 INNER JOIN [dbo].[v_zzp_Take_AA_Customer] cus ON cus.customerCode = acus.customerCode
                 WHERE      acus.iStatus = 1
                            AND acus.ts <> cus.ts)
    UPDATE      acus
    SET         acus.[customerCode] = cus.[customerCode] ,
                acus.[customerName] = cus.[customerName] ,
                acus.[address] = cus.[address] ,
                acus.[contactor] = cus.[contactor] ,
                acus.[phone] = cus.[phone] ,
                acus.[description] = cus.[description] ,
                acus.[en] = cus.[en] ,
                acus.[zh] = cus.[zh] ,
                acus.[ts] = cus.[ts] ,
                acus.iStatus = 2 ,
                acus.bFlag = 1 ,
                acus.cMemo = '被修改'
    FROM        ZM_Dev..AA_Customer acus
    INNER JOIN  tmp cus ON cus.customerCode = acus.customerCode ;

END ;
GO

GO
--标记删除
ALTER PROCEDURE [dbo].[p_zzp_del_AA_Customer]
AS
BEGIN ;
    WITH tmp AS (SELECT     acus.[customerCode]
                 FROM       ZM_Dev..AA_Customer acus
                 LEFT JOIN  [dbo].[v_zzp_Take_AA_Customer] cus ON cus.[customerCode] = acus.[customerCode]
                 WHERE      acus.iStatus = 1
                            AND cus.[customerCode] IS NULL)
    UPDATE      acus
    SET         acus.iStatus = 3 , 
                acus.cMemo = '被删除'
    FROM        ZM_Dev..AA_Customer acus
    INNER JOIN  tmp cus ON cus.[customerCode] = acus.[customerCode] ;
END ;
GO

GO
--查询
ALTER VIEW [dbo].[v_zzp_Get_AA_Customer]
AS
SELECT  [customerCode] ,
        [customerName] ,
        [address] ,
        [contactor] ,
        [phone] ,
        [description] ,
        [en] ,
        [zh] ,
        [ts] ,
        iStatus --0新增,2,修改,3,删除,1--已提交
FROM    ZM_Dev..AA_Customer ;
GO


-------------------------------------------------------------------供应商



GO
--取数视图
ALTER VIEW [dbo].[v_zzp_Take_AA_Vendor]
AS
--供应商
SELECT  ven.cVenCode vendorCode , --供应商代码 Y
        ven.cVenName verdorName , --供应商名称 Y
        ven.cVenAddress [address] , --地址
        ven.cVenPerson contactor , --联系人
        ven.cVenPhone phone , --联系电话
        ven.cMemo [description] , --描述
        ven.cVenEnName en , --英文描述
        ven.cVenName zh , --中文描述  
        CAST(ven.pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..Vendor ven ;
GO

GO
--增量
ALTER PROCEDURE [dbo].[p_zzp_load_AA_Vendor]
AS
BEGIN
    INSERT INTO ZM_Dev..AA_Vendor ([vendorCode] ,
                                   [verdorName] ,
                                   [address] ,
                                   [contactor] ,
                                   [phone] ,
                                   [description] ,
                                   [en] ,
                                   [zh] ,
                                   [ts])
    --供应商
    SELECT      ven.*
    FROM        [dbo].[v_zzp_Take_AA_Vendor] ven
    LEFT JOIN   ZM_Dev..AA_Vendor aven ON aven.[vendorCode] = ven.[vendorCode]
    WHERE       aven.[vendorCode] IS NULL ;
END ;
GO

GO
--标记修改
ALTER PROCEDURE [dbo].[p_zzp_modify_AA_Vendor]
AS
BEGIN ;
    WITH tmp AS (SELECT     ven.*
                 FROM       ZM_Dev..AA_Vendor aven
                 INNER JOIN [dbo].[v_zzp_Take_AA_Vendor] ven ON ven.vendorCode = aven.vendorCode
                 WHERE      aven.iStatus = 1
                            AND aven.ts <> ven.ts)
    UPDATE      aven
    SET         aven.[vendorCode] = ven.[vendorCode] ,
                aven.[verdorName] = ven.[verdorName] ,
                aven.[address] = ven.[address] ,
                aven.[contactor] = ven.[contactor] ,
                aven.[phone] = ven.[phone] ,
                aven.[description] = ven.[description] ,
                aven.[en] = ven.[en] ,
                aven.[zh] = ven.[zh] ,
                aven.[ts] = ven.[ts] ,
                aven.iStatus = 2 ,
                aven.bFlag = 1 ,
                aven.cMemo = '被修改'
    FROM        ZM_Dev..AA_Vendor aven
    INNER JOIN  tmp ven ON ven.vendorCode = aven.vendorCode ;

END ;
GO

GO
--标记删除
ALTER PROCEDURE [dbo].[p_zzp_del_AA_Vendor]
AS
BEGIN ;
    WITH tmp AS (SELECT     aven.[vendorCode]
                 FROM       ZM_Dev..AA_Vendor aven
                 LEFT JOIN  [dbo].[v_zzp_Take_AA_Vendor] ven ON ven.[vendorCode] = aven.[vendorCode]
                 WHERE      aven.iStatus = 1
                            AND ven.[vendorCode] IS NULL)
    UPDATE      aven
    SET         aven.iStatus = 3 ,  
                aven.cMemo = '被删除'
    FROM        ZM_Dev..AA_Vendor aven
    INNER JOIN  tmp ven ON ven.[vendorCode] = aven.[vendorCode] ;
END ;
GO

GO
--查询
ALTER VIEW [dbo].[v_zzp_Get_AA_Vendor]
AS
SELECT  [vendorCode] ,
        [verdorName] ,
        [address] ,
        [contactor] ,
        [phone] ,
        [description] ,
        [en] ,
        [zh] ,
        [ts] ,
        iStatus --0新增,2,修改,3,删除,1--已提交
FROM    ZM_Dev..AA_Vendor ;
GO



-------------------------------------------------------------------部门

 
GO
--取数视图
ALTER VIEW [dbo].[v_zzp_Take_AA_Department]
AS
--部门
SELECT  dept.cDepCode departmentCode , --部门编码 
        dept.cDepName departmentName , --部门名称 
        dept.cDepMemo  description , --描述 
        dept.cDepNameEn en , --英文描述 
        dept.cDepName zh , --中文描述  
        CAST(pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..Department dept ;
GO

GO
--增量
ALTER PROCEDURE [dbo].[p_zzp_load_AA_Department]
AS
BEGIN
    INSERT INTO ZM_Dev..AA_Department (departmentCode, departmentName, [description], en, zh, ts)
    --部门
    SELECT      dept.*
    FROM        [dbo].[v_zzp_Take_AA_Department] dept
    LEFT JOIN   ZM_Dev..AA_Department adept ON adept.[departmentCode] = dept.[departmentCode]
    WHERE       adept.[departmentCode] IS NULL ;
END ;
GO

GO
--标记修改
ALTER PROCEDURE [dbo].[p_zzp_modify_AA_Department]
AS
BEGIN ;
    WITH tmp AS (SELECT     dept.*
                 FROM       ZM_Dev..AA_Department adept
                 INNER JOIN [dbo].[v_zzp_Take_AA_Department] dept ON dept.departmentCode = adept.departmentCode
                 WHERE      adept.iStatus = 1
                            AND adept.ts <> dept.ts)
    UPDATE      adept
    SET         adept.departmentCode = dept.departmentCode ,
                adept.departmentName = dept.departmentName ,
                adept.[description] = dept.[description] ,
                adept.[en] = dept.[en] ,
                adept.[zh] = dept.[zh] ,
                adept.[ts] = dept.[ts] ,
                adept.iStatus = 2 ,
                adept.bFlag = 1 ,
                adept.cMemo = '被修改'
    FROM        ZM_Dev..AA_Department adept
    INNER JOIN  tmp dept ON dept.departmentCode = adept.departmentCode ;

END ;
GO

GO
--标记删除
ALTER PROCEDURE [dbo].[p_zzp_del_AA_Department]
AS
BEGIN ;
    WITH tmp AS (SELECT     adept.departmentCode
                 FROM       ZM_Dev..AA_Department adept
                 LEFT JOIN  [dbo].[v_zzp_Take_AA_Department] dept ON dept.departmentCode = adept.departmentCode
                 WHERE      adept.iStatus = 1
                            AND dept.departmentCode IS NULL)
    UPDATE      adept
    SET         adept.iStatus = 3 , 
                adept.cMemo = '被删除'
    FROM        ZM_Dev..AA_Department adept
    INNER JOIN  tmp dept ON dept.departmentCode = adept.departmentCode ;
END ;
GO

GO
--查询
ALTER VIEW [dbo].[v_zzp_Get_AA_Department]
AS
SELECT  departmentCode ,
        departmentName ,
        [description] ,
        [en] ,
        [zh] ,
        [ts] ,
        iStatus --0新增,2,修改,3,删除,1--已提交
FROM    ZM_Dev..AA_Department ;
GO



-------------------------------------------------------------------存货分类




GO
--取数视图
ALTER VIEW [dbo].[v_zzp_Take_AA_InventoryClass]
AS
--存货分类
SELECT  CASE WHEN LEFT(cInvCCode, 2) IN ( 01, 04 ) THEN 'Raw-Material'
             ELSE 'Semi-Finished'
        END categoryName ,
        --'RawMaterial' categoryName , --原材料：RawMaterial 半 / 成品： SemiFinished 类别名称 
        cInvCCode typeName , --类型名称  
        '' description , --描述 
        '' en , --英文描述 
        cInvCName zh , --中文描述  
        CAST(pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..InventoryClass invclass ;
GO

GO
--增量
ALTER PROCEDURE [dbo].[p_zzp_load_AA_InventoryClass]
AS
BEGIN
    INSERT INTO dbo.AA_InventoryClass (categoryName, typeName, [description], en, zh, ts)
    --存货分类
    SELECT      invclass.*
    FROM        [dbo].[v_zzp_Take_AA_InventoryClass] invclass
    LEFT JOIN   ZM_Dev..AA_InventoryClass ainvclass ON ainvclass.typeName = invclass.typeName
    WHERE       ainvclass.typeName IS NULL ;
END ;
GO

GO
--标记修改
ALTER PROCEDURE [dbo].[p_zzp_modify_AA_InventoryClass]
AS
BEGIN ;
    WITH tmp AS (SELECT     invclass.*
                 FROM       ZM_Dev..AA_InventoryClass ainvclass
                 INNER JOIN [dbo].[v_zzp_Take_AA_InventoryClass] invclass ON invclass.typeName = ainvclass.typeName
                 WHERE      ainvclass.iStatus = 1
                            AND ainvclass.ts <> invclass.ts)
    UPDATE      ainvclass
    SET         ainvclass.categoryName = invclass.categoryName ,
                ainvclass.typeName = invclass.typeName ,
                ainvclass.[description] = invclass.[description] ,
                ainvclass.[en] = invclass.[en] ,
                ainvclass.[zh] = invclass.[zh] ,
                ainvclass.[ts] = invclass.[ts] ,
                ainvclass.iStatus = 2 ,
                ainvclass.bFlag = 1 ,
                ainvclass.cMemo = '被修改'
    FROM        ZM_Dev..AA_InventoryClass ainvclass
    INNER JOIN  tmp invclass ON invclass.typeName = ainvclass.typeName ;

END ;
GO

GO
--标记删除
ALTER PROCEDURE [dbo].[p_zzp_del_AA_InventoryClass]
AS
BEGIN ;
    WITH tmp AS (SELECT     ainvclass.typeName
                 FROM       ZM_Dev..AA_InventoryClass ainvclass
                 LEFT JOIN  [dbo].[v_zzp_Take_AA_InventoryClass] invclass ON invclass.typeName = ainvclass.typeName
                 WHERE      ainvclass.iStatus = 1
                            AND invclass.typeName IS NULL)
    UPDATE      ainvclass
    SET         ainvclass.iStatus = 3 , 
                ainvclass.cMemo = '被删除'
    FROM        ZM_Dev..AA_InventoryClass ainvclass
    INNER JOIN  tmp invclass ON invclass.typeName = ainvclass.typeName ;
END ;
GO

GO
--查询
ALTER VIEW [dbo].[v_zzp_Get_AA_InventoryClass]
AS
SELECT  categoryName ,
        typeName ,
        [description] ,
        [en] ,
        [zh] ,
        [ts] ,
        iStatus --0新增,2,修改,3,删除,1--已提交
FROM    ZM_Dev..AA_InventoryClass ;
GO




-------------------------------------------------------------------存货




GO
--取数视图
ALTER VIEW [dbo].[v_zzp_Take_AA_Inventory]
AS
--存货 
SELECT  inv.cInvCode itemNo , --物料编码
        inv.cInvName itemName , --物料名称 
        --'RawMaterial' categoryName , --原材料：RawMaterial 半 / 成品： SemiFinished 物料类别名称
        CASE WHEN LEFT(inv.cInvCCode, 2) IN ( 01, 04 ) THEN 'Raw-Material'
             ELSE 'Semi-Finished'
        END categoryName ,
        inv.cInvCCode typeName , --物料类型名称
        'Normal' statusName , --正常：Normal 核签中： Approving 失效：Invalid 物料状态名称
        inv.cComUnitCode unitName , --物料单位名称 
        CASE WHEN bInvBatch = 1 THEN 'true' ELSE 'false' END batchControl , --是：”true” 否：”false” 是否为批次控制 
        inv.cPurPersonCode userName , --员工编码 采购员名称
        inv.cVenCode vendorCode , --供应商编码
        '' customerCode , --客户编码
        inv.cPackingType packingSpec , --包装规格
        '' currentBomRevision , --当前BOM版本
        '' photo , --图片 
        inv.cInvStd specification , --规格型号 
        inv.dSDate ,
        inv.dEDate ,
        inv.cEnglishName en , --英文描述 
        inv.cInvName zh , --中文描述  
        CAST(inv.pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..Inventory inv ;
GO

GO
--增量
ALTER PROCEDURE [dbo].[p_zzp_load_AA_Inventory]
AS
BEGIN
    INSERT INTO dbo.AA_Inventory (itemNo ,
                                  itemName ,
                                  categoryName ,
                                  typeName ,
                                  statusName ,
                                  unitName ,
                                  batchControl ,
                                  userName ,
                                  vendorCode ,
                                  customerCode ,
                                  packingSpec ,
                                  currentBomRevision ,
                                  photo ,
                                  specification ,
                                  dSDate ,
                                  dEDate ,
                                  en ,
                                  zh ,
                                  ts)
    --存货
    SELECT      inv.*
    FROM        [dbo].[v_zzp_Take_AA_Inventory] inv
    LEFT JOIN   ZM_Dev..AA_Inventory ainv ON ainv.itemNo = inv.itemNo
    WHERE       ainv.itemNo IS NULL ;
END ;
GO

GO
--标记修改
ALTER PROCEDURE [dbo].[p_zzp_modify_AA_Inventory]
AS
BEGIN ;
    WITH tmp AS (SELECT     inv.*
                 FROM       ZM_Dev..AA_Inventory ainv
                 INNER JOIN [dbo].[v_zzp_Take_AA_Inventory] inv ON inv.itemNo = ainv.itemNo
                 WHERE      ainv.iStatus = 1
                            AND ainv.ts <> inv.ts)
    UPDATE      ainv
    SET         ainv.itemNo = inv.itemNo ,
                ainv.itemName = inv.itemName ,
                ainv.categoryName = inv.categoryName ,
                ainv.typeName = inv.typeName ,
                ainv.statusName = inv.statusName ,
                ainv.unitName = inv.unitName ,
                ainv.batchControl = inv.batchControl ,
                ainv.userName = inv.userName ,
                ainv.vendorCode = inv.vendorCode ,
                ainv.customerCode = inv.customerCode ,
                ainv.packingSpec = inv.packingSpec ,
                ainv.currentBomRevision = inv.currentBomRevision ,
                ainv.photo = inv.photo ,
                ainv.specification = inv.specification ,
                ainv.dSDate = inv.dSDate ,
                ainv.dEDate = inv.dEDate ,
                ainv.en = inv.en ,
                ainv.zh = inv.zh ,
                ainv.ts = inv.ts ,
                ainv.iStatus = 2 ,
                ainv.bFlag = 1 ,
                ainv.cMemo = '被修改'
    FROM        ZM_Dev..AA_Inventory ainv
    INNER JOIN  tmp inv ON inv.itemNo = ainv.itemNo ;

END ;
GO

GO
--标记删除
ALTER PROCEDURE [dbo].[p_zzp_del_AA_Inventory]
AS
BEGIN ;
    WITH tmp AS (SELECT     ainv.itemNo
                 FROM       ZM_Dev..AA_Inventory ainv
                 LEFT JOIN  [dbo].[v_zzp_Take_AA_Inventory] inv ON inv.itemNo = ainv.itemNo
                 WHERE      ainv.iStatus = 1
                            AND inv.itemNo IS NULL)
    UPDATE      ainv
    SET         ainv.iStatus = 3 , 
                ainv.cMemo = '被删除'
    FROM        ZM_Dev..AA_Inventory ainv
    INNER JOIN  tmp inv ON inv.itemNo = ainv.itemNo ;
END ;
GO

GO
--查询
ALTER VIEW [dbo].[v_zzp_Get_AA_Inventory]
AS
SELECT  itemNo ,
        itemName ,
        categoryName ,
        typeName ,
        statusName ,
        unitName ,
        batchControl ,
        userName ,
        vendorCode ,
        customerCode ,
        packingSpec ,
        currentBomRevision ,
        photo ,
        specification ,
        dSDate ,
        dEDate ,
        en ,
        zh ,
        ts ,
        iStatus --0新增,2,修改,3,删除,1--已提交
FROM    ZM_Dev..AA_Inventory ;
GO




-------------------------------------------------------------------BOM
 
   
GO
--取数视图
ALTER VIEW [dbo].[v_zzp_Take_AA_Bom]
AS  
--BOM
SELECT
    -- bom 清单
            bom.BomId ,
            bas.InvCode materialItem , --物料 编码 
            'Manufacturing BOM' bomType , --生 产 物 料 清 单： ManufacturingBOM 工 程 物 料 清 单： EngineeringBOM 物料 清单 类型 
            bom.[Version] revision , --v1 版本 
            bom.VersionEffDate activeDate , --生效 日期 
            bom.VersionEndDate disableDate , -- 为空则是永久 失效 日期 
            '' fromECN , --ECN变更单 号   N
            '' en , --英文描述 
            bom.VersionDesc zh , --中文描述 
            CAST(bas.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..bom_parent parent
INNER JOIN  UFDATA_999_2019..bom_bom bom ON parent.BomId = bom.BomId
INNER JOIN  UFDATA_999_2019..bas_part bas ON parent.ParentId = bas.PartId ;

GO

GO
--取数视图
ALTER VIEW [dbo].[v_zzp_Take_AA_BomBillComponent]
AS 
SELECT
    --BomBillComponent
            op.BomId ,
			op.ComponentId  , 
            op.OpSeq opCode , --工序编码 
            '' location , --物料位置 
            bas.InvCode componentItem , --物料编码 
            --op.BaseQtyN componentQuantity , --使用数量 
			1.00 componentQuantity , --使用数量 
            '0' lowQuantity , --最少使用数量 
            '0' highQuantity , --最多使用数量 
            'N' keyPartsFlag , --否：N 是：Y 关键部件标识 
            'N' trackerFlag , --Y 否：N 是：Y 追溯标识 
            'N' inputFlag , --Y 否：N 是：Y 可投产标识 
            '0' validateTime , --条码验证次数 
            '' en , --英文描述 
            '' zh , --中文描述 
            CAST(op.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..bom_opcomponent op
INNER JOIN  UFDATA_999_2019..bas_part bas ON op.ComponentId = bas.PartId
INNER JOIN  UFDATA_999_2019..bom_opcomponentopt opt ON opt.OptionsId = op.OptionsId ;
  
GO

 
GO
--取数视图
ALTER VIEW [dbo].[v_zzp_Take_AA_BomComponentSubstitute]
AS 
--BomComponentSubstitute 
SELECT      op.ComponentId  , 
            bas.InvCode substituteItem , --物料编码 
            op.BaseQtyN substituteQuantity , --使用数量 
            '' en , --英文描述 
            '' zh , --中文描述  
            CAST(op.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..bom_opcomponent op
INNER JOIN  UFDATA_999_2019..bas_part bas ON op.ComponentId = bas.PartId
INNER JOIN  UFDATA_999_2019..bom_opcomponentopt opt ON opt.OptionsId = op.OptionsId
INNER JOIN  UFDATA_999_2019..bom_opcomponentsub sub ON sub.OpComponentId = opt.OptionsId ;
GO
  
GO
--增量
ALTER PROCEDURE [dbo].[p_zzp_load_AA_Bom]
AS
BEGIN
     INSERT INTO dbo.AA_Bom (BomId ,
                             materialItem ,
                             bomType ,
                             revision ,
                             activeDate ,
                             disableDate ,
                             fromECN ,
                             en ,
                             zh ,
                             ts ) 
    --发货
    SELECT     wo.*
    FROM        [dbo].[v_zzp_Take_AA_Bom] wo
    LEFT JOIN   ZM_Dev..AA_Bom pwo ON pwo.BomId = wo.BomId
    WHERE       pwo.BomId IS NULL ;
	 
END ;
GO
 
GO
--标记修改
ALTER PROCEDURE [dbo].[p_zzp_modify_AA_Bom]
AS
BEGIN ;
    WITH tmp AS (SELECT     dl.*
                 FROM       ZM_Dev..AA_Bom adl
                 INNER JOIN [dbo].[v_zzp_Take_AA_Bom] dl ON dl.BomId = adl.BomId
                 WHERE      adl.iStatus = 1
                            AND adl.ts <> dl.ts)
    UPDATE      adl
    SET         adl.BomId = dl.BomId ,
                adl.materialItem = dl.materialItem ,
                adl.bomType = dl.bomType ,
                adl.revision = dl.revision ,
                adl.activeDate = dl.activeDate ,
                adl.disableDate = dl.disableDate ,
                adl.fromECN = dl.fromECN ,
                adl.en = dl.en ,
                adl.zh = dl.zh ,
                adl.ts = dl.ts ,
                adl.iStatus = 2 ,
                adl.bFlag = 1 ,
                adl.cMemo = '被修改'
    FROM        ZM_Dev..AA_Bom adl
    INNER JOIN  tmp dl ON dl.BomId = adl.BomId ;
END ;
GO
  

GO
--标记删除
ALTER PROCEDURE [dbo].[p_zzp_del_AA_Bom]
AS
BEGIN ;
    WITH tmp AS (SELECT     pwo.[BomId]
                 FROM       ZM_Dev..AA_Bom pwo
                 LEFT JOIN  [dbo].[v_zzp_Take_AA_Bom] tpwo ON tpwo.[BomId] = pwo.[BomId]
                 WHERE      pwo.iStatus = 1
                            AND tpwo.[BomId] IS NULL)
    UPDATE      adl
    SET         adl.iStatus = 3 ,
                adl.cMemo = '被删除'
    FROM        ZM_Dev..AA_Bom adl
    INNER JOIN  tmp dl ON dl.[BomId] = adl.[BomId] ;
END ;
GO


GO
--查询
ALTER VIEW [dbo].[v_zzp_Get_AA_Bom]
AS
SELECT  [BomId] ,
        [materialItem] ,
        [bomType] ,
        [revision] ,
        [activeDate] ,
        [disableDate] ,
        [fromECN] ,
        [en] ,
        [zh] ,
        [ts] ,
        iStatus --0新增,2,修改,3,删除,1--已提交
FROM    ZM_Dev..AA_Bom ;
GO











 
-------------------------------------------------------------------生产订单
 

GO
--取数视图
ALTER VIEW [dbo].[v_zzp_Take_PP_workOrder]
AS
--生产订单
SELECT      mo.MoId ,
            mos.MoDId ,
            mos.LPlanCode salesOrder , --生产计划
            mo.MoCode workOrderName , --生产工单编号-----------------Y
            '' linkWorkOrderName , --关联工单
            mos.MDeptCode workshopDepartment , --生产部门 
            mos.InvCode materialItem , --成/半品物料
            'Standard' type , --工单类型   标准： Standard 非标准： Unstandard 返工：Rework RMA：RMA 试制： Trialproduce 
            CASE WHEN mos.[Status] = '1' THEN 'Released' --未发布： Unreleased 已完成： Complete 已关闭： Closed 保持：HoldOn 已发布： Released 
                 WHEN mos.[Status] = '2' THEN 'Released' --带确认
                 WHEN mos.[Status] = '3' THEN 'Released'
                 WHEN mos.[Status] = '4' THEN 'Released'
                 ELSE 'Released'
            END [status] , --工单状态（NA-开立/FM-锁定/OP-审核/CL-关闭） 
            '' preWorkOrder , --前置订单
            mos.RoutingType routing , --工艺路线
            '' description , --描述
            '' bomRevision , --BOM 版本
            '' routingRevision , --工艺版本
            mos.Qty quantity , --数量
            '' scheduleStartDate , --预计开始日期
            '' dueDate , --截止日期  
            '' en , --英文描述
            '' zh , --中文描述
            CAST(mo.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..mom_order mo
INNER JOIN  UFDATA_999_2019..mom_orderdetail mos ON mos.MoId = mo.MoId
                                                    AND mos.SortSeq = (SELECT   MIN(SortSeq)
                                                                       FROM     UFDATA_999_2019..mom_orderdetail
                                                                       WHERE    mos.MoId = mo.MoId) ;
--INNER JOIN  UFDATA_999_2019..Inventory inv  ON inv.cInvCode=mos.InvCode
GO

GO
--取数视图
ALTER VIEW [dbo].[v_zzp_Take_PP_workOrder_SNS]
AS 
--生产订单
SELECT      mo.MoId ,
            mos.MoDId ,
            Define22 sn , --机器序列号
            Define22 virtualSN , --虚 拟 机 器序列号 //等待确认
            CAST(mo.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..mom_order mo
INNER JOIN  UFDATA_999_2019..mom_orderdetail mos ON mos.MoId = mo.MoId AND RelsTime IS NOT null
  
GO

GO
--取数视图
ALTER VIEW [dbo].[v_zzp_Take_PP_workOrderRequirement]
AS 
--生产订单
SELECT      mo.MoId ,
            mos.MoDId ,
            '' opCode , --工序
            '' location , --零件位置
            mos.InvCode component , --物料编码
            'N' keyPartsFlag , --关键部件标识
            'N' trackerFlag , --追溯标识
            'N' inputFlag , --可投产标识
            '0' validateTimes , --条码验证次数
            '1' usage , --单个使用量
            CAST(mo.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..mom_order mo
INNER JOIN  UFDATA_999_2019..mom_orderdetail mos ON mos.MoId = mo.MoId ;
GO
 
  
GO
--增量
ALTER PROCEDURE [dbo].[p_zzp_load_PP_workOrder]
AS
BEGIN
    INSERT INTO dbo.PP_workOrder (MoId ,
                                  MoDId ,
                                  salesOrder ,
                                  workOrderName ,
                                  linkWorkOrderName ,
                                  workshopDepartment ,
                                  materialItem ,
                                  [type] ,
                                  [status] ,
                                  preWorkOrder ,
                                  routing ,
                                  [description] ,
                                  bomRevision ,
                                  routingRevision ,
                                  quantity ,
                                  scheduleStartDate ,
                                  dueDate ,
                                  en ,
                                  zh ,
                                  ts)
    --发货
    SELECT      wo.*
    FROM        [dbo].[v_zzp_Take_PP_workOrder] wo
    LEFT JOIN   ZM_Dev..PP_workOrder pwo ON pwo.MoId = wo.MoId
    WHERE       pwo.MoId IS NULL ;
	 
END ;
GO
 
GO
--标记修改
ALTER PROCEDURE [dbo].[p_zzp_modify_PP_workOrder]
AS
BEGIN ;
    WITH tmp AS (SELECT     dl.*
                 FROM       ZM_Dev..PP_workOrder adl
                 INNER JOIN [dbo].[v_zzp_Take_PP_workOrder] dl ON dl.MoId = adl.MoId
                 WHERE      adl.iStatus = 1
                            AND adl.ts <> dl.ts)
    UPDATE      adl
    SET         adl.MoId =dl.MoId,
				adl.MoDId =dl.MoDId,
				adl.salesOrder =dl.salesOrder,
				adl.workOrderName= dl.workOrderName,
				adl.linkWorkOrderName =dl.linkWorkOrderName,
				adl.workshopDepartment =dl.workshopDepartment,
				adl.materialItem =dl.materialItem,
				adl.[type] =dl.[type],
				adl.[status] =dl.[status],
				adl.preWorkOrder =dl.preWorkOrder,
				adl.routing =dl.routing,
				adl.[description] =dl.[description],
				adl.bomRevision =dl.bomRevision,
				adl.routingRevision =dl.routingRevision,
				adl.quantity =dl.quantity,
				adl.scheduleStartDate =dl.scheduleStartDate,
				adl.dueDate =dl.dueDate,
				adl.en =dl.en,
				adl.zh =dl.zh,
				adl.ts =dl.ts,
                adl.iStatus = 2 ,
                adl.bFlag = 1 ,
                adl.cMemo = '被修改'
    FROM        ZM_Dev..PP_workOrder adl
    INNER JOIN  tmp dl ON dl.MoId = adl.MoId ; 
END ;
GO
  
GO
--标记删除
ALTER PROCEDURE [dbo].[p_zzp_del_PP_workOrder]
AS
BEGIN ;
    WITH tmp AS (SELECT     pwo.MoId
                 FROM       ZM_Dev..PP_workOrder pwo
                 LEFT JOIN  [dbo].[v_zzp_Take_PP_workOrder] tpwo ON tpwo.MoId = pwo.MoId
                 WHERE      pwo.iStatus = 1
                            AND tpwo.MoId IS NULL)
    UPDATE      adl
    SET         adl.iStatus = 3 , 
                adl.cMemo = '被删除'
    FROM        ZM_Dev..PP_workOrder adl
    INNER JOIN  tmp dl ON dl.MoId = adl.MoId ;
END ;
GO

GO
--查询
ALTER VIEW [dbo].[v_zzp_Get_PP_workOrder]
AS
SELECT  MoId ,
        MoDId ,
        salesOrder ,
        workOrderName ,
        linkWorkOrderName ,
        workshopDepartment ,
        materialItem ,
        [type] ,
        [status] ,
        preWorkOrder ,
        routing ,
        [description] ,
        bomRevision ,
        routingRevision ,
        quantity ,
        scheduleStartDate ,
        dueDate ,
        en ,
        zh ,
        ts ,
        iStatus --0新增,2,修改,3,删除,1--已提交
FROM    ZM_Dev..PP_workOrder ;
GO


 


-------------------------------------------------------------------发货
 
 


GO
--取数视图
ALTER VIEW [dbo].[v_zzp_Take_DL_DispatchList]
AS
--发货单
SELECT      dl.cDLCode workOrderName , --工单名称   
            dl.cCusCode customerCode , --客户编码
            dls.cDefine22 sn , --机器序列号
            dls.cDefine23 virtualSN , --虚拟机器序列号
            dl.dverifysystime deliveryTime , --发货时间 
            '' en , --英文描述 
            dls.cMemo zh , --中文描述  
            CAST(dl.ufts AS BIGINT) ts
FROM        UFDATA_999_2019..DispatchList dl
LEFT JOIN   UFDATA_999_2019..DispatchLists dls ON dls.DLID = dl.DLID
WHERE       dls.cDefine22 IS NOT NULL
            AND dl.dverifysystime IS NOT NULL
            AND dls.iQuantity > 0 ;
GO

GO
--增量
ALTER PROCEDURE [dbo].[p_zzp_load_DL_DispatchList]
AS
BEGIN
    INSERT INTO dbo.DL_DispatchList (workOrderName, customerCode, sn, virtualSN, deliveryTime, en, zh, ts)
    --发货
    SELECT      dl.*
    FROM        [dbo].[v_zzp_Take_DL_DispatchList] dl
    LEFT JOIN   ZM_Dev..DL_DispatchList adl ON adl.sn = dl.sn
    WHERE       adl.sn IS NULL ;
END ;
GO

GO
--标记修改
ALTER PROCEDURE [dbo].[p_zzp_modify_DL_DispatchList]
AS
BEGIN ;
    WITH tmp AS (SELECT     dl.*
                 FROM       ZM_Dev..DL_DispatchList adl
                 INNER JOIN [dbo].[v_zzp_Take_DL_DispatchList] dl ON dl.sn = adl.sn
                 WHERE      adl.iStatus = 1
                            AND adl.ts <> dl.ts)
    UPDATE      adl
    SET         adl.workOrderName = dl.workOrderName ,
                adl.customerCode = dl.customerCode ,
                adl.sn = dl.sn ,
                adl.virtualSN = dl.virtualSN ,
                adl.deliveryTime = dl.deliveryTime ,
                adl.en = dl.en ,
                adl.zh = dl.zh ,
                adl.ts = dl.ts ,
                adl.iStatus = 2 ,
                adl.bFlag = 1 ,
                adl.cMemo = '被修改'
    FROM        ZM_Dev..DL_DispatchList adl
    INNER JOIN  tmp dl ON dl.sn = adl.sn ;

END ;
GO

GO
--标记删除
ALTER PROCEDURE [dbo].[p_zzp_del_DL_DispatchList]
AS
BEGIN ;
    WITH tmp AS (SELECT     adl.sn
                 FROM       ZM_Dev..DL_DispatchList adl
                 LEFT JOIN  [dbo].[v_zzp_Take_DL_DispatchList] dl ON dl.sn = adl.sn
                 WHERE      adl.iStatus = 1
                            AND dl.sn IS NULL)
    UPDATE      adl
    SET         adl.iStatus = 3 ,
                adl.cMemo = '被删除'
    FROM        ZM_Dev..DL_DispatchList adl
    INNER JOIN  tmp dl ON dl.sn = adl.sn ;
END ;
GO

GO
--查询
ALTER VIEW [dbo].[v_zzp_Get_DL_DispatchList]
AS
SELECT  [workOrderName] ,
        [customerCode] ,
        [sn] ,
        [virtualSN] ,
        [deliveryTime] ,
        [en] ,
        [zh] ,
        [ts] ,
        iStatus --0新增,2,修改,3,删除,1--已提交
FROM    ZM_Dev..DL_DispatchList ;
GO
