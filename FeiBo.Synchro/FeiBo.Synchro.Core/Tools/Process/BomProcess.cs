using System;
using System.Linq;

namespace FeiBo.Synchro.Core.Tools.Process
{
    /// <summary>
    /// 客户
    /// </summary>
    public class BomProcess : Common, IProcess, IMethod
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
                            dbContext.p_zzp_load_AA_Bom();
                            break;

                        case 2:
                            dbContext.p_zzp_modify_AA_Bom();
                            break;

                        case 3:
                            dbContext.p_zzp_del_AA_Bom();
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
                    System.Collections.Generic.List<v_zzp_Get_AA_Bom> _dtos = dbContext.v_zzp_Get_AA_Bom
                                .Where(w => w.iStatus == 0)
                                .ToList();

                    //请求
                    foreach (v_zzp_Get_AA_Bom _dto in _dtos)
                    {
                        try
                        {
                            var _tmp = new
                            {
                                materialItem = _dto.materialItem,//物料 编码  Y
                                bomType = _dto.bomType,//物料清单类型
                                revision = _dto.revision,//版本
                                activeDate = _dto.activeDate?.ToLong(), //生效 日期
                                disableDate = _dto.disableDate?.ToLong(), //失效 日期
                                fromECN = _dto.fromECN,//ECN变 更单 号
                                bomBillComponent = dbContext.v_zzp_Take_AA_BomBillComponent//物 料清 单明细
                                .Where(w => w.BomId == _dto.BomId)
                                .Select(s => new
                                {
                                    s.opCode,//工序编码
                                        s.location,//物料位置
                                        s.componentItem,//物料编码
                                        s.componentQuantity,//使用数量
                                        s.lowQuantity,//最少使用数量
                                        s.highQuantity,//最多使用数量
                                        s.keyPartsFlag,//关键部件标  识
                                        s.trackerFlag,//追溯标识
                                        s.inputFlag,//可投产标识
                                        s.validateTime,//条码验证次  数
                                        s.en,//英 文 描述
                                        s.zh,//中 文 描述
                                        bomComponentSubstitute = dbContext.v_zzp_Take_AA_BomComponentSubstitute//替代料明细
                                    .Where(ww => ww.ComponentId == s.ComponentId)
                                    .Select(ss => new
                                    {
                                        ss.substituteItem,//物料编码
                                            ss.substituteQuantity,//使用数量
                                            ss.en,//英 文 描述
                                            ss.zh,//中 文 描述
                                        })
                                    .ToList()
                                })
                                .ToList(),////物料 清单 明细
                                en = _dto.en,//英 文 描述
                                zh = _dto.zh,//中 文 描述
                                synTime = DateTime.Now.ToLong(),//同步时间
                                synPerson = "U8"//同步人：即操作 人
                            };

                            base.AddPost(dbContext, base.GetUrl(1, MyParams.UrlType.bomMaterial), _tmp, nameof(dbContext.AA_Bom), nameof(_dto.BomId), _dto.BomId.ToString());
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
                    System.Collections.Generic.List<v_zzp_Get_AA_Bom> _dtos = dbContext.v_zzp_Get_AA_Bom
                                .Where(w => w.iStatus == 2)
                                .ToList();

                    //请求
                    foreach (v_zzp_Get_AA_Bom _dto in _dtos)
                    {
                        try
                        {
                            var _tmp = new
                            {
                                materialItem = _dto.materialItem,//物料 编码  Y
                                bomType = _dto.bomType,//物料清单类型
                                revision = _dto.revision,//版本
                                activeDate = _dto.activeDate?.ToLong(), //生效 日期
                                disableDate = _dto.disableDate?.ToLong(), //失效 日期
                                fromECN = _dto.fromECN,//ECN变 更单 号
                                bomBillComponent = dbContext.v_zzp_Take_AA_BomBillComponent//物 料清 单明细
                                .Where(w => w.BomId == _dto.BomId)
                                .Select(s => new
                                {
                                    s.opCode,//工序编码
                                        s.location,//物料位置
                                        s.componentItem,//物料编码
                                        s.componentQuantity,//使用数量
                                        s.lowQuantity,//最少使用数量
                                        s.highQuantity,//最多使用数量
                                        s.keyPartsFlag,//关键部件标  识
                                        s.trackerFlag,//追溯标识
                                        s.inputFlag,//可投产标识
                                        s.validateTime,//条码验证次  数
                                        s.en,//英 文 描述
                                        s.zh,//中 文 描述
                                        bomComponentSubstitute = dbContext.v_zzp_Take_AA_BomComponentSubstitute//替代料明细
                                    .Where(ww => ww.ComponentId == s.ComponentId)
                                    .Select(ss => new
                                    {
                                        ss.substituteItem,//物料编码
                                            ss.substituteQuantity,//使用数量
                                            ss.en,//英 文 描述
                                            ss.zh,//中 文 描述
                                        })
                                    .ToList()
                                })
                                .ToList(),////物料 清单 明细
                                en = _dto.en,//英 文 描述
                                zh = _dto.zh,//中 文 描述
                                synTime = DateTime.Now.ToLong(),//同步时间
                                synPerson = "U8"//同步人：即操作 人
                            };

                            base.UpdatePost(dbContext, base.GetUrl(2, MyParams.UrlType.bomMaterial), _tmp, nameof(dbContext.AA_Bom), nameof(_dto.BomId), _dto.BomId.ToString());
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
                    System.Collections.Generic.List<v_zzp_Get_AA_Bom> _dtos = dbContext.v_zzp_Get_AA_Bom
                                .Where(w => w.iStatus == 3)
                                .ToList();

                    //请求
                    foreach (v_zzp_Get_AA_Bom _dto in _dtos)
                    {
                        try
                        {
                            var _tmp = new
                            {
                                materialItem = _dto.materialItem,//物料 编码  Y
                                synTime = DateTime.Now.ToLong(),//同步时间
                                synPerson = "U8"//同步人：即操作 人
                            };

                            base.DelPost(dbContext, base.GetUrl(3, MyParams.UrlType.bomMaterial), _tmp, nameof(dbContext.AA_Bom), nameof(_dto.BomId), _dto.BomId.ToString());
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
