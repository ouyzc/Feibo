using System;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Http;
using FeiBo.Synchro.Api.Areas.ST.Models;

namespace FeiBo.Synchro.Api.Areas.ST.Controllers
{
    /// <summary>
    /// 产成品入库
    /// </summary>
    //[Api.Models.MyFilter]
    public class Rdrecord10Controller : CommonController
    {
            /// <summary>
            /// 创建-产成品入库
            /// </summary>
            /// <returns></returns>
            [HttpPost]
            [System.ComponentModel.Description("创建-产成品入库")]
            public override async Task<ResultModel> Create(RdrecordDTO dto)
            {
                return await Task.Run<ResultModel>(() => {
                    try
                    {
                        return base.common.Rdrecord10_Process(dto);
                    }
                    catch (Exception ex)
                    {
                        return base.common.ReJson(ex);
                    }
                });
            }
    }
}
