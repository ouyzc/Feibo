namespace FeiBo.Synchro.Api.Models
{
    public class MyParams
    {
            /// <summary>
            /// 帐套号
            /// </summary>
            public static string sender = "201";
            /// <summary>
            /// 请求端口
            /// </summary>
            public static string host = "192.168.28.128";//"120.55.47.63";
            /// <summary>
            /// 记录日志
            /// </summary>
            public static ZM.Core.Ext.LogExt log = new ZM.Core.Ext.LogExt("Ex", bEmpty: false);
            /// <summary>
            /// 记录日志
            /// </summary>
            public static ZM.Core.Ext.LogExt logFilter = new ZM.Core.Ext.LogExt("Filter", bEmpty: false);
    }
}