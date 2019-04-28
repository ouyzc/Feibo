
-------------------------------------------------------------------BOM
 
   
GO
--ȡ����ͼ
CREATE VIEW [dbo].[v_zzp_Take_AA_Bom]
AS  
--BOM
SELECT
    -- bom �嵥
            bom.BomId ,
            bas.InvCode materialItem , --���� ���� 
            bom.BomType bomType , --�� �� �� �� �� ���� ManufacturingBOM �� �� �� �� �� ���� EngineeringBOM ���� �嵥 ���� 
            bom.[Version] revision , --v1 �汾 
            bom.VersionEffDate activeDate , --��Ч ���� 
            bom.VersionEndDate disableDate , -- Ϊ���������� ʧЧ ���� 
            '' fromECN , --ECN����� ��   N
            '' en , --Ӣ������ 
            bom.VersionDesc zh , --�������� 
            CAST(bas.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..bom_parent parent
INNER JOIN  UFDATA_999_2019..bom_bom bom ON parent.BomId = bom.BomId
INNER JOIN  UFDATA_999_2019..bas_part bas ON parent.ParentId = bas.PartId ;

GO

GO
--ȡ����ͼ
CREATE VIEW [dbo].[v_zzp_Take_AA_BomBillComponent]
AS 
SELECT
    --BomBillComponent
            op.BomId ,
            op.OpSeq opCode , --������� 
            '' location , --����λ�� 
            bas.InvCode componentItem , --���ϱ��� 
            op.BaseQtyN componentQuantity , --ʹ������ 
            '' lowQuantity , --����ʹ������ 
            '' highQuantity , --���ʹ������ 
            '' keyPartsFlag , --��N �ǣ�Y �ؼ�������ʶ 
            '' trackerFlag , --Y ��N �ǣ�Y ׷�ݱ�ʶ 
            '' inputFlag , --Y ��N �ǣ�Y ��Ͷ����ʶ 
            '' validateTime , --������֤���� 
            '' en , --Ӣ������ 
            '' zh , --�������� 
            CAST(op.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..bom_opcomponent op
INNER JOIN  UFDATA_999_2019..bas_part bas ON op.ComponentId = bas.PartId
INNER JOIN  UFDATA_999_2019..bom_opcomponentopt opt ON opt.OptionsId = op.OptionsId ;
  
GO

GO
--ȡ����ͼ
CREATE VIEW [dbo].[v_zzp_Take_AA_BomComponentSubstitute]
AS 
--BomComponentSubstitute 
SELECT      op.BomId ,
            bas.InvCode substituteItem , --���ϱ��� 
            op.BaseQtyN substituteQuantity , --ʹ������ 
            '' en , --Ӣ������ 
            '' zh , --��������  
            CAST(op.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..bom_opcomponent op
INNER JOIN  UFDATA_999_2019..bas_part bas ON op.ComponentId = bas.PartId
INNER JOIN  UFDATA_999_2019..bom_opcomponentopt opt ON opt.OptionsId = op.OptionsId
INNER JOIN  UFDATA_999_2019..bom_opcomponentsub sub ON sub.OpComponentId = opt.OptionsId ;
GO
  
GO
--����
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
    --����
    SELECT     wo.*
    FROM        [dbo].[v_zzp_Take_AA_Bom] wo
    LEFT JOIN   ZM_Dev..AA_Bom pwo ON pwo.BomId = wo.BomId
    WHERE       pwo.BomId IS NULL ;
	 
END ;
GO
 
GO
--����޸�
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
                adl.cMemo = '���޸�'
    FROM        ZM_Dev..AA_Bom adl
    INNER JOIN  tmp dl ON dl.BomId = adl.BomId ;
END ;
GO
  

GO
--���ɾ��
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
                adl.cMemo = '��ɾ��'
    FROM        ZM_Dev..AA_Bom adl
    INNER JOIN  tmp dl ON dl.[BomId] = adl.[BomId] ;
END ;
GO


GO
--��ѯ
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
        iStatus --0����,2,�޸�,3,ɾ��,1--���ύ
FROM    ZM_Dev..AA_Bom ;
GO


