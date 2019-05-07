--DECLARE @ID INT = 1000015501 ;
--UPDATE  rd
--SET     rd.cSource = '库存' ,
--        rd.cProBatch = NULL ,
--        rd.cMPoCode = NULL ,
--        rd.iproorderid = NULL
--FROM    UFDATA_100_2019..rdrecord10 rd
--WHERE   ID = @ID ;
--UPDATE  rds
--SET     rds.iNQuantity = NULL ,
--        rds.cMoLotCode = NULL ,
--        rds.cmocode = NULL ,
--        rds.iMPoIds = NULL ,
--        rds.imoseq = NULL
--FROM    UFDATA_100_2019..rdrecords10 rds
--WHERE   ID = @ID ;

GO
--关联
CREATE PROCEDURE [dbo].[p_zzp_ST_relation_RD10]
    @ID        BIGINT ,
    @cProBatch VARCHAR(50) ,
    @cMPoCode  VARCHAR(50)
AS
BEGIN
    UPDATE      rd
    SET         rd.cSource = '生产订单' ,
                rd.cProBatch = @cProBatch ,
                rd.cMPoCode = mo.MoCode ,
                rd.iproorderid = mo.MoId
    FROM        UFDATA_100_2019..rdrecord10 rd
    INNER JOIN  UFDATA_100_2019..mom_order mo ON mo.MoCode = @cMPoCode
    WHERE       ID = @ID ;
END ;
GO

GO
--关联_b
CREATE PROCEDURE [dbo].[p_zzp_ST_relation_RD10_b]
    @ID       BIGINT ,
    @cMPoCode VARCHAR(50)
AS
BEGIN
    UPDATE      rds
    SET         rds.iNQuantity = rds.iQuantity ,
                rds.cMoLotCode = rds.cDefine22 ,
                rds.cmocode = @cMPoCode ,
                rds.iMPoIds = mos.MoDId ,
                rds.imoseq = mos.SortSeq
    FROM        UFDATA_100_2019..rdrecords10 rds
    INNER JOIN  UFDATA_100_2019..mom_orderdetail mos ON mos.Define22 = rds.cDefine22
                                                        AND mos.cbSysBarCode LIKE '||MO21|' + @cMPoCode + '|%'
    WHERE       rds.ID = @ID ;
END ;
GO


--SELECT * FROM 
--UFDATA_100_2019..rdrecord11 
--WHERE ccode='0000003313'
--UNION ALL
--SELECT * FROM 
--UFDATA_100_2019..rdrecord11 
--WHERE id='1000015503'

--SELECT ipesoseq,cpesocode,ipesotype,ipesodid,iopseq,imoseq,invcode,cmocode,iMaIDs,cMoLotCode,cDefine22,iMPoIds,
--iNQuantity,iQuantity,cItemCName,cName,cItemCode,cItem_class,* FROM UFDATA_100_2019..rdrecords11 WHERE ID=1000015477
--UNION all
--SELECT ipesoseq,cpesocode,ipesotype,ipesodid,iopseq,imoseq,invcode,cmocode,iMaIDs,cMoLotCode,cDefine22,iMPoIds,
--iNQuantity,iQuantity,cItemCName,cName,cItemCode,cItem_class,* FROM UFDATA_100_2019..rdrecords11 WHERE ID=1000015503 
 
--UPDATE  rd
--SET     rd.cSource = '库存' ,
--        rd.cBusCode = NULL ,
--        rd.cPsPcode = NULL ,
--        rd.cMPoCode = NULL
--FROM    UFDATA_100_2019..rdrecord11 rd
--WHERE   ID = 1000015503 ;
--UPDATE  a
--SET     a.ipesoseq = NULL ,
--        a.cpesocode = NULL ,
--        a.ipesotype = NULL ,
--        a.ipesodid = NULL ,
--        a.iopseq = NULL ,
--        a.imoseq = NULL ,
--        a.invcode = NULL ,
--        a.cmocode = NULL ,
--        a.iMaIDs = NULL ,
--        a.cMoLotCode = NULL ,
--        a.iMPoIds = NULL ,
--        a.iNQuantity = NULL ,
--        a.cItemCName = NULL ,
--        a.cName = NULL ,
--        a.cItemCode = NULL ,
--        a.cItem_class = NULL
--FROM    UFDATA_100_2019..rdrecords11 a
--WHERE   ID = 1000015504 ;
GO
--表头 
--关联
ALTER PROCEDURE [dbo].[p_zzp_ST_relation_RD11]
    @ID       BIGINT ,
    @cMPoCode VARCHAR(50)
