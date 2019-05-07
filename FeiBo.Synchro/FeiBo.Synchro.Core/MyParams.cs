
namespace FeiBo.Synchro.Core
{
    public class MyParams
    {
        public enum PostType
        { 
            GET,//查询
            POST,//添加
            PUT,//修改
            PATCH,//局部修改
            DELETE,//删除
        }
        /// <summary>
        /// MES接口方法地址
        /// </summary>
        public enum UrlType
        {
            unit,//3
            customer,//4
            vendor,//5
            department,//6
            materialType,//7
            materialItem,//8
            bomMaterial,//9
            workOrder,//10
            delivery//11
        }
        //TODO 测试阶段 baseUrl
        /// <summary>
        /// MES接口地址
        /// </summary>
        public static string baseUrl = "http://192.168.11.201:8080/rest";
        /// <summary>
        /// 帐套号
        /// </summary>
        public static string sender = "100";
        /// <summary>
        /// 请求端口
        /// </summary>
        public static string host = "192.168.37.129";
        /// <summary>
        /// 记录错误日志-API
        /// </summary>
        public static ZM.Core.Ext.LogExt log = new ZM.Core.Ext.LogExt("API", bEmpty: false);
    }
}
