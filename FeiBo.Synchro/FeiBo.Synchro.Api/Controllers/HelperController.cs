using System.Threading.Tasks;
using System.Web.Http;

namespace FeiBo.Synchro.Api.Controllers
{
    public class HelperController : ApiController
    {
        [Route("api")]
        [HttpGet]
        [HttpPost]
        public async Task<object> All()
        {
            return await Task.Run(() =>
            {
                return new
                {
                    authorization = "-",
                    type = "application/json; charset=utf-8",
                    links = new object[] {
                        new{
                             title= "产成品入库单",
                             href= "http://api/v1/stock/rdrecord10",
                        } ,
                        new{
                             title= "红字材料出库单",
                             href= "http://api/v1/stock/rdrecord11",
                        } ,
                    }
                };
            });
        }
    }
}
