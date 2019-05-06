
namespace FeiBo.Synchro.Core.Api
{
    /// <summary>
    /// 采购/其他/产成品入库_rdrecord
    /// </summary>
    public class StoreIn
    {
        /// <summary>
        /// 指定header节点属性
        /// </summary>
        public class header
        {
            /// <summary>
            /// 收发记录主表ID
            /// </summary>
            public string id { get; set; }
            /// <summary>
            /// 收发标志
            /// </summary>
            public string receiveflag { get; set; }
            /// <summary>
            /// 单据类型
            /// </summary>
            public string vouchtype { get; set; }
            /// <summary>
            /// 业务类型
            /// </summary>
            public string businesstype { get; set; }
            /// <summary>
            /// 单据来源
            /// </summary>
            public string source { get; set; }
            /// <summary>
            /// 对应业务单号
            /// </summary>
            public string businesscode { get; set; }
            /// <summary>
            /// 仓库编码
            /// </summary>
            public string warehousecode { get; set; }
            /// <summary>
            /// 单据日期
            /// </summary>
            public string date { get; set; }
            /// <summary>
            /// 单据号
            /// </summary>
            public string code { get; set; }
            /// <summary>
            /// 零售来源单号
            /// </summary>
            public string sourcecodels { get; set; }
            /// <summary>
            /// 收发类别编码
            /// </summary>
            public string receivecode { get; set; }
            /// <summary>
            /// 部门编码
            /// </summary>
            public string departmentcode { get; set; }
            /// <summary>
            /// 职员编码
            /// </summary>
            public string personcode { get; set; }
            /// <summary>
            /// 采购类型编码
            /// </summary>
            public string purchasetypecode { get; set; }
            /// <summary>
            /// 销售类型编码
            /// </summary>
            public string saletypecode { get; set; }
            /// <summary>
            /// 客户编码
            /// </summary>
            public string customercode { get; set; }
            /// <summary>
            /// 供应商编码
            /// </summary>
            public string vendorcode { get; set; }
            /// <summary>
            /// 订单号
            /// </summary>
            public string ordercode { get; set; }
            /// <summary>
            /// 产量
            /// </summary>
            public string quantity { get; set; }
            /// <summary>
            /// 到货单号
            /// </summary>
            public string arrivecode { get; set; }
            /// <summary>
            /// 发票号
            /// </summary>
            public string billcode { get; set; }
            /// <summary>
            /// 发货单号
            /// </summary>
            public string consignmentcode { get; set; }
            /// <summary>
            /// 到货日期
            /// </summary>
            public string arrivedate { get; set; }
            /// <summary>
            /// 检验单号
            /// </summary>
            public string checkcode { get; set; }
            /// <summary>
            /// 检验日期
            /// </summary>
            public string checkdate { get; set; }
            /// <summary>
            /// 检验员
            /// </summary>
            public string checkperson { get; set; }
            /// <summary>
            /// 模版号
            /// </summary>
            public string templatenumber { get; set; }
            /// <summary>
            /// 生产批号
            /// </summary>
            public string serial { get; set; }
            /// <summary>
            /// 经手人
            /// </summary>
            public string handler { get; set; }
            /// <summary>
            /// 备注
            /// </summary>
            public string memory { get; set; }
            /// <summary>
            /// 制单人
            /// </summary>
            public string maker { get; set; }
            /// <summary>
            /// 审核人
            /// </summary>
            public string chandler { get; set; }
            /// <summary>
            /// 自定义字段
            /// </summary>
            public string define1 { get; set; }
            /// <summary>
            /// 自定义字段
            /// </summary>
            public string define2 { get; set; }
            /// <summary>
            /// 自定义字段
            /// </summary>
            public string define3 { get; set; }
            /// <summary>
            /// 自定义字段
            /// </summary>
            public string define4 { get; set; }
            /// <summary>
            /// 自定义字段
            /// </summary>
            public string define5 { get; set; }
            /// <summary>
            /// 自定义字段
            /// </summary>
            public string define6 { get; set; }
            /// <summary>
            /// 自定义字段
            /// </summary>
            public string define7 { get; set; }
            /// <summary>
            /// 自定义字段
            /// </summary>
            public string define8 { get; set; }
            /// <summary>
            /// 自定义字段
            /// </summary>
            public string define9 { get; set; }
            /// <summary>
            /// 自定义字段
            /// </summary>
            public string define10 { get; set; }
            /// <summary>
            /// 自定义字段
            /// </summary>
            public string define11 { get; set; }
            /// <summary>
            /// 自定义字段
            /// </summary>
            public string define12 { get; set; }
            /// <summary>
            /// 自定义字段
            /// </summary>
            public string define13 { get; set; }
            /// <summary>
            /// 自定义字段
            /// </summary>
            public string define14 { get; set; }
            /// <summary>
            /// 自定义字段
            /// </summary>
            public string define15 { get; set; }
            /// <summary>
            /// 自定义字段
            /// </summary>
            public string define16 { get; set; }
            /// <summary>
            /// 审核日期
            /// </summary>
            public string auditdate { get; set; }
            /// <summary>
            /// 税率
            /// </summary>
            public string taxrate { get; set; }
            /// <summary>
            /// 币种
            /// </summary>
            public string exchname { get; set; }
            /// <summary>
            /// 汇率
            /// </summary>
            public string exchrate { get; set; }
            /// <summary>
            /// 扣税类别
            /// </summary>
            public string discounttaxtype { get; set; }
            /// <summary>
            /// 联系人
            /// </summary>
            public string contact { get; set; }
            /// <summary>
            /// 电话
            /// </summary>
            public string phone { get; set; }
            /// <summary>
            /// 手机
            /// </summary>
            public string mobile { get; set; }
            /// <summary>
            /// 客户地址
            /// </summary>
            public string address { get; set; }
            /// <summary>
            /// 客户联系人电话
            /// </summary>
            public string conphone { get; set; }
            /// <summary>
            /// 客户联系手机
            /// </summary>
            public string conmobile { get; set; }
            /// <summary>
            /// 收货单位
            /// </summary>
            public string deliverunit { get; set; }
            /// <summary>
            /// 收货单位联系人
            /// </summary>
            public string contactname { get; set; }
            /// <summary>
            /// 收货单位联系人电话
            /// </summary>
            public string officephone { get; set; }
            /// <summary>
            /// 收货单位联系人手机
            /// </summary>
            public string mobilephone { get; set; }
            /// <summary>
            /// 业务员电话
            /// </summary>
            public string psnophone { get; set; }
            /// <summary>
            /// 业务员手机
            /// </summary>
            public string psnmobilephone { get; set; }
            /// <summary>
            /// 发货地址
            /// </summary>
            public string shipaddress { get; set; }
            /// <summary>
            /// 发货地址编码
            /// </summary>
            public string addcode { get; set; }
            /// <summary>
            /// 委外期初标志
            /// </summary>
            public string bomfirst { get; set; }
            /// <summary>
            /// 采购期初标志
            /// </summary>
            public string bpufirst { get; set; }
            /// <summary>
            /// 收付款协议编码
            /// </summary>
            public string cvenpuomprotocol { get; set; }
            /// <summary>
            /// 立账日
            /// </summary>
            public string dcreditstart { get; set; }
            /// <summary>
            /// 账期
            /// </summary>
            public string icreditperiod { get; set; }
            /// <summary>
            /// 到期日
            /// </summary>
            public string dgatheringdate { get; set; }
            /// <summary>
            /// 是否为立账单据
            /// </summary>
            public string bcredit { get; set; }
        }
        /// <summary>
        /// 指定entry节点属性
        /// </summary>
        public class entry
        {
            /// <summary>
            /// 收发记录主表关联项
            /// </summary>
            public string id { get; set; }
            /// <summary>
            /// 收发记录子表关联项
            /// </summary>
            public string autoid { get; set; }
            /// <summary>
            /// 条形码
            /// </summary>
            public string barcode { get; set; }
            /// <summary>
            /// 存货编码
            /// </summary>
            public string inventorycode { get; set; }
            /// <summary>
            /// 存货名称
            /// </summary>
            public string invname { get; set; }
            /// <summary>
            /// 自由项
            /// </summary>
            public string free1 { get; set; }
            /// <summary>
            /// 自由项
            /// </summary>
            public string free2 { get; set; }
            /// <summary>
            /// 自由项
            /// </summary>
            public string free3 { get; set; }
            /// <summary>
            /// 自由项
            /// </summary>
            public string free4 { get; set; }
            /// <summary>
            /// 自由项
            /// </summary>
            public string free5 { get; set; }
            /// <summary>
            /// 自由项
            /// </summary>
            public string free6 { get; set; }
            /// <summary>
            /// 自由项
            /// </summary>
            public string free7 { get; set; }
            /// <summary>
            /// 自由项
            /// </summary>
            public string free8 { get; set; }
            /// <summary>
            /// 自由项
            /// </summary>
            public string free9 { get; set; }
            /// <summary>
            /// 自由项
            /// </summary>
            public string free10 { get; set; }
            /// <summary>
            /// 应收（发）数量
            /// </summary>
            public string shouldquantity { get; set; }
            /// <summary>
            /// 应收（发）件数
            /// </summary>
            public string shouldnumber { get; set; }
            /// <summary>
            /// 数量（主记量数量）
            /// </summary>
            public string quantity { get; set; }
            /// <summary>
            /// 主计量单位名称
            /// </summary>
            public string cmassunitname { get; set; }
            /// <summary>
            /// 辅记量单位
            /// </summary>
            public string assitantunit { get; set; }
            /// <summary>
            /// 辅计量单位名称
            /// </summary>
            public string assitantunitname { get; set; }
            /// <summary>
            /// 换算率
            /// </summary>
            public string irate { get; set; }
            /// <summary>
            /// 件数
            /// </summary>
            public string number { get; set; }
            /// <summary>
            /// 单价
            /// </summary>
            public string price { get; set; }
            /// <summary>
            /// 金额
            /// </summary>
            public string cost { get; set; }
            /// <summary>
            /// 暂估单价
            /// </summary>
            public string facost { get; set; }
            /// <summary>
            /// 暂估金额
            /// </summary>
            public string iaprice { get; set; }
            /// <summary>
            /// 计划价售价
            /// </summary>
            public string plancost { get; set; }
            /// <summary>
            /// 计划金额或售价金额
            /// </summary>
            public string planprice { get; set; }
            /// <summary>
            /// 批号
            /// </summary>
            public string serial { get; set; }
            /// <summary>
            /// 生产日期
            /// </summary>
            public string makedate { get; set; }
            /// <summary>
            /// 失效日期
            /// </summary>
            public string validdate { get; set; }
            /// <summary>
            /// 调拨单子表ID号
            /// </summary>
            public string transitionid { get; set; }
            /// <summary>
            /// 发票子表ID号
            /// </summary>
            public string subbillcode { get; set; }
            /// <summary>
            /// 采购订单子表ID号
            /// </summary>
            public string subpurchaseid { get; set; }
            /// <summary>
            /// 货位
            /// </summary>
            public string position { get; set; }
            /// <summary>
            /// 项目大类编码
            /// </summary>
            public string itemclasscode { get; set; }
            /// <summary>
            /// 项目大类名称
            /// </summary>
            public string itemclassname { get; set; }
            /// <summary>
            /// 项目编码
            /// </summary>
            public string itemcode { get; set; }
            /// <summary>
            /// 项目名称
            /// </summary>
            public string itemname { get; set; }
            /// <summary>
            /// 表体自定义项
            /// </summary>
            public string define22 { get; set; }
            /// <summary>
            /// 表体自定义项
            /// </summary>
            public string define23 { get; set; }
            /// <summary>
            /// 表体自定义项
            /// </summary>
            public string define24 { get; set; }
            /// <summary>
            /// 表体自定义项
            /// </summary>
            public string define25 { get; set; }
            /// <summary>
            /// 表体自定义项
            /// </summary>
            public string define26 { get; set; }
            /// <summary>
            /// 表体自定义项
            /// </summary>
            public string define27 { get; set; }
            /// <summary>
            /// 表体自定义项
            /// </summary>
            public string define28 { get; set; }
            /// <summary>
            /// 表体自定义项
            /// </summary>
            public string define29 { get; set; }
            /// <summary>
            /// 表体自定义项
            /// </summary>
            public string define30 { get; set; }
            /// <summary>
            /// 表体自定义项
            /// </summary>
            public string define31 { get; set; }
            /// <summary>
            /// 表体自定义项
            /// </summary>
            public string define32 { get; set; }
            /// <summary>
            /// 表体自定义项
            /// </summary>
            public string define33 { get; set; }
            /// <summary>
            /// 表体自定义项
            /// </summary>
            public string define34 { get; set; }
            /// <summary>
            /// 表体自定义项
            /// </summary>
            public string define35 { get; set; }
            /// <summary>
            /// 表体自定义项
            /// </summary>
            public string define36 { get; set; }
            /// <summary>
            /// 表体自定义项
            /// </summary>
            public string define37 { get; set; }
            /// <summary>
            /// 发货单子表ID
            /// </summary>
            public string subconsignmentid { get; set; }
            /// <summary>
            /// 委托代销发货单子表
            /// </summary>
            public string delegateconsignmentid { get; set; }
            /// <summary>
            /// 生产订单子表ID
            /// </summary>
            public string subproducingid { get; set; }
            /// <summary>
            /// 检验单子表ID
            /// </summary>
            public string subcheckid { get; set; }
            /// <summary>
            /// 不良品处理单号
            /// </summary>
            public string cRejectCode { get; set; }
            /// <summary>
            /// 不良品处理单ID
            /// </summary>
            public string iRejectIds { get; set; }
            /// <summary>
            /// 检验员
            /// </summary>
            public string cCheckPersonCode { get; set; }
            /// <summary>
            /// 检验日期
            /// </summary>
            public string dCheckDate { get; set; }
            /// <summary>
            ///
            /// </summary>
            public string cCheckCode { get; set; }
            /// <summary>
            ///
            /// </summary>
            public string iMassDate { get; set; }
            /// <summary>
            /// 原币含税单价
            /// </summary>
            public string ioritaxcost { get; set; }
            /// <summary>
            /// 原币单价
            /// </summary>
            public string ioricost { get; set; }
            /// <summary>
            /// 原币金额
            /// </summary>
            public string iorimoney { get; set; }
            /// <summary>
            /// 原币税额
            /// </summary>
            public string ioritaxprice { get; set; }
            /// <summary>
            /// 原币价税合计
            /// </summary>
            public string iorisum { get; set; }
            /// <summary>
            /// 税率
            /// </summary>
            public string taxrate { get; set; }
            /// <summary>
            /// 本币税额
            /// </summary>
            public string taxprice { get; set; }
            /// <summary>
            /// 本币价税合计
            /// </summary>
            public string isum { get; set; }
            /// <summary>
            /// 保质期单位
            /// </summary>
            public string massunit { get; set; }
            /// <summary>
            /// 代管商编码
            /// </summary>
            public string vmivencode { get; set; }
            /// <summary>
            /// 材料费
            /// </summary>
            public string materialfee { get; set; }
            /// <summary>
            /// 加工费单价
            /// </summary>
            public string processcost { get; set; }
            /// <summary>
            /// 加工费
            /// </summary>
            public string processfee { get; set; }
            /// <summary>
            /// 核销日期
            /// </summary>
            public string dmsdate { get; set; }
            /// <summary>
            /// 属性1
            /// </summary>
            public string batchproperty1 { get; set; }
            /// <summary>
            /// 属性2
            /// </summary>
            public string batchproperty2 { get; set; }
            /// <summary>
            /// 属性3
            /// </summary>
            public string batchproperty3 { get; set; }
            /// <summary>
            /// 属性4
            /// </summary>
            public string batchproperty4 { get; set; }
            /// <summary>
            /// 属性5
            /// </summary>
            public string batchproperty5 { get; set; }
            /// <summary>
            /// 属性6
            /// </summary>
            public string batchproperty6 { get; set; }
            /// <summary>
            /// 属性7
            /// </summary>
            public string batchproperty7 { get; set; }
            /// <summary>
            /// 属性8
            /// </summary>
            public string batchproperty8 { get; set; }
            /// <summary>
            /// 属性9
            /// </summary>
            public string batchproperty9 { get; set; }
            /// <summary>
            /// 属性10
            /// </summary>
            public string batchproperty10 { get; set; }
            /// <summary>
            /// 有效期推算方式
            /// </summary>
            public string iexpiratdatecalcu { get; set; }
            /// <summary>
            /// 有效期計算項
            /// </summary>
            public string dexpirationdate { get; set; }
            /// <summary>
            /// 有效期至
            /// </summary>
            public string cexpirationdate { get; set; }
            /// <summary>
            /// 表体备注
            /// </summary>
            public string memory { get; set; }
        }
    }
}