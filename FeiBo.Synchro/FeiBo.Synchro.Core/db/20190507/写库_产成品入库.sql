USE ZM_Dev ;
GO
--获取库存ID
ALTER PROCEDURE [dbo].[p_zzp_ST_get_ID]
    @cnt INT ,
    @hid INT OUTPUT ,
    @bid INT OUTPUT
AS
BEGIN
    EXEC UFDATA_999_2019..sp_GetID N'' ,
                                   N'999' ,
                                   N'rd' ,
                                   @cnt ,
                                   @hid OUTPUT ,
                                   @bid OUTPUT ,
                                   DEFAULT ;

END ;
GO

GO
--创建产成品入库
ALTER PROCEDURE [dbo].[p_zzp_ST_create_RD10]
    @MoCode        VARCHAR(50) , --生产订单
    @warehousecode VARCHAR(50) , --仓库
    @dDate         VARCHAR(50) , --单据日期
    @cDepCode      VARCHAR(50) , --部门 
    @memory        VARCHAR(255) , --备注  
    @cMaker        VARCHAR(50) ,
    @p5            INT --ID 
AS
BEGIN
    --主表
    INSERT INTO UFDATA_999_2019..rdrecord10 (ID ,
                                             bRdFlag ,
                                             cVouchType ,
                                             cBusType ,
                                             cSource ,
                                             cWhCode ,
                                             dDate ,
                                             cCode ,
                                             cRdCode ,
                                             cDepCode ,
                                             cMaker ,
                                             bpufirst ,
                                             biafirst ,
                                             VT_ID ,
                                             bIsSTQc ,
                                             iproorderid ,
                                             iswfcontrolled ,
                                             dnmaketime ,
                                             dnmodifytime ,
                                             dnverifytime ,
                                             iPrintCount ,
                                             csysbarcode ,
                                             cCheckSignFlag ,
                                             cMemo)
    VALUES (@p5, N'1', N'10', N'成品入库', N'生产订单', @warehousecode, @dDate, @p5, N'12', @cDepCode, @cMaker, 0, 0, 63, 0 ,
            N'0' , 0, GETDATE(), NULL, NULL, 0, N'||st10|' + CAST(@p5 AS NVARCHAR(19)), REPLACE(NEWID(), '-', '') ,
            @memory) ;
    UPDATE      rd
    SET         rd.cMPoCode = mo.MoCode ,
                rd.cBusCode = mo.MoCode ,
                rd.ipurorderid = mo.MoId
    FROM        UFDATA_999_2019..rdrecord10 rd
    INNER JOIN  UFDATA_999_2019..mom_order mo ON MoCode = @MoCode
    WHERE       cCode = CAST(@p5 AS NVARCHAR(19)) ;

END ;

GO

GO
--创建产成品入库_子表
ALTER PROCEDURE [dbo].[p_zzp_ST_create_RD10_b]
    @MoCode        VARCHAR(50) , --生产订单
    @inventorycode VARCHAR(50) , --存货编码
    @quantity      MONEY , --数量 
    @itemcode      VARCHAR(50) , --项目编码
    @define22      VARCHAR(50) , --生产序列号
    @define24      VARCHAR(50) , --产品大类
    @memory        VARCHAR(255) , --备注  
    @irowno        INT , --@irowno
    @p5            INT , --ID 
    @p6            INT --AutoID  
