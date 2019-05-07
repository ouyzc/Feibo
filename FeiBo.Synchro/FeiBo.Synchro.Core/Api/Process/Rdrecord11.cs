namespace FeiBo.Synchro.Core.Api.Process
{
    public class Rdrecord11 : Common, IProcess, IMethod
    {
        public ResultModel Invork(RdrecordDTO dto)
        {
            return Create(dto);
        }
        /// <summary>
        /// 处理红字材料出库
        /// </summary>
        /// <param name="dto">数据载体</param>
        /// <returns>处理数据结果</returns>
        public ResultModel Create(RdrecordDTO dto)
        {
            VerifyDate(dto);

            string ccode = "";
            foreach (string item in Factory.fdbContext.ExecuteQuery<string>(" SELECT TOP 1 ccode FROM UFDATA_100_2019..rdrecord11 ORDER BY cCode ASC"))
                ccode = item;
            #region EAI

            StoreIn.header head = new StoreIn.header()
            {
                receiveflag = "0",//收发标志(*)
                vouchtype = "11",//单据类型(*)
                templatenumber = "65",//模板(*)
                code = ccode,//dto.code,//单据号
                date = dto.date.ToDateStr(),//日期
                warehousecode = "1005",//仓库-不良品仓-s
                departmentcode = dto.departmentcode,//部门辅助
                memory = dto.memory,//备注
                businesstype = "领料",//dto.businesstype , // 业务类型--[领料/生产倒冲]
                source = "库存",//单据来源--[产成品入库单/库存/领料申请单]
                receivecode = "23", //收发类别编码
                ordercode = dto.subproducingcode,//生产订单号
                personcode = dto.personcode,//业务员编码
                maker = dto.maker,//制单人 
            };

            System.Collections.Generic.List<StoreIn.entry> entrys = new System.Collections.Generic.List<StoreIn.entry>();

            foreach (RdrecordDTOs _dto in dto.dtos)
            {
                entrys.Add(new StoreIn.entry()
                {
                    inventorycode = _dto.inventorycode,//存货编码
                    quantity = (-1 * _dto.quantity).ToString(),//产量
                    itemclasscode = _dto.itemclasscode, //项目大类编码
                    itemcode = _dto.itemcode,//项目编码
                    define22 = _dto.define22,//生产序列号
                    define24 = _dto.define24,//产品大类
                    subproducingid = _dto.subproducingid, //生产订单子表 ID
                    memory = _dto.memory,//备注 
                });
            }

            ResultModel result = EAI_Process(ZM.EAPI.EAI.Roottag.库存_出库单, head, entrys);
            Relation(result, dto);
            return result;

            #endregion

            #region 写库

            //TDBDataContext dbContext = new TDBDataContext();

            ////其他验证
            //if (!dbContext.v_zzp_Get_AA_Department.Any(a => a.departmentCode == dto.departmentcode))
            //    throw new Exception("[部门]不存在!");
            //foreach (RdrecordDTOs _dto in dto.dtos)
            //{
            //    if (!dbContext.AA_Inventory.Any(a => a.itemNo == _dto.inventorycode))
            //        throw new Exception("[存货]不存在!");
            //}
            //int? hid = -1;
            //int? bid = -1;
            //int cnt = dto.dtos.Count();

            ////打开连接
            //dbContext.Connection.Open();
            //try
            //{
            //    //打开事务
            //    dbContext.Transaction = dbContext.Connection.BeginTransaction();
            //    ///获取库存ID
            //    dbContext.p_zzp_ST_get_ID(cnt, ref hid, ref bid);
            //    if (hid == -1 || bid == -1)
            //        throw new Exception("获取ID失败!");

            //    string date = dto.date.ToDateStr();
            //    if (string.IsNullOrWhiteSpace(date))
            //        date = DateTime.Now.ToString("yyyy-MM-dd");
            //    ///创建产成品入库
            //    int op = dbContext.p_zzp_ST_create_RD11(dto.subproducingcode, date, dto.departmentcode, dto.memory, dto.maker, hid);
            //    if (op != 0)
            //        throw new Exception("未知异常" + "_create_err" + $"{dto.subproducingcode}, {date}, {dto.departmentcode}, {dto.memory}, {dto.maker}, {hid}");
            //    int rowno = 0;
            //    foreach (RdrecordDTOs _dto in dto.dtos)
            //    {
            //        rowno++;
            //        ///创建体
            //        int op2 = dbContext.p_zzp_ST_create_RD11_b(dto.subproducingcode, _dto.inventorycode, _dto.quantity, _dto.itemcode, _dto.define22, _dto.define24, _dto.memory, rowno, hid, bid - rowno + 1);
            //        if (op2 != 0)
            //            throw new Exception("未知异常" + "_create_b_err" + $"{dto.subproducingcode},{_dto.inventorycode}, {_dto.quantity}, {_dto.itemclasscode}, { _dto.itemcode}, { _dto.define22}, {_dto.define24}, { _dto.memory},{rowno},{hid},{bid - rowno + 1}");
            //    }

            //    dbContext.ExecuteCommand($" EXEC p_zzp_ST_update_Stock {hid} ,'11'");
            //    dbContext.SubmitChanges();
            //    //事务提交
            //    dbContext.Transaction.Commit();
            //    return ReJson("生成成功!"  , hid.ToString());
            //}
            //catch
            //{
            //    //事务回滚
            //    dbContext.Transaction.Rollback();
            //    throw;
            //}
            //finally
            //{
            //    //关闭连接
            //    dbContext.Connection.Close();
            //}
            #endregion
        }

        public void Relation(ResultModel result, RdrecordDTO dto)
        {
            if (result.errcode != 0)
                return;

            int.TryParse(result.dtoid, out int id);

            if (id == 0)
                return;

            Factory.Run(dbContext =>
            {
                dbContext.p_zzp_ST_relation_RD11(id,dto.subproducingcode);

                foreach (RdrecordDTOs _dtos in dto.dtos)
                    dbContext.p_zzp_ST_relation_RD11_b(id, dto.subproducingcode);

            });
        }
    }
}