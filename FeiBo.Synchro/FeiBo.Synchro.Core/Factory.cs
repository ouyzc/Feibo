using System;

namespace FeiBo.Synchro.Core
{
    /// <summary>
    /// 上下文工厂
    /// </summary>
    public class Factory
    {
        /// <summary>
        /// 执行
        /// </summary>
        /// <param name="dbContext">上下文对象</param>
        public static void Run(Action<TDBDataContext> dbContext)
        {
            using (TDBDataContext dataContext = new TDBDataContext())
            { 
                dbContext(dataContext);
            }
        }
        /// <summary>
        /// 记录Tools日志
        /// </summary>
        /// <param name="log"></param>
        public static void Log(LogToolsModel log)
        {
            using (TDBDataContext dbContext = new TDBDataContext())
            {
                dbContext.p_zzp_log_tools(log.cType, log.cMethod, log.errcode, log.errmsg);
            }
        }
        /// <summary>
        ///记录Api日志
        /// </summary>
        /// <param name="log"></param>
        public static void Log_Api(LogApiModel log)
        {
            using (TDBDataContext dbContext = new TDBDataContext())
            {
                dbContext.p_zzp_log_api(log.ip, log.cIdentity, log.cType, log.cMethod, log.errcode, log.errmsg, log.cParams);
            }
        }

    }
}
