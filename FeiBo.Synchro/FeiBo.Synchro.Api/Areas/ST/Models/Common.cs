using System;
using FeiBo.Synchro.Api.Models;
using System.Collections.Generic;

namespace FeiBo.Synchro.Api.Areas.ST.Models
{
    /// <summary>
    /// 公共类
    /// </summary>
    public class Common
    {
            #region Back
            /// <summary>
            /// 回调
            /// </summary>
            /// <param name="errmsg">错误信息</param>
            /// <param name="errcode">错误编码</param>
            /// <returns>ResultModel对象</returns>
            public ResultModel ReJson(string errmsg, int errcode = 0)
            {
                MyParams.log.Write(errmsg, "Ex");
                return new ResultModel(errcode, errmsg);
            }
            /// <summary>
            /// 回调override1
            /// </summary>
            /// <param name="ex">异常对象</param>
            /// <returns>ResultModel对象</returns>
            public ResultModel ReJson(Exception ex)
            {
                MyParams.log.Write($"{ex.Message}\r\n\t{ex.StackTrace}", "ExFill");
                return this.ReJson(HandleEX(ex), -1);
            }
            /// <summary>
            /// 回调override2
            /// </summary>
            /// <param name="errmsg">错误信息</param>
            /// <param name="errcode">是否成功</param>
            /// <returns>ResultModel对象</returns>
            public ResultModel ReJson(string errmsg, bool flag)
            {
                return this.ReJson(errmsg, flag ? 0 : -1);
            }
            /// <summary>
            /// 处理异常
            /// </summary>
            /// <param name="ex">异常对象</param>
            /// <returns></returns>
            private string HandleEX(Exception ex)
            {
                if (ex.InnerException == null)
                {
                    return ex ? .Message;
                }
                else
                {
                    return HandleEX(ex.InnerException);
                }
            }
            #endregion

            #region Process

            /// <summary>
            /// 处理产成品入库
            /// </summary>
            /// <param name="dto">数据载体</param>
            /// <returns>处理数据结果</returns>
            public ResultModel Rdrecord10_Process(RdrecordDTO dto) {
                this.VerifyDate(dto);

                var head = new StoreIn.header()
                {
                    receiveflag = "1",//收发标志(*)
                    vouchtype = "10",//单据类型(*)
                    templatenumber = "63",//模板(*)
                    code = dto.code,//单据号
                    date = dto.date,//日期
                    warehousecode = dto.warehousecode,//仓库
                    departmentcode = dto.departmentcode,//部门辅助
                    memory = dto.memory,//备注
                    businesstype = dto.businesstype,// 业务类型
                    source = "生产订单",//单据来源
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
            /// <summary>
            /// 处理红字材料出库
            /// </summary>
            /// <param name="dto">数据载体</param>
            /// <returns>处理数据结果</returns>
            public ResultModel Rdrecord11_Process(RdrecordDTO dto)
            {
                this.VerifyDate(dto);

                var head = new StoreIn.header()
                {
                    receiveflag = "0",//收发标志(*)
                    vouchtype = "11",//单据类型(*)
                    templatenumber = "65",//模板(*)
                    code = dto.code,//单据号
                    date = dto.date,//日期
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

            #endregion

            #region Common
            /// <summary>
            /// 请求数据
            /// </summary>
            /// <param name="roottag">类型</param>
            /// <param name="head">参数头</param>
            /// <param name="entrys">参数体</param>
            /// <returns>请求结果</returns>
            private ResultModel EAI_Process(ZM.EAPI.EAI.Roottag roottag, dynamic head, dynamic entrys)
            {
                ZM.EAPI.EAI eai = new ZM.EAPI.EAI(MyParams.sender, roottag, MyParams.host);
                //拼接XML
                var xml = eai.GetThree(head, entrys);
                MyParams.log.Write(xml, "To");
                //请求数据
                var result = eai.SendProcess(xml);
                //记录日志
                MyParams.log.Write(result.responseText, "Back");
                return this.ReJson(result.errmsg, result.bflag);

            }

            /// <summary>
            /// 公共校验数据
            /// </summary>
            /// <param name="dto">数据载体</param>
            private void VerifyDate(RdrecordDTO dto)
            {
                try
                {
                    if (string.IsNullOrWhiteSpace(dto.businesstype))
                    {
                        throw new Exception("[业务类型]为空!");
                    }

                    if (string.IsNullOrWhiteSpace(dto.subproducingcode))
                    {
                        throw new Exception("[工单号]为空!");
                    }

                    if (dto.dtos == null || dto.dtos ? .Count == 0)
                    {
                        throw new Exception("[表体数量]为空!");
                    }

                    foreach (var item in dto.dtos)
                    {
                        if (string.IsNullOrWhiteSpace(item.inventorycode))
                        {
                            throw new Exception("[存货]为空!");
                        }

                        if (item.quantity == 0)
                        {
                            throw new Exception("[数量]为0!");
                        }

                        if (string.IsNullOrWhiteSpace(item.define22))
                        {
                            throw new Exception("[生产序列号]为空!");
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("[验证失败]=>" + ex.Message);
                }
            }
            #endregion
    }
}