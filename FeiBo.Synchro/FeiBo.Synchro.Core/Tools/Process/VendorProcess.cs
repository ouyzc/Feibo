using System;
using System.Linq;

namespace FeiBo.Synchro.Core.Tools.Process
{
    /// <summary>
    /// 供应商
    /// </summary>
    public class VendorProcess : Common, IProcess, IMethod
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
                                dbContext.p_zzp_load_AA_Vendor();
                                break;

                            case 2:
                                dbContext.p_zzp_modify_AA_Vendor();
                                break;

                            case 3:
                                dbContext.p_zzp_del_AA_Vendor();
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
                        var _dtos = dbContext.v_zzp_Get_AA_Vendor
                                    .Where(w => w.iStatus == 0)
                                    .ToList();

                        //请求
                        foreach (var _dto in _dtos)
                        {
                            try
                            {
                                var _tmp = new
                                {
                                    vendorCode = _dto.vendorCode,//供应商代码
                                    vendorName = _dto.verdorName,//供应商名称
                                    address = _dto.address,//地址
                                    contactor = _dto.contactor,//联系人
                                    phone = _dto.phone,//联系电话
                                    description = _dto.description,//描述
                                    en = _dto.en,//英文描述
                                    zh = _dto.zh,//中文描述
                                    synTime = DateTime.Now.ToLong(),//同步时间
                                    synPerson = "U8"//同步人：即操作 人
                                };

                                base.AddPost(dbContext, base.GetUrl(1, MyParams.UrlType.vendor), _tmp, nameof(dbContext.AA_Vendor), nameof(_dto.vendorCode), _dto.vendorCode);
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
                        var _dtos = dbContext.v_zzp_Get_AA_Vendor
                                    .Where(w => w.iStatus == 2)
                                    .ToList();

                        //请求
                        foreach (var _dto in _dtos)
                        {
                            try
                            {
                                var _tmp = new
                                {
                                    vendorCode = _dto.vendorCode,//供应商代码
                                    vendorName = _dto.verdorName,//供应商名称
                                    address = _dto.address,//地址
                                    contactor = _dto.contactor,//联系人
                                    phone = _dto.phone,//联系电话
                                    description = _dto.description,//描述
                                    en = _dto.en,//英文描述
                                    zh = _dto.zh,//中文描述
                                    synTime = DateTime.Now.ToLong(),//同步时间
                                    synPerson = "U8"//同步人：即操作 人
                                };

                                base.UpdatePost(dbContext, base.GetUrl(2, MyParams.UrlType.vendor), _tmp, nameof(dbContext.AA_Vendor), nameof(_dto.vendorCode), _dto.vendorCode);
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
                        var _dtos = dbContext.v_zzp_Get_AA_Vendor
                                    .Where(w => w.iStatus == 3)
                                    .ToList();

                        //请求
                        foreach (var _dto in _dtos)
                        {
                            try
                            {
                                var _tmp = new
                                {
                                    vendorCode = _dto.vendorCode,//供应商代码
                                    synTime = DateTime.Now.ToLong(),//同步时间
                                    synPerson = "U8"//同步人：即操作 人
                                };

                                base.DelPost(dbContext, base.GetUrl(3, MyParams.UrlType.vendor), _tmp, nameof(dbContext.AA_Vendor), nameof(_dto.vendorCode), _dto.vendorCode);
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
