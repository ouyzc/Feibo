using System.Web.Mvc;

namespace FeiBo.Synchro.Api.Areas.ST
{
    public class STAreaRegistration : AreaRegistration
    {
        public override string AreaName => "ST";

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "ST_default",
                "ST/{controller}/{action}",
                new { action = "Index" }
            );
        }
    }
}