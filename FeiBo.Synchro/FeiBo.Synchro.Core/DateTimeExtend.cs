using System;

namespace FeiBo.Synchro.Core
{
    /// <summary>
    /// 日期时间扩展
    /// </summary>
    public static class DateTimeExtend
    {
        /// <summary>
        /// 将c# DateTime时间格式转换为Unix时间戳格式
        /// </summary>
        /// <param name="time">DateTime 类型时间</param>
        /// <returns>long</returns>
        public static long? ToLong(this System.DateTime? time)
        {
            if (time == null)
            {
                return null;
            }

            if (time == Convert.ToDateTime("1900/1/1 0:00:00"))
            {
                return null;
            }

            System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1, 0, 0, 0, 0));
            long t = (long)(time?.Ticks - startTime.Ticks) / 10000; //除10000调整为13位
            return t;
        }
        /// <summary>
        /// 将c# DateTime时间格式转换为Unix时间戳格式
        /// </summary>
        /// <param name="time">DateTime 类型时间</param>
        /// <returns>long</returns>
        public static long? ToLong(this System.DateTime time)
        {
            if (time == null)
            {
                return null;
            }

            if (time == Convert.ToDateTime("1900/1/1 0:00:00"))
            {
                return null;
            }

            System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1, 0, 0, 0, 0));
            long t = (time.Ticks - startTime.Ticks) / 10000; //除10000调整为13位
            return t;
        }
        /// <summary>
        /// 时间戳转为C#格式时间
        /// </summary>
        /// <param name="timeStamp">long 类型时间戳</param>
        /// <returns></returns>
        public static DateTime? ToDateTime(this long? timeStamp)
        {
            if (timeStamp == null)
            {
                return null;
            }

            DateTime dtStart = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));
            long lTime = long.Parse(timeStamp + "0000");
            TimeSpan toNow = new TimeSpan(lTime);
            return dtStart.Add(toNow);
        }
        /// <summary>
        /// 时间戳转为C#格式时间
        /// </summary>
        /// <param name="timeStamp">long 类型时间戳</param>
        /// <returns></returns>
        public static string ToDateStr(this long? timeStamp)
        {
            if (timeStamp == null)
            {
                return null;
            }

            return timeStamp.ToDateTime()?.ToString("yyyy-MM-dd");
        }
        /// <summary>
        /// 时间戳转为C#格式时间
        /// </summary>
        /// <param name="timeStamp">long 类型时间戳</param>
        /// <returns></returns>
        public static string ToDateTimeStr(this long? timeStamp)
        {
            if (timeStamp == null)
            {
                return null;
            }

            return timeStamp.ToDateTime()?.ToString("yyyy-MM-dd HH:mm:ss");
        }
    }
}
