using System;
using System.Linq;

namespace FeiBo.Synchro.Core.Tools.Process
{
    /// <summary>
    /// 客户
    /// </summary>
    public class CustomerProcess : Common, IProcess, IMethod
    {
            /// <summary>
            /// 执行
            /// </summary>
            public void Invork()
            {
                Load();
                Add();
                Modify();
                Del();
            }
            /// <summary>
            /// 加载
            /// </summary>
            public void Load()
            {
                var curr = System.Reflection.MethodBase.GetCurrentMethod();
                Factory.Run(dbContext => {

                    try
                    {
                        dbContext.p_zzp_load_AA_Customer();
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
                var curr = System.Reflection.MethodBase.GetCurrentMethod();
                Factory.Run(dbContext => {

                    try
                    {
                        var _dtos = dbContext.v_zzp_Get_AA_Customer.ToList();

                        //请求
                        foreach (var _dto in _dtos)
                        {
                            try
                            {
                                var _tmp = new
                                {
                                    customerCode = _dto.customerCode,
                                    customerName = _dto.customerName,
                                    address = _dto.address,
                                    contactor = _dto.contactor,
                                    phone = _dto.phone,
                                    description = _dto.description,
                                    en = _dto.en,
                                    zh = _dto.zh,
                                    synTime = DateTime.Now.ToLong(),
                                    synPerson = "U8"
                                };

                                base.Post(dbContext, MyParams.unit_add, _tmp, nameof(dbContext.AA_Customer), $"customerCode='{ _dto.customerCode}'");
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
            }
            /// <summary>
            /// 删除
            /// </summary>
            public void Del()
            {
            }
    }
}
