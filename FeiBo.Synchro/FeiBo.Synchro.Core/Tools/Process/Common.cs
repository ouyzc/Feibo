
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;

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

        public string GetUrl(int op, MyParams.UrlType urlType) => (op switch
        {
            1 => $"{MyParams.baseUrl}/{urlType.ToString()}/insert",

            2 => $"{MyParams.baseUrl}/{urlType.ToString()}/update",

            3 => $"{MyParams.baseUrl}/{urlType.ToString()}/delete",

            _ => throw new Exception("op不在可识别范围内"),
        });

        /// <summary>
        /// POST请求
        /// </summary>
        /// <param name="url">请求地址</param>
        /// <param name="param">请求参数</param>
        /// <param name="postType">请求类型</param>
        /// <param name="headers">headersKV</param>
        /// <param name="cookies">cookies</param>
        /// <param name="timeout">超时时间(60000)</param>
        /// <returns></returns>
        public static string JSONPost(string url, object param, MyParams.PostType postType, IDictionary<string, string> headers = null, CookieCollection cookies = null, int timeout = 600000)
        {
            if (false == url?.StartsWith("http"))
            {
                throw new Exception("无法识别URL");
            }

            HttpWebRequest req = WebRequest.Create(url) as HttpWebRequest;
            req.Method = postType.ToString();
            req.ContentType = "application/json;charset=utf-8";
            req.Timeout = timeout;//请求超时时间

            if (cookies != null)
            {
                req.CookieContainer = new CookieContainer();
                req.CookieContainer.Add(cookies);
            }

            if (!(headers == null || headers.Count == 0))
                foreach (string key in headers.Keys)
                {
                    req.Headers.Add(key, headers[key]);
                }


            if (postType != MyParams.PostType.GET)
            {
                string json = JsonConvert.SerializeObject(new object[] { param });
                byte[] data = Encoding.UTF8.GetBytes(json);
                req.ContentLength = data.Length;
                using Stream reqStream = req.GetRequestStream();
                reqStream.Write(data, 0, data.Length);
                reqStream.Close();
            }

            HttpWebResponse resp = (HttpWebResponse)req.GetResponse();
            Stream stream = resp.GetResponseStream();
            using StreamReader reader = new StreamReader(stream, Encoding.UTF8);
            string result = reader.ReadToEnd();

            return result ?? "请求成功!返回NULL";

        }
        /// <summary>
        /// 发送请求
        /// </summary>
        /// <param name="url">地址</param>
        /// <param name="obj">对象</param>
        /// <param name="bDel">是否是删除请求</param>
        /// <returns></returns>
        private RespModel Post(string url, object obj, bool bDel = false)
        {
            string xx = JSONPost(url, obj, bDel ? MyParams.PostType.DELETE : MyParams.PostType.POST);

            return Newtonsoft.Json.JsonConvert.DeserializeObject<RespModel>(xx?.Substring(1, xx.Length - 2));
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
            RespModel resp = new RespModel()
            {
                respCode = "8888"
            };

            try
            {
                resp = Post(url, obj);
            }
            catch (Exception ex)
            {
                resp.respDesc = ExceptionExt.HandleEX(ex);
            }

            string _sql = $" UPDATE " +
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
            RespModel resp = new RespModel()
            {

                respCode = "8888"
            };

            try
            {
                resp = Post(url, obj);
            }
            catch (Exception ex)
            {
                resp.respDesc = ExceptionExt.HandleEX(ex);
            }

            string _sql = $" UPDATE " +
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
            RespModel resp = new RespModel()
            {

                respCode = "8888"
            };

            try
            {
                resp = Post(url, obj, true);
            }
            catch (Exception ex)
            {
                resp.respDesc = ExceptionExt.HandleEX(ex);
            }

            if (resp?.iStatus == 1)
            {
                string _dsql = $" DELETE " +
                               $" ZM_Dev..{table} " +
                               $" WHERE  {col}='{uid}';"
                               +
                               $" INSERT INTO ZM_Dev..Log_Del (cTable, cUID) " +
                               $" VALUES('{table}','{uid}');";
                dbContext.ExecuteCommand(_dsql);
            }
            else
            {
                string _sql = $" UPDATE " +
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
