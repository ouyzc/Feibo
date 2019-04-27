

using System.Web;
using FeiBo.Synchro.Core;
using System.Web.Http.Filters;
using System.Web.Http.Controllers;
using FeiBo.Synchro.Core.Api.Process;

namespace FeiBo.Synchro.Api.Models
{
    public class MyFilter :  System.Web.Http.Filters.ActionFilterAttribute
    {
            /// <summary>
            /// 执行前
            /// </summary>
            /// <param name="actionContext">上下文</param>
            public override void OnActionExecuting(HttpActionContext actionContext)
            {
                base.OnActionExecuting(actionContext);
                var req = HttpContext.Current.Request;
                var dto = "";

                try
                {
                    dto = Newtonsoft.Json.JsonConvert.SerializeObject(actionContext.ActionArguments ?? new object());
                }
                catch { }

                Factory.Log_Api(new LogApiModel(0, "", req.CurrentExecutionFilePath, actionContext ? .ActionDescriptor ? .ControllerDescriptor ? .ControllerName, dto, req.UserHostAddress, "MES"));
            }
            /// <summary>
            /// 执行后
            /// </summary>
            /// <param name="actionExecutedContext"></param>
            public override void OnActionExecuted(HttpActionExecutedContext actionExecutedContext)
            {
                base.OnActionExecuted(actionExecutedContext);

                var req = HttpContext.Current.Request;

                try
                {
                    var _dto = new Core.Api.ResultModel();

                    try
                    {
                        _dto = Newtonsoft.Json.JsonConvert.DeserializeObject<Core.Api.ResultModel>(GetParams(actionExecutedContext) ?? "") ;
                    }
                    catch { }

                    Factory.Log_Api(new LogApiModel(_dto.errcode, _dto.errmsg, req.CurrentExecutionFilePath, actionExecutedContext ? .ActionContext ? .ActionDescriptor ? .ControllerDescriptor ? .ControllerName, "", req.UserHostAddress, "MES"));
                }
                catch { }

                if (actionExecutedContext.Exception != null)
                {
                    try
                    {
                        Factory.Log_Api(new LogApiModel(0, ExceptionExt.HandleEX(actionExecutedContext.Exception), req.CurrentExecutionFilePath, actionExecutedContext ? .ActionContext ? .ActionDescriptor ? .ControllerDescriptor ? .ControllerName, "", req.UserHostAddress, "MES"));
                    }
                    catch { }

                    HttpContext.Current.Response.ContentType = "application/json; charset=utf-8";
                    HttpContext.Current.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(new Common().ReJson(actionExecutedContext.Exception)));
                    HttpContext.Current.Response.End();
                }

            }

            /// <summary>
            /// 获取回调的参数
            /// </summary>
            /// <param name="actionExecutedContext"></param>
            /// <returns></returns>
            private string GetParams(HttpActionExecutedContext actionExecutedContext)
            {
                try
                {
                    if (actionExecutedContext ? .Request ? .Method ? .ToString() == "GET") {
                        return "GET请求,参数在URL上";
                    }
                    else
                    {
                        var stream = actionExecutedContext ? .Response ? .Content ? .ReadAsStreamAsync() ? .Result;
                        var result = stream == null ? "stream is null" : new System.IO.StreamReader(stream, System.Text.Encoding.UTF8) ? .ReadToEnd();

                        if (stream != null) {
                            stream.Position = 0;    //因为request和response读取完以后Position到最后一个位置，必须把stream的位置设为开始,不然交给下一个方法处理的时候就会读不到内容了。
                        }

                        return result;
                    }
                }
                catch (System.Exception ex)
                {
                    return ExceptionExt.HandleEX(ex);
                }
            }
    }
}