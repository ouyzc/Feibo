
namespace FeiBo.Synchro.Core
{
    public class RespModel
    {
            /// <summary>
            /// 应答编码
            /// 成功：0000
            /// 失败：8888
            /// </summary>
            public string respCode { get; set; }
            /// <summary>
            /// 应答描述
            /// </summary>
            public string respDesc { get; set; }
    }
}
