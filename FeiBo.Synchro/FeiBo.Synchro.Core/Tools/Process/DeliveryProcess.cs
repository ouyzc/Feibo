using System;
using System.Linq;

namespace FeiBo.Synchro.Core.Tools.Process
{
    /// <summary>
    /// 发货
    /// </summary>
    public class DeliveryProcess : Common, IProcess, IMethod
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
            System.Reflection.MethodBase curr = System.Reflection.MethodBase.GetCurrentMethod();
            Factory.Run(dbContext =>
            {

                try
                {
                    switch (op)
                    {
                        case 1:
                            dbContext.p_zzp_load_DL_DispatchList();
                            break;

                        case 2:
                            dbContext.p_zzp_modify_DL_DispatchList();
                            break;

                        case 3:
                            dbContext.p_zzp_del_DL_DispatchList();
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
            System.Reflection.MethodBase curr = System.Reflection.MethodBase.GetCurrentMethod();
            Factory.Run(dbContext =>
            {

                try
                {
                    System.Collections.Generic.List<v_zzp_Get_DL_DispatchList> _dtos = dbContext.v_zzp_Get_DL_DispatchList
                                .Where(w => w.iStatus == 0)
                                .ToList();

                    //请求
                    foreach (v_zzp_Get_DL_DispatchList _dto in _dtos)
                    {
                        try
                        {
                            var _tmp = new
                            {
                                workOrderName = _dto.workOrderName,
                                customerCode = _dto.customerCode,
                                sn = _dto.sn,
                                virtualSN = _dto.virtualSN,
                                deliveryTime = _dto.deliveryTime?.ToLong(),
                                en = _dto.en,
                                zh = _dto.zh,
                                synTime = DateTime.Now.ToLong(),
                                synPerson = "U8"
                            };

                            base.AddPost(dbContext, base.GetUrl(1, MyParams.UrlType.delivery), _tmp, nameof(dbContext.DL_DispatchList), nameof(_dto.sn), _dto.sn);
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
            System.Reflection.MethodBase curr = System.Reflection.MethodBase.GetCurrentMethod();
            Factory.Run(dbContext =>
            {
                try
                {
                    System.Collections.Generic.List<v_zzp_Get_DL_DispatchList> _dtos = dbContext.v_zzp_Get_DL_DispatchList
                                .Where(w => w.iStatus == 2)
                                .ToList();

                    //请求
                    foreach (v_zzp_Get_DL_DispatchList _dto in _dtos)
                    {
                        try
                        {
                            var _tmp = new
                            {
                                workOrderName = _dto.workOrderName,
                                customerCode = _dto.customerCode,
                                sn = _dto.sn,
                                virtualSN = _dto.virtualSN,
                                deliveryTime = _dto.deliveryTime?.ToLong(),
                                en = _dto.en,
                                zh = _dto.zh,
                                synTime = DateTime.Now.ToLong(),
                                synPerson = "U8"
                            };

                            base.UpdatePost(dbContext, base.GetUrl(2, MyParams.UrlType.delivery), _tmp, nameof(dbContext.DL_DispatchList), nameof(_dto.sn), _dto.sn);
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
            System.Reflection.MethodBase curr = System.Reflection.MethodBase.GetCurrentMethod();
            Factory.Run(dbContext =>
            {
                try
                {
                    System.Collections.Generic.List<v_zzp_Get_DL_DispatchList> _dtos = dbContext.v_zzp_Get_DL_DispatchList
                                .Where(w => w.iStatus == 3)
                                .ToList();

                    //请求
                    foreach (v_zzp_Get_DL_DispatchList _dto in _dtos)
                    {
                        try
                        {
                            var _tmp = new
                            {
                                sn = _dto.sn,
                                virtualSN = _dto.virtualSN,
                                synTime = DateTime.Now.ToLong(),
                                synPerson = "U8"
                            };

                            base.DelPost(dbContext, base.GetUrl(3, MyParams.UrlType.delivery), _tmp, nameof(dbContext.DL_DispatchList), nameof(_dto.sn), _dto.sn);
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
