using System;
using System.Collections.Generic;
/// <summary>
///  模型类
/// </summary>

namespace FeiBo.Synchro.Api.Areas.ST.Models
{
    /// <summary>
    /// 返回格式
    /// </summary>
    public class ResultModel
    {
            /// <summary>
            /// 错误编码
            /// </summary>
            public int errcode { get; set; }
            /// <summary>
            /// 错误信息
            /// </summary>
            public string errmsg { get; set; }
            /// <summary>
            /// 空构造
            /// </summary>

            public ResultModel() { }
            /// <summary>
            /// 带参构造
            /// </summary>
            /// <param name="errcode">错误编码</param>
            /// <param name="errmsg">错误信息</param>
            public ResultModel(int errcode, string errmsg)
            {
                this.errcode = errcode;
                this.errmsg = errmsg;
            }

    }
    /// <summary>
    /// 表头
    /// </summary>
    public class RdrecordDTO
    {
            /// <summary>
            /// 单据日期
            /// </summary>
            public string date { get; set; } = DateTime.Now.ToString("yyyy-MM-dd");
            /// <summary>
            /// 单据号
            /// </summary>
            public string code { get; set; }
            /// <summary>
            /// 业务类型
            /// </summary>
            public string businesstype { get; set; }
            /// <summary>
            /// 仓库编码
            /// </summary>
            public string warehousecode { get; set; }
            /// <summary>
            /// 生产订单号
            /// </summary>
            public string subproducingcode { get; set; }
            /// <summary>
            /// 部门编码
            /// </summary>
            public string departmentcode { get; set; }
            /// <summary>
            /// 业务员编码
            /// </summary>
            public string personcode { get; set; }
            /// <summary>
            /// 制单人
            /// </summary>
            public string maker { get; set; } = "MES";
            /// <summary>
            /// 备注
            /// </summary>
            public string memory { get; set; }
            /// <summary>
            /// 预留关联 1
            /// </summary>
            public string auth_define1 { get; set; }
            /// <summary>
            /// 预留关联 2
            /// </summary>
            public string auth_define2 { get; set; }
            /// <summary>
            /// 预留关联 3
            /// </summary>
            public string auth_define3 { get; set; }
            /// <summary>
            /// 关联 1
            /// </summary>
            public string define1 { get; set; }
            /// <summary>
            /// 关联 2
            /// </summary>
            public string define2 { get; set; }
            /// <summary>
            /// 关联 3
            /// </summary>
            public string define3 { get; set; }
            /// <summary>
            /// 表体
            /// </summary>
            public List<RdrecordDTOs> dtos { get; set; }

    }
    /// <summary>
    /// 表体
    /// </summary>
    public class RdrecordDTOs
    {
            /// <summary>
            /// 存货编码
            /// </summary>
            public string inventorycode { get; set; }
            /// <summary>
            /// 产量
            /// </summary>
            public int quantity { get; set; }
            /// <summary>
            /// 生产批号
            /// </summary>
            public string serial { get; set; }
            /// <summary>
            /// 项目大类编码
            /// </summary>
            public string itemclasscode { get; set; }
            /// <summary>
            /// 项目编码
            /// </summary>
            public string itemcode { get; set; }
            /// <summary>
            /// 生产序列号
            /// </summary>
            public string define22 { get; set; }
            /// <summary>
            /// 产品大类
            /// </summary>
            public string define24 { get; set; }
            /// <summary>
            /// 生产订单子表 ID
            /// </summary>
            public string subproducingid { get; set; }
            /// <summary>
            /// 生产订单子表行号
            /// </summary>
            public int subproducingrowno { get; set; }
            /// <summary>
            /// 备注
            /// </summary>
            public string memory { get; set; }
            /// <summary>
            /// 预留关联 1
            /// </summary>
            public string auth_define1 { get; set; }
            /// <summary>
            /// 预留关联 2
            /// </summary>
            public string auth_define2 { get; set; }
            /// <summary>
            /// 预留关联 3
            /// </summary>
            public string auth_define3 { get; set; }
            /// <summary>
            /// 关联 1
            /// </summary>
            public string define1 { get; set; }
            /// <summary>
            /// 关联 2
            /// </summary>
            public string define2 { get; set; }
            /// <summary>
            /// 关联 3
            /// </summary>
            public string define3 { get; set; }
    }
}