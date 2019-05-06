using FeiBo.Synchro.Core.Api;
using FeiBo.Synchro.Core.Api.Process;
using System;
using System.Threading.Tasks;
using System.Web.Http;

namespace FeiBo.Synchro.Api.Areas.ST.Controllers
{
    /// <summary>
    /// 产成品入库
    /// </summary>
    [Route("api/v1/stock/rdrecord10/{id:int?}")]
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
            return await Task.Run<ResultModel>(() =>
            {
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
         
        [HttpGet]
        public async override Task<ResultModel> Get(int id = -1)
        {
            return await Task.Run(() =>
            {
                if (id == -1)
                {
                    return new ResultModel(0, "You're trying to find all");
                }
                return new ResultModel(0, "You're trying to find " + id);
            });
        }
        [HttpPatch]
        public async override Task<ResultModel> Update(RdrecordDTO dto)
        {
            return await Task.Run(() =>
            {
                return new ResultModel(0, "You're trying to update ");
            });
        }
        [HttpDelete]
        public async override Task<ResultModel> Delete(int id = -1)
        {
            return await Task.Run(() =>
            {
                if (id == -1)
                {
                    return new ResultModel(0, "The method of use is not standard, You must add id ");
                }
                return new ResultModel(0, "You're trying to delete " + id);
            });
        }
    }
}
