using System.Web.Http;
using System.Web.Mvc;
using System.Web.Routing;

namespace FeiBo.Synchro.Api
{
    public class WebApiApplication : System.Web.HttpApplication
    {
            protected void Application_Start()
            {
                AreaRegistration.RegisterAllAreas();
                GlobalConfiguration.Configure(WebApiConfig.Register);
                FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
                RouteConfig.RegisterRoutes(RouteTable.Routes);
            }
    }
}
