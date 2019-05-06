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


GO
--ȡ����ͼ
ALTER VIEW [dbo].[v_zzp_Take_AA_ComputationUnit]
AS
--������λ
SELECT  cu.cComunitCode unitName , --��λ���� Y
        ISNULL(cu.iChangRate, 0) rate , --���� 
        cu.cEnSingular en , --Ӣ������ 
        cu.cComUnitName zh , --��������
        CAST(cu.pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..ComputationUnit cu ;
GO

GO
--����
ALTER PROCEDURE [dbo].[p_zzp_load_AA_ComputationUnit]
AS
BEGIN
    INSERT INTO ZM_Dev..AA_ComputationUnit (unitName, rate, en, zh, ts)
    --������λ
    SELECT      cu.*
    FROM        [dbo].[v_zzp_Take_AA_ComputationUnit] cu
    LEFT JOIN   ZM_Dev..AA_ComputationUnit acu ON acu.unitName = cu.unitName
    WHERE       acu.unitName IS NULL ;
END ;
GO

GO
--����޸�
ALTER PROCEDURE [dbo].[p_zzp_modify_AA_ComputationUnit]
AS
BEGIN ;
    WITH tmp AS (SELECT     cu.*
                 FROM       ZM_Dev..AA_ComputationUnit acu
                 INNER JOIN [dbo].[v_zzp_Take_AA_ComputationUnit] cu ON cu.unitName = acu.unitName
                 WHERE      acu.iStatus = 1
                            AND acu.ts <> cu.ts)
    UPDATE      acu
    SET         acu.unitName = cu.unitName , --��λ���� Y
                acu.rate = ISNULL(cu.rate, 0) , --���� 
                acu.en = cu.en , --Ӣ������ 
                acu.zh = cu.zh , --��������
                acu.ts = CAST(cu.ts AS BIGINT) ,
                acu.iStatus = 2 ,
                acu.bFlag = 1 ,
                acu.cMemo = '���޸�'
    FROM        ZM_Dev..AA_ComputationUnit acu
    INNER JOIN  tmp cu ON cu.unitName = acu.unitName ;
END ;
GO

GO
--���ɾ��
ALTER PROCEDURE [dbo].[p_zzp_del_AA_ComputationUnit]
AS
BEGIN ;
    WITH tmp AS (SELECT     acu.unitName --��λ���� Y     
                 FROM       ZM_Dev..AA_ComputationUnit acu
                 LEFT JOIN  [dbo].[v_zzp_Take_AA_ComputationUnit] cu ON cu.unitName = acu.unitName
                 WHERE      acu.iStatus = 1
                            AND cu.unitName IS NULL)
    UPDATE      acu
    SET         acu.iStatus = 3 , 
                acu.cMemo = '��ɾ��'
    FROM        ZM_Dev..AA_ComputationUnit acu
    INNER JOIN  tmp cu ON cu.unitName = acu.unitName ;
END ;
GO

GO
--��ѯ
ALTER VIEW [dbo].[v_zzp_Get_AA_ComputationUnit]
AS
SELECT  unitName ,
        rate ,
        en ,
        zh ,
        ts ,
        iStatus --0����,2,�޸�,3,ɾ��,1--���ύ
FROM    ZM_Dev..AA_ComputationUnit ;
GO
-------------------------------------------------------------------�ͻ�


GO
--ȡ����ͼ
ALTER VIEW [dbo].[v_zzp_Take_AA_Customer]
AS
--�ͻ�����
SELECT  cus.cCusCode customerCode , --�ͻ����� Y
        cus.cCusName customerName , --�ͻ����� Y
        cus.cCusAddress address , --��ַ 
        cus.cCusPerson contactor , --��ϵ�� 
        cus.cCusPhone phone , --��ϵ�绰 
        cus.cMemo description , --���� 
        cus.cCusEnName en , --Ӣ������ 
        cus.cCusName zh , --�������� 
        CAST(cus.pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..Customer cus ;
GO

GO
--����
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
    --�ͻ�����
    SELECT      cus.*
    FROM        [dbo].[v_zzp_Take_AA_Customer] cus
    LEFT JOIN   ZM_Dev..AA_Customer acus ON acus.customerCode = cus.customerCode
    WHERE       acus.customerCode IS NULL ;
END ;
GO

GO
--����޸�
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
                acus.cMemo = '���޸�'
    FROM        ZM_Dev..AA_Customer acus
    INNER JOIN  tmp cus ON cus.customerCode = acus.customerCode ;

END ;
GO

GO
--���ɾ��
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
                acus.cMemo = '��ɾ��'
    FROM        ZM_Dev..AA_Customer acus
    INNER JOIN  tmp cus ON cus.[customerCode] = acus.[customerCode] ;
END ;
GO

GO
--��ѯ
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
        iStatus --0����,2,�޸�,3,ɾ��,1--���ύ
FROM    ZM_Dev..AA_Customer ;
GO


-------------------------------------------------------------------��Ӧ��



GO
--ȡ����ͼ
ALTER VIEW [dbo].[v_zzp_Take_AA_Vendor]
AS
--��Ӧ��
SELECT  ven.cVenCode vendorCode , --��Ӧ�̴��� Y
        ven.cVenName verdorName , --��Ӧ������ Y
        ven.cVenAddress [address] , --��ַ
        ven.cVenPerson contactor , --��ϵ��
        ven.cVenPhone phone , --��ϵ�绰
        ven.cMemo [description] , --����
        ven.cVenEnName en , --Ӣ������
        ven.cVenName zh , --��������  
        CAST(ven.pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..Vendor ven ;
GO

GO
--����
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
    --��Ӧ��
    SELECT      ven.*
    FROM        [dbo].[v_zzp_Take_AA_Vendor] ven
    LEFT JOIN   ZM_Dev..AA_Vendor aven ON aven.[vendorCode] = ven.[vendorCode]
    WHERE       aven.[vendorCode] IS NULL ;
END ;
GO

GO
--����޸�
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
                aven.cMemo = '���޸�'
    FROM        ZM_Dev..AA_Vendor aven
    INNER JOIN  tmp ven ON ven.vendorCode = aven.vendorCode ;

END ;
GO

GO
--���ɾ��
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
                aven.cMemo = '��ɾ��'
    FROM        ZM_Dev..AA_Vendor aven
    INNER JOIN  tmp ven ON ven.[vendorCode] = aven.[vendorCode] ;
END ;
GO

GO
--��ѯ
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
        iStatus --0����,2,�޸�,3,ɾ��,1--���ύ
FROM    ZM_Dev..AA_Vendor ;
GO



-------------------------------------------------------------------����

 
GO
--ȡ����ͼ
ALTER VIEW [dbo].[v_zzp_Take_AA_Department]
AS
--����
SELECT  dept.cDepCode departmentCode , --���ű��� 
        dept.cDepName departmentName , --�������� 
        dept.cDepMemo  description , --���� 
        dept.cDepNameEn en , --Ӣ������ 
        dept.cDepName zh , --��������  
        CAST(pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..Department dept ;
GO

GO
--����
ALTER PROCEDURE [dbo].[p_zzp_load_AA_Department]
AS
BEGIN
    INSERT INTO ZM_Dev..AA_Department (departmentCode, departmentName, [description], en, zh, ts)
    --����
    SELECT      dept.*
    FROM        [dbo].[v_zzp_Take_AA_Department] dept
    LEFT JOIN   ZM_Dev..AA_Department adept ON adept.[departmentCode] = dept.[departmentCode]
    WHERE       adept.[departmentCode] IS NULL ;
END ;
GO

GO
--����޸�
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
                adept.cMemo = '���޸�'
    FROM        ZM_Dev..AA_Department adept
    INNER JOIN  tmp dept ON dept.departmentCode = adept.departmentCode ;

END ;
GO

GO
--���ɾ��
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
                adept.cMemo = '��ɾ��'
    FROM        ZM_Dev..AA_Department adept
    INNER JOIN  tmp dept ON dept.departmentCode = adept.departmentCode ;
END ;
GO

GO
--��ѯ
ALTER VIEW [dbo].[v_zzp_Get_AA_Department]
AS
SELECT  departmentCode ,
        departmentName ,
        [description] ,
        [en] ,
        [zh] ,
        [ts] ,
        iStatus --0����,2,�޸�,3,ɾ��,1--���ύ
FROM    ZM_Dev..AA_Department ;
GO



-------------------------------------------------------------------�������




GO
--ȡ����ͼ
ALTER VIEW [dbo].[v_zzp_Take_AA_InventoryClass]
AS
--�������
SELECT  CASE WHEN LEFT(cInvCCode, 2) IN ( 01, 04 ) THEN 'Raw-Material'
             ELSE 'Semi-Finished'
        END categoryName ,
        --'RawMaterial' categoryName , --ԭ���ϣ�RawMaterial �� / ��Ʒ�� SemiFinished ������� 
        cInvCCode typeName , --��������  
        '' description , --���� 
        '' en , --Ӣ������ 
        cInvCName zh , --��������  
        CAST(pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..InventoryClass invclass ;
GO

GO
--����
ALTER PROCEDURE [dbo].[p_zzp_load_AA_InventoryClass]
AS
BEGIN
    INSERT INTO dbo.AA_InventoryClass (categoryName, typeName, [description], en, zh, ts)
    --�������
    SELECT      invclass.*
    FROM        [dbo].[v_zzp_Take_AA_InventoryClass] invclass
    LEFT JOIN   ZM_Dev..AA_InventoryClass ainvclass ON ainvclass.typeName = invclass.typeName
    WHERE       ainvclass.typeName IS NULL ;
END ;
GO

GO
--����޸�
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
                ainvclass.cMemo = '���޸�'
    FROM        ZM_Dev..AA_InventoryClass ainvclass
    INNER JOIN  tmp invclass ON invclass.typeName = ainvclass.typeName ;

END ;
GO

GO
--���ɾ��
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
                ainvclass.cMemo = '��ɾ��'
    FROM        ZM_Dev..AA_InventoryClass ainvclass
    INNER JOIN  tmp invclass ON invclass.typeName = ainvclass.typeName ;
END ;
GO

GO
--��ѯ
ALTER VIEW [dbo].[v_zzp_Get_AA_InventoryClass]
AS
SELECT  categoryName ,
        typeName ,
        [description] ,
        [en] ,
        [zh] ,
        [ts] ,
        iStatus --0����,2,�޸�,3,ɾ��,1--���ύ
FROM    ZM_Dev..AA_InventoryClass ;
GO




-------------------------------------------------------------------���




GO
--ȡ����ͼ
ALTER VIEW [dbo].[v_zzp_Take_AA_Inventory]
AS
--��� 
SELECT  inv.cInvCode itemNo , --���ϱ���
        inv.cInvName itemName , --�������� 
        --'RawMaterial' categoryName , --ԭ���ϣ�RawMaterial �� / ��Ʒ�� SemiFinished �����������
        CASE WHEN LEFT(inv.cInvCCode, 2) IN ( 01, 04 ) THEN 'Raw-Material'
             ELSE 'Semi-Finished'
        END categoryName ,
        inv.cInvCCode typeName , --������������
        'Normal' statusName , --������Normal ��ǩ�У� Approving ʧЧ��Invalid ����״̬����
        inv.cComUnitCode unitName , --���ϵ�λ���� 
        CASE WHEN bInvBatch = 1 THEN 'true' ELSE 'false' END batchControl , --�ǣ���true�� �񣺡�false�� �Ƿ�Ϊ���ο��� 
        inv.cPurPersonCode userName , --Ա������ �ɹ�Ա����
        inv.cVenCode vendorCode , --��Ӧ�̱���
        '' customerCode , --�ͻ�����
        inv.cPackingType packingSpec , --��װ���
        '' currentBomRevision , --��ǰBOM�汾
        '' photo , --ͼƬ 
        inv.cInvStd specification , --����ͺ� 
        inv.dSDate ,
        inv.dEDate ,
        inv.cEnglishName en , --Ӣ������ 
        inv.cInvName zh , --��������  
        CAST(inv.pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..Inventory inv ;
GO

GO
--����
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
    --���
    SELECT      inv.*
    FROM        [dbo].[v_zzp_Take_AA_Inventory] inv
    LEFT JOIN   ZM_Dev..AA_Inventory ainv ON ainv.itemNo = inv.itemNo
    WHERE       ainv.itemNo IS NULL ;
END ;
GO

GO
--����޸�
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
                ainv.cMemo = '���޸�'
    FROM        ZM_Dev..AA_Inventory ainv
    INNER JOIN  tmp inv ON inv.itemNo = ainv.itemNo ;

END ;
GO

GO
--���ɾ��
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
                ainv.cMemo = '��ɾ��'
    FROM        ZM_Dev..AA_Inventory ainv
    INNER JOIN  tmp inv ON inv.itemNo = ainv.itemNo ;
END ;
GO

GO
--��ѯ
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
        iStatus --0����,2,�޸�,3,ɾ��,1--���ύ
FROM    ZM_Dev..AA_Inventory ;
GO




-------------------------------------------------------------------BOM
 
   
GO
--ȡ����ͼ
ALTER VIEW [dbo].[v_zzp_Take_AA_Bom]
AS  
--BOM
SELECT
    -- bom �嵥
            bom.BomId ,
            bas.InvCode materialItem , --���� ���� 
            'Manufacturing BOM' bomType , --�� �� �� �� �� ���� ManufacturingBOM �� �� �� �� �� ���� EngineeringBOM ���� �嵥 ���� 
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
ALTER VIEW [dbo].[v_zzp_Take_AA_BomBillComponent]
AS 
SELECT
    --BomBillComponent
            op.BomId ,
			op.ComponentId  , 
            op.OpSeq opCode , --������� 
            '' location , --����λ�� 
            bas.InvCode componentItem , --���ϱ��� 
            --op.BaseQtyN componentQuantity , --ʹ������ 
			1.00 componentQuantity , --ʹ������ 
            '0' lowQuantity , --����ʹ������ 
            '0' highQuantity , --���ʹ������ 
            'N' keyPartsFlag , --��N �ǣ�Y �ؼ�������ʶ 
            'N' trackerFlag , --Y ��N �ǣ�Y ׷�ݱ�ʶ 
            'N' inputFlag , --Y ��N �ǣ�Y ��Ͷ����ʶ 
            '0' validateTime , --������֤���� 
            '' en , --Ӣ������ 
            '' zh , --�������� 
            CAST(op.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..bom_opcomponent op
INNER JOIN  UFDATA_999_2019..bas_part bas ON op.ComponentId = bas.PartId
INNER JOIN  UFDATA_999_2019..bom_opcomponentopt opt ON opt.OptionsId = op.OptionsId ;
  
GO

 
GO
--ȡ����ͼ
ALTER VIEW [dbo].[v_zzp_Take_AA_BomComponentSubstitute]
AS 
--BomComponentSubstitute 
SELECT      op.ComponentId  , 
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
    --����
    SELECT     wo.*
    FROM        [dbo].[v_zzp_Take_AA_Bom] wo
    LEFT JOIN   ZM_Dev..AA_Bom pwo ON pwo.BomId = wo.BomId
    WHERE       pwo.BomId IS NULL ;
	 
END ;
GO
 
GO
--����޸�
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
                adl.cMemo = '���޸�'
    FROM        ZM_Dev..AA_Bom adl
    INNER JOIN  tmp dl ON dl.BomId = adl.BomId ;
END ;
GO
  

GO
--���ɾ��
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
                adl.cMemo = '��ɾ��'
    FROM        ZM_Dev..AA_Bom adl
    INNER JOIN  tmp dl ON dl.[BomId] = adl.[BomId] ;
END ;
GO


GO
--��ѯ
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
        iStatus --0����,2,�޸�,3,ɾ��,1--���ύ
FROM    ZM_Dev..AA_Bom ;
GO











 
-------------------------------------------------------------------��������
 

GO
--ȡ����ͼ
ALTER VIEW [dbo].[v_zzp_Take_PP_workOrder]
AS
--��������
SELECT      mo.MoId ,
            mos.MoDId ,
            mos.LPlanCode salesOrder , --�����ƻ�
            mo.MoCode workOrderName , --�����������-----------------Y
            '' linkWorkOrderName , --��������
            mos.MDeptCode workshopDepartment , --�������� 
            mos.InvCode materialItem , --��/��Ʒ����
            'Standard' type , --��������   ��׼�� Standard �Ǳ�׼�� Unstandard ������Rework RMA��RMA ���ƣ� Trialproduce 
            CASE WHEN mos.[Status] = '1' THEN 'Released' --δ������ Unreleased ����ɣ� Complete �ѹرգ� Closed ���֣�HoldOn �ѷ����� Released 
                 WHEN mos.[Status] = '2' THEN 'Released' --��ȷ��
                 WHEN mos.[Status] = '3' THEN 'Released'
                 WHEN mos.[Status] = '4' THEN 'Released'
                 ELSE 'Released'
            END [status] , --����״̬��NA-����/FM-����/OP-���/CL-�رգ� 
            '' preWorkOrder , --ǰ�ö���
            mos.RoutingType routing , --����·��
            '' description , --����
            '' bomRevision , --BOM �汾
            '' routingRevision , --���հ汾
            mos.Qty quantity , --����
            '' scheduleStartDate , --Ԥ�ƿ�ʼ����
            '' dueDate , --��ֹ����  
            '' en , --Ӣ������
            '' zh , --��������
            CAST(mo.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..mom_order mo
INNER JOIN  UFDATA_999_2019..mom_orderdetail mos ON mos.MoId = mo.MoId
                                                    AND mos.SortSeq = (SELECT   MIN(SortSeq)
                                                                       FROM     UFDATA_999_2019..mom_orderdetail
                                                                       WHERE    mos.MoId = mo.MoId) ;
--INNER JOIN  UFDATA_999_2019..Inventory inv  ON inv.cInvCode=mos.InvCode
GO

GO
--ȡ����ͼ
ALTER VIEW [dbo].[v_zzp_Take_PP_workOrder_SNS]
AS 
--��������
SELECT      mo.MoId ,
            mos.MoDId ,
            Define22 sn , --�������к�
            Define22 virtualSN , --�� �� �� �����к� //�ȴ�ȷ��
            CAST(mo.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..mom_order mo
INNER JOIN  UFDATA_999_2019..mom_orderdetail mos ON mos.MoId = mo.MoId AND RelsTime IS NOT null
  
GO

GO
--ȡ����ͼ
ALTER VIEW [dbo].[v_zzp_Take_PP_workOrderRequirement]
AS 
--��������
SELECT      mo.MoId ,
            mos.MoDId ,
            '' opCode , --����
            '' location , --���λ��
            mos.InvCode component , --���ϱ���
            'N' keyPartsFlag , --�ؼ�������ʶ
            'N' trackerFlag , --׷�ݱ�ʶ
            'N' inputFlag , --��Ͷ����ʶ
            '0' validateTimes , --������֤����
            '1' usage , --����ʹ����
            CAST(mo.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..mom_order mo
INNER JOIN  UFDATA_999_2019..mom_orderdetail mos ON mos.MoId = mo.MoId ;
GO
 
  
GO
--����
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
    --����
    SELECT      wo.*
    FROM        [dbo].[v_zzp_Take_PP_workOrder] wo
    LEFT JOIN   ZM_Dev..PP_workOrder pwo ON pwo.MoId = wo.MoId
    WHERE       pwo.MoId IS NULL ;
	 
END ;
GO
 
GO
--����޸�
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
                adl.cMemo = '���޸�'
    FROM        ZM_Dev..PP_workOrder adl
    INNER JOIN  tmp dl ON dl.MoId = adl.MoId ; 
END ;
GO
  
GO
--���ɾ��
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
                adl.cMemo = '��ɾ��'
    FROM        ZM_Dev..PP_workOrder adl
    INNER JOIN  tmp dl ON dl.MoId = adl.MoId ;
END ;
GO

GO
--��ѯ
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
        iStatus --0����,2,�޸�,3,ɾ��,1--���ύ
FROM    ZM_Dev..PP_workOrder ;
GO


 


-------------------------------------------------------------------����
 
 


GO
--ȡ����ͼ
ALTER VIEW [dbo].[v_zzp_Take_DL_DispatchList]
AS
--������
SELECT      dl.cDLCode workOrderName , --��������   
            dl.cCusCode customerCode , --�ͻ�����
            dls.cDefine22 sn , --�������к�
            dls.cDefine23 virtualSN , --����������к�
            dl.dverifysystime deliveryTime , --����ʱ�� 
            '' en , --Ӣ������ 
            dls.cMemo zh , --��������  
            CAST(dl.ufts AS BIGINT) ts
FROM        UFDATA_999_2019..DispatchList dl
LEFT JOIN   UFDATA_999_2019..DispatchLists dls ON dls.DLID = dl.DLID
WHERE       dls.cDefine22 IS NOT NULL
            AND dl.dverifysystime IS NOT NULL
            AND dls.iQuantity > 0 ;
GO

GO
--����
ALTER PROCEDURE [dbo].[p_zzp_load_DL_DispatchList]
AS
BEGIN
    INSERT INTO dbo.DL_DispatchList (workOrderName, customerCode, sn, virtualSN, deliveryTime, en, zh, ts)
    --����
    SELECT      dl.*
    FROM        [dbo].[v_zzp_Take_DL_DispatchList] dl
    LEFT JOIN   ZM_Dev..DL_DispatchList adl ON adl.sn = dl.sn
    WHERE       adl.sn IS NULL ;
END ;
GO

GO
--����޸�
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
                adl.cMemo = '���޸�'
    FROM        ZM_Dev..DL_DispatchList adl
    INNER JOIN  tmp dl ON dl.sn = adl.sn ;

END ;
GO

GO
--���ɾ��
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
                adl.cMemo = '��ɾ��'
    FROM        ZM_Dev..DL_DispatchList adl
    INNER JOIN  tmp dl ON dl.sn = adl.sn ;
END ;
GO

GO
--��ѯ
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
        iStatus --0����,2,�޸�,3,ɾ��,1--���ύ
FROM    ZM_Dev..DL_DispatchList ;
GO
