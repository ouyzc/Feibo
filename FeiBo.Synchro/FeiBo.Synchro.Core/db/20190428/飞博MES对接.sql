

--计量单位
SELECT  cComunitCode unitName , --单位名称 Y
        ISNULL(iChangRate, 0) rate , --比率 
        '' en , --英文描述 
        cComUnitName zh , --中文描述
        CAST(pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..ComputationUnit ;


--客户档案
SELECT  cCusCode customerCode , --客户编码 Y
        cCusName customerName , --客户名称 Y
        cCusAddress address , --地址 
        cCusPerson contactor , --联系人 
        cCusPhone phone , --联系电话 
        '' description , --描述 
        '' en , --英文描述 
        cCusName zh , --中文描述 
        CAST(pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..Customer ;

--供应商

SELECT  cVenCode vendorCode , --供应商代码 Y
        cVenName verdorName , --供应商名称 Y
        cVenAddress address , --地址
        cVenPerson contactor , --联系人
        cVenPhone phone , --联系电话
        '' description , --描述
        '' en , --英文描述
        cVenName zh , --中文描述  
        CAST(pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..Vendor ;

--部门
SELECT  cDepCode departmentCode , --部门编码 
        cDepName departmentName , --部门名称 
        '' description , --描述 
        '' en , --英文描述 
        cDepName zh , --中文描述  
        CAST(pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..Department ;

--存货分类

SELECT  cInvCCode categoryName , --原材料：RawMaterial 半 / 成品： SemiFinished 类别名称 
        cInvCName typeName , --类型名称  
        '' description , --描述 
        '' en , --英文描述 
        cInvCName zh , --中文描述  
        CAST(pubufts AS BIGINT) ts
FROM    UFDATA_999_2019..InventoryClass ;

--存货

SELECT      inv.cInvCode itemNo , --物料编码
            inv.cInvName itemName , --物料名称
            inv.cInvCCode categoryName , --原材料：RawMaterial 半 / 成品： SemiFinished 物料类别名称
            invClass.cInvCName typeName , --物料类型名称
            '' statusName , --正常：Normal 核签中： Approving 失效：Invalid 物料状态名称
            inv.cComUnitCode unitName , --物料单位名称 
            CASE WHEN bInvBatch = 1 THEN 'true' ELSE 'false' END batchControl , --是：”true” 否：”false” 是否为批次控制 
            inv.cPurPersonCode userName , --员工编码 采购员名称
            inv.cVenCode vendorCode , --供应商编码
            '' customerCode , --客户编码
            inv.cPackingType packingSpec , --包装规格
            '' currentBomRevision , --当前BOM版本
            '' photo , --图片 
            inv.cInvStd specification , --规格型号 
            '' en , --英文描述 
            '' zh , --中文描述  
            CAST(inv.pubufts AS BIGINT) ts ,
            inv.dSDate ,
            inv.dEDate ,
            *
FROM        UFDATA_999_2019..Inventory inv
LEFT JOIN   UFDATA_999_2019..InventoryClass invClass ON inv.cInvCCode = invClass.cInvCCode ;

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


--生产订单
SELECT      mo.MoId ,
            mos.MoDId ,
            '' salesOrder , --生产计划
            mo.MoCode workOrderName , --生产工单编号
            '' linkWorkOrderName , --关联工单
            mos.MDeptCode workshopDepartment , --生产部门
            '' materialItem , --成/半品物料
            mos.BomType type , --工单类型
            mos.Status status , --工单状态
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
INNER JOIN  UFDATA_999_2019..mom_orderdetail mos ON mos.MoId = mo.MoId ;
--INNER JOIN   UFDATA_999_2019..mom_moallocate moc ON moc.MoDId = mos.MoDId



--sns
SELECT      mo.MoId ,
            mos.MoDId ,
            Define22 sn , --机器序列号
            Define22 virtualSN , --虚 拟 机 器序列号
            CAST(mo.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..mom_order mo
INNER JOIN  UFDATA_999_2019..mom_orderdetail mos ON mos.MoId = mo.MoId ;

--workOrderRequirement
SELECT      mo.MoId ,
            mos.MoDId ,
            '' opCode , --工序
            '' location , --零件位置
            '' component , --物料编码
            '' keyPartsFlag , --关 键 部 件标识
            '' trackerFlag , --追溯标识
            '' inputFlag , --可投产标识
            '' validateTimes , --条 码 验 证次数
            '' usage , --单个使用量
            CAST(mo.Ufts AS BIGINT) ts
FROM        UFDATA_999_2019..mom_order mo
INNER JOIN  UFDATA_999_2019..mom_orderdetail mos ON mos.MoId = mo.MoId ;


--发货单
SELECT  cDLCode workOrderName , --工单名称   
        cCusCode customerCode , --客户编码
        '' sn , --机器序列号
        '' virtualSN , --虚拟机器序列号
        '' deliveryTime , --发货时间 
        '' en , --英文描述 
        '' zh , --中文描述  
        CAST(ufts AS BIGINT) ts
FROM    UFDATA_999_2019..DispatchList ;