AS
BEGIN

    DECLARE @mavid BIGINT ;
    DECLARE @mavcode VARCHAR(50) ;
    DECLARE @cccode VARCHAR(50) ;
    WITH tmp_a AS (SELECT       a.*
                   FROM         UFDATA_100_2019..MaterialAppVouchs a
                   INNER JOIN   (SELECT     mos.MoDId ,
                                            mos.SortSeq ,
                                            mos.Define22 ,
                                            rds.cInvCode
                                 FROM       UFDATA_100_2019..rdrecords11 rds
                                 INNER JOIN UFDATA_100_2019..mom_orderdetail mos ON mos.Define22 = rds.cDefine22
                                                                                    AND mos.cbSysBarCode LIKE '||MO21|'
                                                                                                              + @cMPoCode
                                                                                                              + '|%'
                                 INNER JOIN UFDATA_100_2019..mom_moallocate moc ON moc.MoDId = mos.MoDId
                                                                                   AND  moc.InvCode = rds.cInvCode
                                 WHERE      rds.ID = @ID) b ON a.cDefine22 = b.Define22
                                                               AND  a.cInvCode = b.cInvCode)
    SELECT  TOP 1
            @cccode = tmp_a.invcode ,
            @mavid = tmp_a.ID
    FROM    tmp_a ;

    SELECT  TOP 1
            @mavcode = cCode
    FROM    UFDATA_100_2019..MaterialAppVouch
    WHERE   ID = @mavid ;
    UPDATE  rd
    SET     rd.cSource = '领料申请单' ,
            rd.cBusCode = @mavcode ,
            rd.cPsPcode = @cccode ,
            rd.cMPoCode = @cMPoCode
    FROM    UFDATA_100_2019..rdrecord11 rd
    WHERE   ID = @ID ;

END ;
GO



GO
--表体 
--关联--材料出库
CREATE PROCEDURE [dbo].[p_zzp_ST_relation_RD11_b]
    @ID       BIGINT ,
    @cMPoCode VARCHAR(50)
AS
BEGIN
    DECLARE @mavid BIGINT ;
    DECLARE @mavcode VARCHAR(50) ;
    DECLARE @cccode VARCHAR(50) ;
    WITH tmp_a AS (SELECT       a.*
                   FROM         UFDATA_100_2019..MaterialAppVouchs a
                   INNER JOIN   (SELECT     mos.MoDId ,
                                            mos.SortSeq ,
                                            mos.Define22 ,
                                            rds.cInvCode
                                 FROM       UFDATA_100_2019..rdrecords11 rds
                                 INNER JOIN UFDATA_100_2019..mom_orderdetail mos ON mos.Define22 = rds.cDefine22
                                                                                    AND mos.cbSysBarCode LIKE '||MO21|'
                                                                                                              + @cMPoCode
                                                                                                              + '|%'
                                 INNER JOIN UFDATA_100_2019..mom_moallocate moc ON moc.MoDId = mos.MoDId
                                                                                   AND  moc.InvCode = rds.cInvCode
                                 WHERE      rds.ID = @ID) b ON a.cDefine22 = b.Define22
                                                               AND  a.cInvCode = b.cInvCode)
    SELECT  TOP 1
            @cccode = tmp_a.invcode ,
            @mavid = tmp_a.ID
    FROM    tmp_a ;
    WITH t_a AS (SELECT *
                 FROM   UFDATA_100_2019..MaterialAppVouchs
                 WHERE  ID = @mavid
                        AND cpesocode = @cMPoCode) ,
         t_b AS (SELECT AutoID iid ,
                        cDefine22 ,
                        cInvCode
                 FROM   UFDATA_100_2019..rdrecords11
                 WHERE  ID = @ID)
    UPDATE      a
    SET         a.ipesoseq = b.ipesoseq ,
                a.cpesocode = b.cpesocode ,
                a.ipesotype = b.ipesotype ,
                a.ipesodid = b.ipesodid ,
                a.iopseq = b.iopseq ,
                a.imoseq = b.imoseq ,
                a.invcode = b.invcode ,
                a.cmocode = b.cmocode ,
                a.iMaIDs = b.AutoID ,
                a.cMoLotCode = b.cMoLotCode ,
                a.iMPoIds = b.iMPoIds ,
                a.iNQuantity = a.iQuantity ,
                a.cItemCName = b.cItemCName ,
                a.cName = b.cName ,
                a.cItemCode = b.cItemCode ,
                a.cItem_class = b.cItem_class
    FROM        UFDATA_100_2019..rdrecords11 a
    INNER JOIN  UFDATA_100_2019..MaterialAppVouchs b ON a.cDefine22 = b.cDefine22
                                                        AND a.cInvCode = b.cInvCode
    WHERE       a.ID = @ID
                AND b.ID = @mavid
                AND b.cpesocode = @cMPoCode ;



END ;
GO




SELECT * FROM UFDATA_100_2019..rdrecord11 WHERE ccode='0000003325' 
UNION ALL

SELECT * FROM UFDATA_100_2019..rdrecord11 WHERE ccode='0000003324' 
