using System.Web.Mvc;

namespace FeiBo.Synchro.Api
{
    public class FilterConfig
    {
            public static void RegisterGlobalFilters(GlobalFilterCollection filters)
            {
                filters.Add(new HandleErrorAttribute());
            }
    }
}
