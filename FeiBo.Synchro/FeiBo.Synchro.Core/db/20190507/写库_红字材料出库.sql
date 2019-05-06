USE ZM_Dev ;
GO
--�������ֲ��ϳ���
ALTER PROCEDURE [dbo].[p_zzp_ST_create_RD11]
    @MoCode   VARCHAR(50) , --��������
    @dDate    VARCHAR(50) , --��������
    @cDepCode VARCHAR(50) , --���� 
    @memory   VARCHAR(255) , --��ע  
    @cMaker   VARCHAR(50) ,
    @p5       INT --ID 
AS
BEGIN
    INSERT INTO UFDATA_999_2019..rdrecord11 (ID ,
                                             bRdFlag ,
                                             cVouchType ,
                                             cBusType ,
                                             cSource ,
                                             cBusCode ,
                                             cWhCode ,
                                             dDate ,
                                             cCode ,
                                             cRdCode ,
                                             cDepCode ,
                                             cMaker ,
                                             VT_ID ,
                                             bOMFirst ,
                                             iswfcontrolled ,
                                             dnmaketime ,
                                             dnmodifytime ,
                                             dnverifytime ,
                                             bmotran ,
                                             bHYVouch ,
                                             iPrintCount ,
                                             csysbarcode ,
                                             cCheckSignFlag ,
                                             cMemo,
											 cMPoCode)
    VALUES (@p5, N'0', N'11', N'����', N'�������뵥', NULL, N'1005', @dDate, @p5, N'23', @cDepCode, @cMaker, 65, 0, 0 ,
            GETDATE(), NULL, NULL, N'0', 0, 0, N'||st11|' + CAST(@p5 AS NVARCHAR(19)), REPLACE(NEWID(), '-', '') ,
            @memory,@MoCode) ;

END ;

GO

GO
--��������Ʒ���_�ӱ�
ALTER PROCEDURE [dbo].[p_zzp_ST_create_RD11_b]
    @MoCode        VARCHAR(50) , --��������
    @inventorycode VARCHAR(50) , --�������
    @quantity      MONEY , --����
    @itemcode      VARCHAR(50) , --��Ŀ����
    @define22      VARCHAR(50) , --�������к�
    @define24      VARCHAR(50) , --��Ʒ���� 
    @memory        VARCHAR(255) , --��ע  
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
        SET @citemname = '�ɱ�������Ŀ' ;
    END ;

    INSERT INTO UFDATA_999_2019..rdrecords11 (AutoID ,
                                              ID ,
                                              cInvCode ,
                                              iNum ,
                                              iQuantity ,
                                              iUnitCost ,
                                              iPrice ,
                                              iPUnitCost ,
                                              iPPrice ,
                                              cBatch ,
                                              cObjCode ,
                                              cVouchCode ,
                                              cInVouchCode ,
                                              cinvouchtype ,
                                              iSOutQuantity ,
                                              iSOutNum ,
                                              coutvouchid ,
                                              coutvouchtype ,
                                              iSRedOutQuantity ,
                                              iSRedOutNum ,
                                              cFree1 ,
                                              cFree2 ,
                                              iSQuantity ,
                                              iFNum ,
                                              iFQuantity ,
                                              dVDate ,
                                              iTrIds ,
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
                                              cRejectCode ,
                                              cMassUnit ,
                                              cMoLotCode ,
                                              iMaterialFee ,
                                              dMSDate ,
                                              iSMaterialFee ,
                                              iOMoDID ,
                                              iOMoMID ,
                                              cmworkcentercode ,
                                              iRSRowNO ,
                                              cbaccounter ,
                                              dbKeepDate ,
                                              bCosting ,
                                              bVMIUsed ,
                                              iVMISettleQuantity ,
                                              iVMISettleNum ,
                                              cvmivencode ,
                                              iInvSNCount ,
                                              cwhpersoncode ,
                                              cwhpersonname ,
                                              iMaIDs , --//
                                              iinvexchrate ,
                                              corufts ,
                                              comcode ,
                                              cmocode ,
                                              invcode ,
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
                                              ipesodid ,
                                              ipesotype ,
                                              cpesocode ,
                                              ipesoseq ,
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
                                              applydid ,
                                              applycode ,
                                              irowno ,
                                              strowguid ,
                                              cservicecode ,
                                              bsupersede ,
                                              isupersedeqty ,
                                              isupersedempoids ,
                                              imoallocatesubid ,
                                              cInVoucherLineID ,
                                              cInVoucherCode ,
                                              cInVoucherType ,
                                              cbsysbarcode ,
                                              cSourceMOCode ,
                                              iSourceMODetailsid ,
                                              cplanlotcode ,
                                              bcanreplace ,
                                              iposflag ,
                                              bOutMaterials)
    VALUES (@p6, @p5, @inventorycode, NULL, -1 * @quantity, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL ,
            NULL , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @define22, NULL, @define24 ,
            NULL , NULL, NULL, @citemcode, @itemcode, @itemname, @citemname, NULL, NULL, NULL, NULL, NULL, NULL, NULL ,
            NULL , NULL, -1 * @quantity, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL ,
            NULL , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL ,
            NULL , NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL ,
            NULL , NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL ,
            NULL , NULL, NULL, NULL, NULL, @memory, NULL, NULL, @irowno, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL ,
            NULL , N'||st11|' + CAST(@p5 AS NVARCHAR(19)) + '|' + CAST(@irowno AS NVARCHAR(19)), NULL, NULL, NULL, NULL ,
            NULL , NULL) ;

END ;

GO
