using System;
using System.Web.Http;
using System.Threading.Tasks;
using FeiBo.Synchro.Core.Api;
using FeiBo.Synchro.Core.Api.Process;

namespace FeiBo.Synchro.Api.Areas.ST.Controllers
{
    /// <summary>
    /// 产成品入库
    /// </summary>
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
                        IProcess process = new Rdrecord10();
                        return process.Invork(dto);
                    }
                    catch (Exception ex)
                    {
                        return base.common.ReJson(ex);
                    }
                });
            }

            [HttpPost]
            [System.ComponentModel.Description("创建-产成品入库")]
            public async Task<Core.RespModel> Add(object dto)
            {
                return await Task.Run<Core.RespModel>(() => {
                    try
                    {
                        return new Core.RespModel() {
                            respCode = "0000",
                            respDesc = "成功"
                        };
                    }
                    catch (Exception ex)
                    {
                        return new Core.RespModel() {
                            respCode = "8888",
                            respDesc = ex.Message
                        } ;
                    }
                });
            }
    }
}
