
using System;

namespace FeiBo.Synchro.Core.Api.Process
{
    public class Rdrecord10 : Common, IProcess, IMethod
    {

        public ResultModel Invork(RdrecordDTO dto)
        {
            return Create(dto);
        }

        /// <summary>
        /// 处理产成品入库
        /// </summary>
        /// <param name="dto">数据载体</param>
        /// <returns>处理数据结果</returns>
        public ResultModel Create(RdrecordDTO dto)
        {
            base.VerifyDate(dto);

            string warehousecode = "1102";
            //仓库会有 4 个选择：
            //产成品库 -s[1102]、产成品库-h[2102]、 半成品库-s[1001]、半成 品库-h[2001]，
            //逻辑是生产部门为：
            //海莱特的成品 入产成品库-h[2102]，半成品 入半成品库-h[2001]，，
            //其余生产的成品,半成 品入产成品库-s[1102]/半成品库-s[1001]

            if (dto.departmentcode == "FB8009")//：海莱特 
                warehousecode = "2102";


            var ccode = "";
            foreach (var item in Factory.fdbContext.ExecuteQuery<string>(" SELECT TOP 1 ccode FROM UFDATA_100_2019..rdrecord10 ORDER BY cCode ASC"))  
                ccode = item;
             
            #region EAI

            StoreIn.header head = new StoreIn.header()
            {
                receiveflag = "1",//收发标志(*)
                vouchtype = "10",//单据类型(*)
                templatenumber = "63",//模板(*)
                code = ccode,//dto.code,//单据号
                date = dto.date.ToDateStr(),//日期
                warehousecode = warehousecode,//仓库
                departmentcode = dto.departmentcode,//部门辅助
                memory = dto.memory,//备注
                businesstype = "成品入库",// dto.businesstype , // 业务类型  []
                source = "生产订单",//单据来源 [库存/生产订单]
                receivecode = "12", //收发类别编码
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
                    quantity = _dto.quantity.ToString(),//产量 
                    itemclasscode = _dto.itemclasscode, //项目大类编码
                    itemcode = _dto.itemcode,//项目编码
                    define22 = _dto.define22,//生产序列号
                    define24 = _dto.define24,//产品大类
                    subproducingid = _dto.subproducingid, //生产订单子表 ID
                    memory = _dto.memory,//备注
                });
            }
             
            var result = EAI_Process(ZM.EAPI.EAI.Roottag.库存_入库单, head, entrys);
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
            //    int op = dbContext.p_zzp_ST_create_RD10(dto.subproducingcode, warehousecode, date, dto.departmentcode, dto.memory, dto.maker, hid);
            //    if (op != 0)
            //        throw new Exception("未知异常" + "_create_err" + $"{dto.subproducingcode}, {warehousecode}, {date}, {dto.departmentcode}, {dto.memory}, {dto.maker}, {hid}");
            //    int rowno = 0;
            //    foreach (RdrecordDTOs _dto in dto.dtos)
            //    {
            //        rowno++;
            //        ///创建体
            //        int op2 = dbContext.p_zzp_ST_create_RD10_b(dto.subproducingcode, _dto.inventorycode, _dto.quantity, _dto.itemcode, _dto.define22, _dto.define24, _dto.memory, rowno, hid, bid - rowno + 1);
            //        if (op2 != 0)
            //            throw new Exception("未知异常" + "_create_b_err" + $"{_dto.inventorycode}, {_dto.quantity}, { _dto.itemcode}, { _dto.define22}, {_dto.define24}, { _dto.memory},{rowno},{hid},{bid - rowno + 1}");
            //    }

            //    dbContext.ExecuteCommand($" EXEC p_zzp_ST_update_Stock {hid} ,'10'");
            //    dbContext.SubmitChanges();
            //    //事务提交
            //    dbContext.Transaction.Commit();
            //    return ReJson("生成成功!", hid.ToString());
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
                dbContext.p_zzp_ST_relation_RD10(id, dto.dtos[0].define22, dto.subproducingcode);

                foreach (RdrecordDTOs _dtos in dto.dtos)
                    dbContext.p_zzp_ST_relation_RD10_b(id, dto.subproducingcode);

            });
        }
    }
}