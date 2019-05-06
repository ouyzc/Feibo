

namespace FeiBo.Synchro.Core
{
    /// <summary>
    /// 异常扩展
    /// </summary>
    public class ExceptionExt
    {
        /// <summary>
        /// 处理异常
        /// </summary>
        /// <param name="ex">异常对象</param>
        /// <returns></returns>
        public static string HandleEX(System.Exception ex)
        {
            if (ex?.InnerException == null)
            {
                return ex?.Message;
            }
            else
            {
                return HandleEX(ex?.InnerException);
            }
        }
    }
}
