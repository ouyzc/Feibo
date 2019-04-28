

--������λ
SELECT  cComunitCode unitName , --��λ���� Y
        ISNULL(iChangRate, 0) rate , --���� 
        cEnSingular  en , --Ӣ������ 
        cComUnitName zh , --��������
        CAST(pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..ComputationUnit ;


--�ͻ�����
SELECT  cCusCode customerCode , --�ͻ����� Y
        cCusName customerName , --�ͻ����� Y
        cCusAddress address , --��ַ 
        cCusPerson contactor , --��ϵ�� 
        cCusPhone phone , --��ϵ�绰 
        '' description , --���� 
        '' en , --Ӣ������ 
        cCusName zh , --�������� 
        CAST(pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..Customer ;

--��Ӧ��

SELECT  cVenCode vendorCode , --��Ӧ�̴��� Y
        cVenName verdorName , --��Ӧ������ Y
        cVenAddress address , --��ַ
        cVenPerson contactor , --��ϵ��
        cVenPhone phone , --��ϵ�绰
        '' description , --����
        '' en , --Ӣ������
        cVenName zh , --��������  
        CAST(pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..Vendor ;

--����
SELECT  cDepCode departmentCode , --���ű��� 
        cDepName departmentName , --�������� 
        '' description , --���� 
        '' en , --Ӣ������ 
        cDepName zh , --��������  
        CAST(pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..Department ;

--�������

SELECT  cInvCCode categoryName , --ԭ���ϣ�RawMaterial �� / ��Ʒ�� SemiFinished ������� 
        cInvCName typeName , --��������  
        '' description , --���� 
        '' en , --Ӣ������ 
        cInvCName zh , --��������  
        CAST(pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..InventoryClass ;

--���

SELECT      inv.cInvCode itemNo , --���ϱ���
            inv.cInvName itemName , --��������
           'RawMaterial' categoryName , --ԭ���ϣ�RawMaterial �� / ��Ʒ�� SemiFinished �����������
             inv.cInvCCode typeName , --������������
            '' statusName , --������Normal ��ǩ�У� Approving ʧЧ��Invalid ����״̬����
            inv.cComUnitCode unitName , --���ϵ�λ���� 
            CASE WHEN bInvBatch = 1 THEN 'true' ELSE 'false' END batchControl , --�ǣ���true�� �񣺡�false�� �Ƿ�Ϊ���ο��� 
            inv.cPurPersonCode userName , --Ա������ �ɹ�Ա����
            inv.cVenCode vendorCode , --��Ӧ�̱���
            '' customerCode , --�ͻ�����
            inv.cPackingType packingSpec , --��װ���
            '' currentBomRevision , --��ǰBOM�汾
            '' photo , --ͼƬ 
            inv.cInvStd specification , --����ͺ� 
            '' en , --Ӣ������ 
            '' zh , --��������  
            CAST(inv.pubufts AS BIGINT) ts ,
            inv.dSDate ,
            inv.dEDate 
FROM        UFDATA_999_2019..Inventory inv 

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


--��������
SELECT      mo.MoId ,
            mos.MoDId ,
            mos.LPlanCode salesOrder , --�����ƻ�
            mo.MoCode workOrderName , --�����������-----------------Y
            '' linkWorkOrderName , --��������
            mos.MDeptCode workshopDepartment , --��������
            'SemiFinished' materialItem , --��/��Ʒ����
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
                                                    AND mos.SortSeq = 1 ;
--INNER JOIN   UFDATA_999_2019..mom_moallocate moc ON moc.MoDId = mos.MoDId
 
--sns
SELECT      mo.MoId ,
            mos.MoDId ,
            Define22 sn , --�������к�
            Define22 virtualSN , --�� �� �� �����к� //�ȴ�ȷ��
            CAST(mo.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..mom_order mo
INNER JOIN  UFDATA_999_2019..mom_orderdetail mos ON mos.MoId = mo.MoId ;

--workOrderRequirement
SELECT      mo.MoId ,
            mos.MoDId ,
            '' opCode , --����
            '' location , --���λ��
            mos.InvCode component , --���ϱ���
            'Y' keyPartsFlag , --�ؼ�������ʶ
            'Y' trackerFlag , --׷�ݱ�ʶ
            'Y' inputFlag , --��Ͷ����ʶ
            '0' validateTimes , --������֤����
            '1' usage , --����ʹ����
            CAST(mo.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..mom_order mo
INNER JOIN  UFDATA_999_2019..mom_orderdetail mos ON mos.MoId = mo.MoId ;


--������
SELECT  cDLCode workOrderName , --��������   
        cCusCode customerCode , --�ͻ�����
        dls.cDefine22 sn , --�������к�
        dls.cDefine23 virtualSN , --����������к�
        dl.dverifysystime deliveryTime , --����ʱ�� 
        '' en , --Ӣ������ 
         dls.cMemo  zh , --��������  
        CAST(ufts AS BIGINT) ts
FROM    UFDATA_999_2019..DispatchList  dl
LEFT JOIN  UFDATA_999_2019..DispatchLists dls ON dls.DLID = dl.DLID 
WHERE dls.cDefine22 IS NOT null

--��������0000000296
SELECT * FROM UFDATA_999_2019..MaterialAppVouch WHERE ccode='0000000296'
SELECT * FROM UFDATA_999_2019..MaterialAppVouchs WHERE id='1000000330'
--���ϳ��ⵥ0000000803
SELECT * FROM UFDATA_999_2019..rdrecord11 WHERE cCode='0000000803'
SELECT * FROM UFDATA_999_2019..rdrecords11 WHERE ID='1000006804'

--
select distinct id From st_relrdrecordsid11 as clckd Where imaids in (1000058033,1000058034,1000058035) And isnull(csource,'')=N'�������뵥'
select ID from MaterialAppVouch Where  cCode=N'0000000296'


--��
SELECT * FROM UFDATA_999_2019..rdrecord11 WHERE cCode='0000000803'
UNION ALL 
SELECT * FROM UFDATA_999_2019..rdrecord11 WHERE cCode='0000000869'--���
SELECT * FROM UFDATA_999_2019..rdrecords11 WHERE ID='1000006804'

UPDATE UFDATA_999_2019..rdrecord11 SET cSource='���',cBusCode='null'  WHERE cCode='0000000869'

