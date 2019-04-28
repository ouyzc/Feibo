
using System;
using System.Collections.Generic;

namespace FeiBo.Synchro.Core.Api.Process
{
    public class Rdrecord10: Common, IProcess, IMethod
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

                var warehousecode = "1102";
                //仓库会有 4 个选择：
                //产成品库 -s[1102]、产成品库-h[2102]、 半成品库-s[1001]、半成 品库-h[2001]，
                //逻辑是生产部门为：
                //海莱特的成品 入产成品库-h[2102]，半成品 入半成品库-h[2001]，，
                //其余生产的成品,半成 品入产成品库-s[1102]/半成品库-s[1001]

                if (dto.departmentcode == "FB8009")//：海莱特
                {
                    warehousecode = "2102";
                }


                var head = new StoreIn.header()
                {
                    receiveflag = "1",//收发标志(*)
                    vouchtype = "10",//单据类型(*)
                    templatenumber = "63",//模板(*)
                    code = dto.code,//单据号
                    date = dto.date.ToDateStr(),//日期
                    warehousecode = warehousecode,//仓库
                    departmentcode = dto.departmentcode,//部门辅助
                    memory = dto.memory,//备注
                    businesstype = dto.businesstype ?? "成品入库", // 业务类型  []
                    source = "生产订单",//单据来源 [库存/生产订单]
                    receivecode = "12", //收发类别编码
                    ordercode = dto.subproducingcode,//生产订单号
                    personcode = dto.personcode,//业务员编码
                    maker = dto.maker,//制单人
                };

                var entrys = new List<StoreIn.entry>();

                foreach (var _dto in dto.dtos)
                {
                    if (_dto.quantity < 0)
                    {
                        throw new Exception("入库数量不能小于0!");
                    }

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

                return this.EAI_Process(ZM.EAPI.EAI.Roottag.库存_入库单, head, entrys);

            }

            public ResultModel Relation(RdrecordDTO dto)
            {
                throw new NotImplementedException();
            }
    }
}