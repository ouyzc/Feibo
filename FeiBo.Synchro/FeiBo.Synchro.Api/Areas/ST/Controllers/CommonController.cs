using System.Web.Http;
using FeiBo.Synchro.Core.Api;
using System.Threading.Tasks;
using FeiBo.Synchro.Core.Api.Process;

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
            /// 创建
            /// </summary>
            /// <param name="dto">数据载体</param>
            /// <returns>回调模型</returns>
            public abstract Task<ResultModel>  Create(RdrecordDTO dto);

    }
}
