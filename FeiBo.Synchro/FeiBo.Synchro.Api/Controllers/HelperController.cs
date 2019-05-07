using System.Linq;
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
                             href= "http://zimoa.free.idcfengye.com/FeiBo/api/v1/stock/rdrecord10",
                        } ,
                        new{
                             title= "红字材料出库单",
                             href= "http://zimoa.free.idcfengye.com/FeiBo/api/v1/stock/rdrecord11",
                        } ,
                    }
                };
            });
        }

        [Route("api/log/{date?}")]
        [HttpGet]
        [HttpPost]
        public async Task<object> Log(string date = null)
        {
            return await Task.Run(() =>
            {
                System.Collections.Generic.List<Core.Log_Api> result = new System.Collections.Generic.List<Core.Log_Api>();
                string msg = "查询完成";
                Core.Factory.Run(dbContext =>
                {
                    if (date == null)
                        result = dbContext.Log_Api
                        .Where(w => w.dCreateTime >= System.DateTime.Today)
                        .OrderByDescending(o => o.dCreateTime)
                        .ToList();
                    else
                    {
                        if (date.Length != 8)
                            msg = "查询日期请符合yyyyMMdd";
                        else
                        {
                            date = date.Insert(4, "-");
                            date = date.Insert(7, "-");
                            if (!System.DateTime.TryParse(date, out System.DateTime dateTime))
                                msg = "查询日期异常!";
                            else
                                result = dbContext.Log_Api
                                .Where(w => w.dCreateTime > dateTime)
                                .Where(w => w.dCreateTime <= dateTime.AddDays(1))
                                .OrderByDescending(o => o.dCreateTime)
                                .ToList();
                        }
                    }

                });
                return new
                {
                    msg,
                    cnt = result.Count,
                    result
                };
            });
        }
    }
}
