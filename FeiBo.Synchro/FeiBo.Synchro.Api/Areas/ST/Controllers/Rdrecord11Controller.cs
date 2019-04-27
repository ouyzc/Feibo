using System;
using System.Web.Http;
using System.Threading.Tasks;
using FeiBo.Synchro.Core.Api;
using FeiBo.Synchro.Core.Api.Process;

namespace FeiBo.Synchro.Api.Areas.ST.Controllers
{
    /// <summary>
    /// 红字材料出库单
    /// </summary>
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
                        IProcess process = new Rdrecord11();
                        return process.Invork(dto);
                    }
                    catch (Exception ex)
                    {
                        return base.common.ReJson(ex);
                    }
                });
            }
    }
}
