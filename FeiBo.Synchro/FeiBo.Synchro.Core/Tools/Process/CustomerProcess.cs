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
                            dbContext.p_zzp_load_AA_Customer();
                            break;

                        case 2:
                            dbContext.p_zzp_modify_AA_Customer();
                            break;

                        case 3:
                            dbContext.p_zzp_del_AA_Customer();
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
                    System.Collections.Generic.List<v_zzp_Get_AA_Customer> _dtos = dbContext.v_zzp_Get_AA_Customer
                                .Where(w => w.iStatus == 0)
                                .ToList();

                    //请求
                    foreach (v_zzp_Get_AA_Customer _dto in _dtos)
                    {
                        try
                        {
                            var _tmp = new
                            {
                                customerCode = _dto.customerCode,//客户编码
                                customerName = _dto.customerName,//客户名称
                                address = _dto.address,//地址
                                contactor = _dto.contactor,//联系人
                                phone = _dto.phone,//联系电话
                                description = _dto.description,//描述
                                en = _dto.en,//英文描述
                                zh = _dto.zh,//中文描述
                                synTime = DateTime.Now.ToLong(),//同步时间
                                synPerson = "U8"//同步人：即操作 人
                            };

                            base.AddPost(dbContext, base.GetUrl(1, MyParams.UrlType.customer), _tmp, nameof(dbContext.AA_Customer), nameof(_dto.customerCode), _dto.customerCode);
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
                    System.Collections.Generic.List<v_zzp_Get_AA_Customer> _dtos = dbContext.v_zzp_Get_AA_Customer
                                .Where(w => w.iStatus == 2)
                                .ToList();

                    //请求
                    foreach (v_zzp_Get_AA_Customer _dto in _dtos)
                    {
                        try
                        {
                            var _tmp = new
                            {
                                customerCode = _dto.customerCode,//客户编码
                                customerName = _dto.customerName,//客户名称
                                address = _dto.address,//地址
                                contactor = _dto.contactor,//联系人
                                phone = _dto.phone,//联系电话
                                description = _dto.description,//描述
                                en = _dto.en,//英文描述
                                zh = _dto.zh,//中文描述
                                synTime = DateTime.Now.ToLong(),//同步时间
                                synPerson = "U8"//同步人：即操作 人
                            };

                            base.UpdatePost(dbContext, base.GetUrl(2, MyParams.UrlType.customer), _tmp, nameof(dbContext.AA_Customer), nameof(_dto.customerCode), _dto.customerCode);
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
                    System.Collections.Generic.List<v_zzp_Get_AA_Customer> _dtos = dbContext.v_zzp_Get_AA_Customer
                                .Where(w => w.iStatus == 3)
                                .ToList();

                    //请求
                    foreach (v_zzp_Get_AA_Customer _dto in _dtos)
                    {
                        try
                        {
                            var _tmp = new
                            {
                                customerCode = _dto.customerCode,//客户编码
                                synTime = DateTime.Now.ToLong(),//同步时间
                                synPerson = "U8"//同步人：即操作 人
                            };

                            base.DelPost(dbContext, base.GetUrl(3, MyParams.UrlType.customer), _tmp, nameof(dbContext.AA_Customer), nameof(_dto.customerCode), _dto.customerCode);
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
