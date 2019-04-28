using System;
using System.Linq;

namespace FeiBo.Synchro.Core.Tools.Process
{

    /// <summary>
    /// 存货
    /// </summary>
    public class InventoryProcess : Common, IProcess, IMethod
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
                                dbContext.p_zzp_load_AA_Inventory();
                                break;

                            case 2:
                                dbContext.p_zzp_modify_AA_Inventory();
                                break;

                            case 3:
                                dbContext.p_zzp_del_AA_Inventory();
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
                        var _dtos = dbContext.v_zzp_Get_AA_Inventory
                                    .Where(w => w.iStatus == 0)
                                    .ToList();

                        //请求
                        foreach (var _dto in _dtos)
                        {
                            try
                            {
                                var _tmp = new
                                {
                                    itemNo = _dto.itemNo,//物料编码
                                    itemName = _dto.itemName,//物料名称
                                    categoryName = _dto.categoryName,//物料类别名称
                                    typeName = _dto.typeName,//物料类型名称
                                    statusName = _dto.statusName,//物料状态名称
                                    unitName = _dto.unitName,//物料单位名 称
                                    batchControl = _dto.batchControl,//是否为批次  控制
                                    userName = _dto.userName,//采购员名称
                                    vendorCode = _dto.vendorCode,//供应商编码
                                    customerCode = _dto.customerCode,//客户编码
                                    packingSpec = _dto.packingSpec,//包装规格
                                    currentBomRevision = _dto.currentBomRevision,//当前 BOM 版 本
                                    photo = _dto.photo,//图片
                                    specification = _dto.specification,//规格型号
                                    en = _dto.en,//英文描述
                                    zh = _dto.zh,//中文描述
                                    synTime = DateTime.Now.ToLong(),//同步时间
                                    synPerson = "U8"//同步人：即操作 人
                                };

                                base.AddPost(dbContext, base.GetUrl(1, MyParams.UrlType.materialItem), _tmp, nameof(dbContext.AA_Inventory), nameof(_dto.itemNo), _dto.itemNo);
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
                        var _dtos = dbContext.v_zzp_Get_AA_Inventory
                                    .Where(w => w.iStatus == 2)
                                    .ToList();

                        //请求
                        foreach (var _dto in _dtos)
                        {
                            try
                            {
                                var _tmp = new
                                {
                                    itemNo = _dto.itemNo,//物料编码
                                    itemName = _dto.itemName,//物料名称
                                    categoryName = _dto.categoryName,//物料类别名称
                                    typeName = _dto.typeName,//物料类型名称
                                    statusName = _dto.statusName,//物料状态名称
                                    unitName = _dto.unitName,//物料单位名 称
                                    batchControl = _dto.batchControl,//是否为批次  控制
                                    userName = _dto.userName,//采购员名称
                                    vendorCode = _dto.vendorCode,//供应商编码
                                    customerCode = _dto.customerCode,//客户编码
                                    packingSpec = _dto.packingSpec,//包装规格
                                    currentBomRevision = _dto.currentBomRevision,//当前 BOM 版 本
                                    photo = _dto.photo,//图片
                                    specification = _dto.specification,//规格型号
                                    en = _dto.en,//英文描述
                                    zh = _dto.zh,//中文描述
                                    synTime = DateTime.Now.ToLong(),//同步时间
                                    synPerson = "U8"//同步人：即操作 人
                                };

                                base.UpdatePost(dbContext, base.GetUrl(2, MyParams.UrlType.materialItem), _tmp, nameof(dbContext.AA_Inventory), nameof(_dto.itemNo), _dto.itemNo);
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
                        var _dtos = dbContext.v_zzp_Get_AA_Inventory
                                    .Where(w => w.iStatus == 3)
                                    .ToList();

                        //请求
                        foreach (var _dto in _dtos)
                        {
                            try
                            {
                                var _tmp = new
                                {
                                    itemNo = _dto.itemNo,//物料编码
                                    synTime = DateTime.Now.ToLong(),//同步时间
                                    synPerson = "U8"//同步人：即操作 人
                                };

                                base.DelPost(dbContext, base.GetUrl(3, MyParams.UrlType.materialItem), _tmp, nameof(dbContext.AA_Inventory), nameof(_dto.itemNo), _dto.itemNo);
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