AS
BEGIN
    DECLARE @itemname VARCHAR(50) ;
    DECLARE @citemname VARCHAR(50) ;
    DECLARE @citemcode VARCHAR(50) ;

    IF @itemcode <> ''
       OR   @itemcode IS NOT NULL
    BEGIN
        SELECT  TOP 1
                @itemname = citemname
        FROM    UFDATA_999_2019..fitemss00
        WHERE   @itemcode = @itemcode ;
        SET @citemcode = '00' ;
        SET @citemname = '成本费用项目' ;
    END ;

    INSERT INTO UFDATA_999_2019..rdrecords10 (AutoID ,
                                              ID ,
                                              cInvCode ,
                                              iNum ,
                                              iQuantity ,
                                              iUnitCost ,
                                              iPrice ,
                                              iPUnitCost ,
                                              iPPrice ,
                                              cBatch ,
                                              cVouchCode ,
                                              cInVouchCode ,
                                              cinvouchtype ,
                                              iSOutQuantity ,
                                              iSOutNum ,
                                              cFree1 ,
                                              cFree2 ,
                                              iFNum ,
                                              iFQuantity ,
                                              dVDate ,
                                              cPosition ,
                                              cDefine22 ,
                                              cDefine23 ,
                                              cDefine24 ,
                                              cDefine25 ,
                                              cDefine26 ,
                                              cDefine27 ,
                                              cItem_class ,
                                              cItemCode ,
                                              cName ,
                                              cItemCName ,
                                              cFree3 ,
                                              cFree4 ,
                                              cFree5 ,
                                              cFree6 ,
                                              cFree7 ,
                                              cFree8 ,
                                              cFree9 ,
                                              cFree10 ,
                                              cBarCode ,
                                              iNQuantity ,
                                              iNNum ,
                                              cAssUnit ,
                                              dMadeDate ,
                                              iMassDate ,
                                              cDefine28 ,
                                              cDefine29 ,
                                              cDefine30 ,
                                              cDefine31 ,
                                              cDefine32 ,
                                              cDefine33 ,
                                              cDefine34 ,
                                              cDefine35 ,
                                              cDefine36 ,
                                              cDefine37 ,
                                              iMPoIds ,
                                              iCheckIds ,
                                              cBVencode ,
                                              cCheckCode ,
                                              iCheckIdBaks ,
                                              cRejectCode ,
                                              iRejectIds ,
                                              cCheckPersonCode ,
                                              dCheckDate ,
                                              cMassUnit ,
                                              cMoLotCode ,
                                              bRelated ,
                                              cmworkcentercode ,
                                              cbaccounter ,
                                              dbKeepDate ,
                                              bCosting ,
                                              bVMIUsed ,
                                              iVMISettleQuantity ,
                                              iVMISettleNum ,
                                              cvmivencode ,
                                              iInvSNCount ,
                                              iinvexchrate ,
                                              corufts ,
                                              cmocode ,
                                              imoseq ,
                                              iopseq ,
                                              copdesc ,
                                              iExpiratDateCalcu ,
                                              cExpirationdate ,
                                              dExpirationdate ,
                                              cciqbookcode ,
                                              iBondedSumQty ,
                                              productinids ,
                                              iorderdid ,
                                              iordertype ,
                                              iordercode ,
                                              iorderseq ,
                                              isodid ,
                                              isotype ,
                                              csocode ,
                                              isoseq ,
                                              cBatchProperty1 ,
                                              cBatchProperty2 ,
                                              cBatchProperty3 ,
                                              cBatchProperty4 ,
                                              cBatchProperty5 ,
                                              cBatchProperty6 ,
                                              cBatchProperty7 ,
                                              cBatchProperty8 ,
                                              cBatchProperty9 ,
                                              cBatchProperty10 ,
                                              cbMemo ,
                                              irowno ,
                                              strowguid ,
                                              cservicecode ,
                                              cbsysbarcode ,
                                              cplanlotcode ,
                                              bmergecheck ,
                                              imergecheckautoid ,
                                              iposflag ,
                                              iorderdetailid ,
                                              body_outid)
    VALUES (@p6, @p5, @inventorycode, NULL, @quantity, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL ,
            NULL , NULL, NULL, NULL, NULL, NULL, @define22, NULL, @define24, NULL, NULL, NULL, @citemcode, @itemcode ,
            @itemname , @citemname, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @quantity, NULL, NULL, NULL ,
            NULL , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL ,
            NULL , NULL, NULL, NULL, 0, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL ,
            NULL , 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL ,
            NULL , NULL, NULL, NULL, NULL, NULL, @memory, @irowno, NULL, NULL ,
            N'||st10|' + CAST(@p5 AS NVARCHAR(19)) + '|' + CAST(@irowno AS NVARCHAR(19)), NULL, 0, NULL, NULL, NULL ,
            NULL) ;

    --关联
    DECLARE @MoDId BIGINT ;
    SELECT      TOP 1
                @MoDId = mob.MoDId
    FROM        UFDATA_999_2019..mom_order mo
    INNER JOIN  UFDATA_999_2019..mom_orderdetail mob ON mob.MoId = mo.MoId
    WHERE       mo.MoCode = @MoCode ;
    UPDATE  UFDATA_999_2019..rdrecords10
    SET     cmocode = @MoCode ,
            iMPoIds = @MoDId
    WHERE   AutoID = @p6 ;

END ;

GO



GO
--修改现存量
ALTER PROCEDURE [dbo].[p_zzp_ST_update_Stock]
    @p5 AS      INT ,
    @sVouchtype NVARCHAR(30)
AS
BEGIN
    EXEC UFDATA_999_2019..ST_SaveForStock @sVouchtype, @p5, 0, 0, 1 ;
    EXEC UFDATA_999_2019..ST_SaveForTrackStock @sVouchtype, @p5, 0, 1 ;
    EXEC UFDATA_999_2019..IA_SP_WriteUnAccountVouchForST @p5, @sVouchtype ;
    DECLARE @spid VARCHAR(50) ; --刷新存量
    SELECT  @spid = TransactionId
    FROM    UFDATA_999_2019..SCM_EntryLedgerBuffer
    WHERE   DocumentId = @p5 ;
    EXEC UFDATA_999_2019..Usp_SCM_CommitGeneralLedgerWithCheck N'ST' ,
                                                               1 ,
                                                               1 ,
                                                               1 ,
                                                               1 ,
                                                               0 ,
                                                               0 ,
                                                               1 ,
                                                               1 ,
                                                               1 ,
                                                               0 ,
                                                               0 ,
                                                               0 ,
                                                               0 ,
                                                               0 ,
                                                               @spid ;
END ;
GO