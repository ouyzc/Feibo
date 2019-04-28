
namespace FeiBo.Synchro.Core.Tools.Process
{
    public class Common
    {
            /// <summary>
            /// 获取接口地址
            /// </summary>
            /// <param name="op">操作值1-add,2-update,3-del</param>
            /// <param name="urlType">枚举类型</param>
            /// <returns></returns>
            public string GetUrl(int op, MyParams.UrlType urlType)
            {
                //TODO 测试阶段 url
                return MyParams.baseUrl + "Add";

                switch (op)
                {
                    case 1:
                        return $"{MyParams.baseUrl}/{urlType.ToString()}/insert";

                    case 2:
                        return $"{MyParams.baseUrl}/{urlType.ToString()}/update";

                    case 3:
                        return $"{MyParams.baseUrl}/{urlType.ToString()}/delete";
                };

                throw new System.Exception("op不在可识别范围内");
            }
            /// <summary>
            /// 发送请求
            /// </summary>
            /// <param name="url">地址</param>
            /// <param name="obj">对象</param>
            /// <returns></returns>
            private RespModel Post(string url, object obj)
            {
                //var xx = Newtonsoft.Json.JsonConvert.SerializeObject(obj);

                return Newtonsoft.Json.JsonConvert.DeserializeObject<RespModel>(ZM.Core.Request.JSONPost(url, obj));
            }
            /// <summary>
            /// 新增请求回写类
            /// </summary>
            /// <param name="dbContext">上下文</param>
            /// <param name="url">请求地址</param>
            /// <param name="obj">请求参数</param>
            /// <param name="table">表</param>
            /// <param name="col">主键名</param>
            /// <param name="uid">主键值</param>
            public void AddPost(TDBDataContext dbContext, string url, object obj, string table, string col, string uid)
            {
                var resp = Post(url, obj);
                var _sql = $" UPDATE " +
                           $" ZM_Dev..{table} " +
                           $" SET " +
                           $" iStatus={resp?.iStatus}," +
                           $" errcode='{resp?.respCode}'," +
                           $" errmsg='{resp?.respDesc}'," +
                           $" dPostTime=GETDATE()" +
                           $" WHERE  {col}='{uid}'";

                dbContext.ExecuteCommand(_sql);

            }

            /// <summary>
            /// 修改请求回写类
            /// </summary>
            /// <param name="dbContext">上下文</param>
            /// <param name="url">请求地址</param>
            /// <param name="obj">请求参数</param>
            /// <param name="table">表</param>
            /// <param name="col">主键名</param>
            /// <param name="uid">主键值</param>
            public void UpdatePost(TDBDataContext dbContext, string url, object obj, string table, string col, string uid)
            {
                var resp = Post(url, obj);
                var _sql = $" UPDATE " +
                           $" ZM_Dev..{table}" +
                           $" SET iStatus={resp?.iStatus}," +
                           $" errcode='{resp?.respCode}'," +
                           $" errmsg='{resp?.respDesc}'," +
                           $" dPostTime=GETDATE(), " +
                           $" bFlag=1," +
                           $" dUpdateTime=GETDATE()" +
                           $" WHERE  {col}='{uid}'";

                dbContext.ExecuteCommand(_sql);

            }

            /// <summary>
            /// 删除请求回写类
            /// </summary>
            /// <param name="dbContext">上下文</param>
            /// <param name="url">请求地址</param>
            /// <param name="obj">请求参数</param>
            /// <param name="table">表</param>
            /// <param name="col">主键名</param>
            /// <param name="uid">主键值</param>
            public void DelPost(TDBDataContext dbContext, string url, object obj, string table, string col, string uid)
            {
                var resp = Post(url, obj);

                if (resp ? .iStatus == 1)
                {
                    var _dsql = $" DELETE " +
                                $" ZM_Dev..{table} " +
                                $" WHERE  {col}='{uid}';"
                                +
                                $" INSERT INTO ZM_Dev..Log_Del (cTable, cUID) " +
                                $" VALUES('{table}','{uid}');";
                    dbContext.ExecuteCommand(_dsql);
                }
                else
                {
                    var _sql = $" UPDATE " +
                               $" ZM_Dev..{table} " +
                               $" SET " +
                               $" iStatus={resp?.iStatus}," +
                               $" errcode='{resp?.respCode}'," +
                               $" errmsg='{resp?.respDesc}'," +
                               $" dPostTime=GETDATE()  " +
                               $" WHERE  {col}='{uid}'";
                    dbContext.ExecuteCommand(_sql);
                }
            }
    }
}
