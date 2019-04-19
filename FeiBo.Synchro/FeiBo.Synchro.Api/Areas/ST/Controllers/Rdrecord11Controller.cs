using System;
using System.Web.Http;
using System.Threading.Tasks;
using FeiBo.Synchro.Api.Areas.ST.Models;

namespace FeiBo.Synchro.Api.Areas.ST.Controllers
{
    /// <summary>
    /// 红字材料出库单
    /// </summary>
    //[Api.Models.MyFilter]
    public class Rdrecord11Controller : CommonController
    {
            /// <summary>
            /// 创建-红字材料出库单
            /// </summary>
            /// <returns></returns>
            [HttpPost]
            [System.ComponentModel.Description("创建-红字材料出库单")]
            public override async Task<ResultModel> Create(RdrecordDTO dto)
            {
                return await Task.Run<ResultModel>(() => {
                    try
                    {
                        return base.common.Rdrecord11_Process(dto);
                    }
                    catch (Exception ex)
                    {
                        return base.common.ReJson(ex);
                    }
                });
            }
    }
}
