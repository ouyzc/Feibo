
namespace FeiBo.Synchro.Core.Tools.Process
{
    public class Common
    {
            /// <summary>
            /// 请求回写类
            /// </summary>
            /// <param name="dbContext">上下文</param>
            /// <param name="url">请求地址</param>
            /// <param name="obj">请求参数</param>
            /// <param name="table">表</param>
            /// <param name="condition">条件</param>
            public void Post(TDBDataContext dbContext, string url, object obj, string table, string condition)
            {
                var resp = Newtonsoft.Json.JsonConvert.DeserializeObject<RespModel>(ZM.Core.Request.JSONPost(url, obj));

                dbContext.ExecuteCommand($"UPDATE ZM_Dev..{table} SET iStatus={(resp.respCode=="0000" ? 1:-1)},errcode='{resp.respCode}',errmsg='{resp.respDesc}',dPostTime=GETDATE() WHERE  {condition}");
            }
    }
}
