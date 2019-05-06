using FeiBo.Synchro.Core.Api;
using FeiBo.Synchro.Core.Api.Process;
using System.Threading.Tasks;
using System.Web.Http;

namespace FeiBo.Synchro.Api.Areas.ST.Controllers
{
    /// <summary>
    /// 公共控制器
    /// </summary>
    [Models.MyFilter]
    public abstract class CommonController : ApiController
    {
        /// <summary>
        /// 实例化公共方法对象
        /// </summary>
        protected Common common = new Common();
        /// <summary>
        /// 查询
        /// </summary>
        /// <param name="id">ID</param>
        /// <returns>回调模型</returns>
        public abstract Task<ResultModel> Get(int id = -1);
        /// <summary>
        /// 创建
        /// </summary>
        /// <param name="dto">数据载体</param>
        /// <returns>回调模型</returns>
        public abstract Task<ResultModel> Create(RdrecordDTO dto);
        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="dto">数据载体</param>
        /// <returns>回调模型</returns>
        public abstract Task<ResultModel> Update(RdrecordDTO dto);
        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="id">ID</param>
        /// <returns>回调模型</returns>
        public abstract Task<ResultModel> Delete(int id = -1);

    }
}
