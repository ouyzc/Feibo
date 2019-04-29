using System;
using System.Linq;

namespace FeiBo.Synchro.Core.Tools.Process
{
    /// <summary>
    /// 生产订单
    /// </summary>
    public class WorkOrderProcess : Common, IProcess, IMethod
    {
            /// <summary>
            /// 执行
            /// </summary>
            public void Invork()
            {
                Add();
                Modify();
                Del();
            }
            /// <summary>
            /// 加载
            /// </summary>
            /// <param name="op">操作值1-add,2-update,3-del</param>
            public void Load(int op)
            {
                var curr = System.Reflection.MethodBase.GetCurrentMethod();
                Factory.Run(dbContext => {

                    try
                    {
                        switch (op)
                        {
                            case 1:
                                dbContext.p_zzp_load_PP_workOrder();
                                break;

                            case 2:
                                dbContext.p_zzp_modify_PP_workOrder();
                                break;

                            case 3:
                                dbContext.p_zzp_del_PP_workOrder();
                                break;
                        }
                    }
                    catch (Exception ex)
                    {
                        Factory.Log(new LogToolsModel(-1, ExceptionExt.HandleEX(ex), curr.DeclaringType.Name, curr.Name));
                    }
                });
            }
            /// <summary>
            /// 添加
            /// </summary>
            public void Add()
            {
                Load(1);
                var curr = System.Reflection.MethodBase.GetCurrentMethod();
                Factory.Run(dbContext => {

                    try
                    {
                        var _dtos = dbContext.v_zzp_Get_PP_workOrder
                                    .Where(w => w.iStatus == 0)
                                    .ToList();

                        //请求
                        foreach (var _dto in _dtos)
                        {
                            try
                            {
                                var _tmp = new
                                {
                                    salesOrder = _dto.salesOrder,//生产计划
                                    workOrderName = _dto.workOrderName,// 生产工单编 号
                                    linkWorkOrderName = _dto.linkWorkOrderName,// 关联工单
                                    workshopDepartment = _dto.workshopDepartment,//生产部门
                                    materialItem = _dto.materialItem,//成/半品物料
                                    type = _dto.type,//工单类型
                                    status = _dto.status,//工单状态
                                    preWorkOrder = _dto.preWorkOrder,//前置订单
                                    routing = _dto.routing,//工艺路线
                                    description = _dto.description,//描述
                                    bomRevision = _dto.bomRevision,//BOM 版本
                                    routingRevision = _dto.routingRevision,//工艺版本
                                    quantity = _dto.quantity,//数量
                                    scheduleStartDate = _dto.scheduleStartDate.ToLong(), //预计开始日期
                                    dueDate = _dto.dueDate.ToLong(), //截止日期
                                    sns = dbContext.v_zzp_Take_PP_workOrder_SNS//机器序列号
                                    .Where(w => w.MoId == _dto.MoId).Select(s => new {
                                        s.sn,//机器序列号                        ：Y
                                        s.virtualSN,//虚拟机器序 列号            ：Y
                                    })
                                    .ToList(),
                                    workOrderRequirement = dbContext.v_zzp_Take_PP_workOrderRequirement //工单物料需 求
                                    .Where(w => w.MoId == _dto.MoId)
                                    .Select(s => new {
                                        s.opCode,//工序
                                        s.location,//零件位置
                                        s.component,//物料编码                   ：Y
                                        s.keyPartsFlag,//关键部件标 识           ：Y
                                        s.trackerFlag,// 追溯标识                ：Y
                                        s.inputFlag,//可投产标识                 ：Y
                                        s.validateTimes,//条码验证次 数
                                        s.usage//单个使用量
                                    })
                                    .ToList(),
                                    en = _dto.en,//英文描述
                                    zh = _dto.zh,//中文描述
                                    synTime = DateTime.Now.ToLong(),//同步时间
                                    synPerson = "U8"//同步人：即操作 人
                                };
                                //var json = Newtonsoft.Json.JsonConvert.SerializeObject(new object[] { _tmp });
                                //System.Diagnostics.Debug.WriteLine(json);
                                base.AddPost(dbContext, base.GetUrl(1, MyParams.UrlType.workOrder), _tmp, nameof(dbContext.PP_workOrder), nameof(_dto.MoId), _dto.MoId.ToString());
                            }
                            catch (Exception exx)
                            {
                                Factory.Log(new LogToolsModel(-1, ExceptionExt.HandleEX(exx), curr.DeclaringType.Name, curr.Name));
                            }
                        }

                    }
                    catch (Exception ex)
                    {
                        Factory.Log(new LogToolsModel(-1, ExceptionExt.HandleEX(ex), curr.DeclaringType.Name, curr.Name));
                    }
                });
            }
            /// <summary>
            /// 修改
            /// </summary>
            public void Modify()
            {
                Load(2);
                var curr = System.Reflection.MethodBase.GetCurrentMethod();
                Factory.Run(dbContext => {
                    try
                    {
                        var _dtos = dbContext.v_zzp_Get_PP_workOrder
                                    .Where(w => w.iStatus == 2)
                                    .ToList();

                        //请求
                        foreach (var _dto in _dtos)
                        {
                            try
                            {
                                var _tmp = new
                                {
                                    salesOrder = _dto.salesOrder,//生产计划
                                    workOrderName = _dto.workOrderName,// 生产工单编 号
                                    linkWorkOrderName = _dto.linkWorkOrderName,// 关联工单
                                    workshopDepartment = _dto.workshopDepartment,//生产部门
                                    materialItem = _dto.materialItem,//成/半品物料
                                    type = _dto.type,//工单类型
                                    status = _dto.status,//工单状态
                                    preWorkOrder = _dto.preWorkOrder,//前置订单
                                    routing = _dto.routing,//工艺路线
                                    description = _dto.description,//描述
                                    bomRevision = _dto.bomRevision,//BOM 版本
                                    routingRevision = _dto.routingRevision,//工艺版本
                                    quantity = _dto.quantity,//数量
                                    scheduleStartDate = _dto.scheduleStartDate ? .ToLong(),//预计开始日期
                                    dueDate = _dto.dueDate ? .ToLong(),//截止日期
                                    sns = dbContext.v_zzp_Take_PP_workOrder_SNS//机器序列号
                                    .Where(w => w.MoId == _dto.MoId).Select(s => new {
                                        s.sn,//机器序列号                        ：Y
                                        s.virtualSN,//虚拟机器序 列号            ：Y
                                    })
                                    .ToList(),
                                    workOrderRequirement = dbContext.v_zzp_Take_PP_workOrderRequirement //工单物料需 求
                                    .Where(w => w.MoId == _dto.MoId)
                                    .Select(s => new {
                                        s.opCode,//工序
                                        s.location,//零件位置
                                        s.component,//物料编码                   ：Y
                                        s.keyPartsFlag,//关键部件标 识           ：Y
                                        s.trackerFlag,// 追溯标识                ：Y
                                        s.inputFlag,//可投产标识                 ：Y
                                        s.validateTimes,//条码验证次 数
                                        s.usage//单个使用量
                                    })
                                    .ToList(),
                                    en = _dto.en,//英文描述
                                    zh = _dto.zh,//中文描述
                                    synTime = DateTime.Now.ToLong(),//同步时间
                                    synPerson = "U8"//同步人：即操作 人
                                };

                                base.UpdatePost(dbContext, base.GetUrl(2, MyParams.UrlType.workOrder), _tmp, nameof(dbContext.PP_workOrder), nameof(_dto.MoId), _dto.MoId.ToString());
                            }
                            catch (Exception exx)
                            {
                                Factory.Log(new LogToolsModel(-1, ExceptionExt.HandleEX(exx), curr.DeclaringType.Name, curr.Name));
                            }
                        }

                    }
                    catch (Exception ex)
                    {
                        Factory.Log(new LogToolsModel(-1, ExceptionExt.HandleEX(ex), curr.DeclaringType.Name, curr.Name));
                    }
                });
            }
            /// <summary>
            /// 删除
            /// </summary>
            public void Del()
            {
                Load(3);
                var curr = System.Reflection.MethodBase.GetCurrentMethod();
                Factory.Run(dbContext => {
                    try
                    {
                        var _dtos = dbContext.v_zzp_Get_PP_workOrder
                                    .Where(w => w.iStatus == 3)
                                    .ToList();

                        //请求
                        foreach (var _dto in _dtos)
                        {
                            try
                            {
                                var _tmp = new
                                {
                                    workOrderName = _dto.workOrderName,// 生产工单编 号
                                    synTime = DateTime.Now.ToLong(),//同步时间
                                    synPerson = "U8"//同步人：即操作 人
                                };

                                base.DelPost(dbContext, base.GetUrl(3, MyParams.UrlType.workOrder), _tmp, nameof(dbContext.PP_workOrder), nameof(_dto.MoId), _dto.MoId.ToString());
                            }
                            catch (Exception exx)
                            {
                                Factory.Log(new LogToolsModel(-1, ExceptionExt.HandleEX(exx), curr.DeclaringType.Name, curr.Name));
                            }
                        }

                    }
                    catch (Exception ex)
                    {
                        Factory.Log(new LogToolsModel(-1, ExceptionExt.HandleEX(ex), curr.DeclaringType.Name, curr.Name));
                    }
                });
            }
    }
}
