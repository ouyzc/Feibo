using FeiBo.Synchro.Api.Areas.ST.Models;
using System;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;

namespace FeiBo.Synchro.Api.Models
{
    public class MyFilter :  System.Web.Http.Filters.ActionFilterAttribute
    {
            //public override void OnActionExecuted(HttpActionExecutedContext actionExecutedContext)
            //{
            //    base.OnActionExecuted(actionExecutedContext);

            //    if (actionExecutedContext.Exception != null)
            //    {
            //        HttpContext.Current.Response.ContentType = "application/json; charset=utf-8";
            //        HttpContext.Current.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(new Common().ReJson(actionExecutedContext.Exception)));
            //        HttpContext.Current.Response.End();
            //    }

            //    GC.Collect();
            //}
            ///// <summary>
            ///// 执行前
            ///// </summary>
            ///// <param name="actionContext">上下文</param>
            //public override void OnActionExecuting(HttpActionContext actionContext)
            //{
            //    base.OnActionExecuting(actionContext);

            //    MyParams.logFilter.Write(HttpContext.Current.Request.UserHostAddress, "IP");
            //    MyParams.logFilter.Write(HttpContext.Current.Request.CurrentExecutionFilePath, "URL");
            //}
    }
}