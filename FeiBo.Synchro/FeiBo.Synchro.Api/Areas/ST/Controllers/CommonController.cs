using System.Web.Http;
using System.Threading.Tasks;
using FeiBo.Synchro.Api.Areas.ST.Models;
namespace FeiBo.Synchro.Api.Areas.ST.Controllers
{
    /// <summary>
    /// 公共控制器
    /// </summary>
    public abstract class CommonController : ApiController
    {
            /// <summary>
            /// 实例化公共方法对象
            /// </summary>
            protected Common common = new Common();
            /// <summary>
            /// TDB上下文对象
            /// </summary>
            protected TDBDataContext tdb = new TDBDataContext();
            /// <summary>
            /// 创建
            /// </summary>
            /// <param name="dto">数据载体</param>
            /// <returns>回调模型</returns>
            public abstract Task<ResultModel>  Create(RdrecordDTO dto);

    }
}
