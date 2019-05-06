using FeiBo.Synchro.Core.Api;
using FeiBo.Synchro.Core.Api.Process;
using System;
using System.Threading.Tasks;
using System.Web.Http;

namespace FeiBo.Synchro.Api.Areas.ST.Controllers
{
    /// <summary>
    /// 红字材料出库单
    /// </summary>
    [Route("api/v1/stock/rdrecord11/{id:int?}")]
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
            return await Task.Run<ResultModel>(() =>
            {
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
        [HttpGet]
        public override async Task<ResultModel> Get(int id = -1)
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
        public override async Task<ResultModel> Update(RdrecordDTO dto)
        {
            return await Task.Run(() =>
            {
                return new ResultModel(0, "You're trying to update ");
            });
        }
        [HttpDelete]
        public override async Task<ResultModel> Delete(int id = -1)
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
