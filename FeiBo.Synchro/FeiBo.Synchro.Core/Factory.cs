using System;

namespace FeiBo.Synchro.Core
{
    public class Factory
    {
            public static void Run(Action<TDBDataContext> dbContext)
            {
                using (TDBDataContext dataContext = new TDBDataContext())
                {
                    dbContext(dataContext);
                }
            }
            public static void Log(LogToolsModel log)
            {
                using (TDBDataContext dbContext = new TDBDataContext())
                {
                    dbContext.p_zzp_log_tools(log.cType, log.cMethod, log.errcode, log.errmsg);
                }
            }
            public static void Log_Api(LogApiModel log)
            {
                using (TDBDataContext dbContext = new TDBDataContext())
                {
                    dbContext.p_zzp_log_api(log.ip, log.cIdentity, log.cType, log.cMethod, log.errcode, log.errmsg, log.cParams);
                }
            }

    }
}
