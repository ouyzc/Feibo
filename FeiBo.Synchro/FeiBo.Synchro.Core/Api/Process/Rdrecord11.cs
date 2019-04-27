
using System;
using System.Collections.Generic;

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
                this.VerifyDate(dto);

                var head = new StoreIn.header()
                {
                    receiveflag = "0",//收发标志(*)
                    vouchtype = "11",//单据类型(*)
                    templatenumber = "65",//模板(*)
                    code = dto.code,//单据号
                    date = dto.date.ToDateStr(),//日期
                    warehousecode = "1003",//仓库-不良品仓-s
                    departmentcode = dto.departmentcode,//部门辅助
                    memory = dto.memory,//备注
                    businesstype = dto.businesstype,// 业务类型
                    source = "库存",//单据来源
                    receivecode = "25", //收发类别编码
                    ordercode = dto.subproducingcode,//生产订单号
                    personcode = dto.personcode,//业务员编码
                    maker = dto.maker,//制单人
                };

                var entrys = new List<StoreIn.entry>();

                foreach (var _dto in dto.dtos)
                {
                    if (_dto.quantity > 0)
                    {
                        throw new Exception("红字出库数量不能大于0!");
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

                return this.EAI_Process(ZM.EAPI.EAI.Roottag.库存_出库单, head, entrys);

            }

            public ResultModel Relation(RdrecordDTO dto)
            {
                throw new NotImplementedException();
            }


    }
}