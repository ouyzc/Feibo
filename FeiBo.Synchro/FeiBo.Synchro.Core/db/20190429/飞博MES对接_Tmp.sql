
-------------------------------------------------------------------BOM
 
   
GO
--取数视图
CREATE VIEW [dbo].[v_zzp_Take_AA_Bom]
AS  
--BOM
SELECT
    -- bom 清单
            bom.BomId ,
            bas.InvCode materialItem , --物料 编码 
            bom.BomType bomType , --生 产 物 料 清 单： ManufacturingBOM 工 程 物 料 清 单： EngineeringBOM 物料 清单 类型 
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
CREATE VIEW [dbo].[v_zzp_Take_AA_BomBillComponent]
AS 
SELECT
    --BomBillComponent
            op.BomId ,
            op.OpSeq opCode , --工序编码 
            '' location , --物料位置 
            bas.InvCode componentItem , --物料编码 
            op.BaseQtyN componentQuantity , --使用数量 
            '' lowQuantity , --最少使用数量 
            '' highQuantity , --最多使用数量 
            '' keyPartsFlag , --否：N 是：Y 关键部件标识 
            '' trackerFlag , --Y 否：N 是：Y 追溯标识 
            '' inputFlag , --Y 否：N 是：Y 可投产标识 
            '' validateTime , --条码验证次数 
            '' en , --英文描述 
            '' zh , --中文描述 
            CAST(op.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..bom_opcomponent op
INNER JOIN  UFDATA_999_2019..bas_part bas ON op.ComponentId = bas.PartId
INNER JOIN  UFDATA_999_2019..bom_opcomponentopt opt ON opt.OptionsId = op.OptionsId ;
  
GO

GO
--取数视图
CREATE VIEW [dbo].[v_zzp_Take_AA_BomComponentSubstitute]
AS 
--BomComponentSubstitute 
SELECT      op.BomId ,
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
CREATE PROCEDURE [dbo].[p_zzp_load_AA_Bom]
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
CREATE PROCEDURE [dbo].[p_zzp_modify_AA_Bom]
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
CREATE PROCEDURE [dbo].[p_zzp_del_AA_Bom]
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
CREATE VIEW [dbo].[v_zzp_Get_AA_Bom]
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


