using System;

namespace FeiBo.Synchro.Core
{
    public static class DateTimeExtend
    {
            /// <summary>
            /// 将c# DateTime时间格式转换为Unix时间戳格式
            /// </summary>
            /// <param name="time">时间</param>
            /// <returns>long</returns>
            public static long ToLong(this System.DateTime time)
            {
                System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1, 0, 0, 0, 0));
                long t = (time.Ticks - startTime.Ticks) / 10000;   //除10000调整为13位
                return t;
            }
            /// <summary>
            /// 时间戳转为C#格式时间
            /// </summary>
            /// <param name="time"></param>
            /// <returns></returns>
            public static DateTime ToDateTime(this long timeStamp)
            {
                DateTime dtStart = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));
                long lTime = long.Parse(timeStamp + "0000");
                TimeSpan toNow = new TimeSpan(lTime);
                return dtStart.Add(toNow);
            }
            /// <summary>
            /// 时间戳转为C#格式时间
            /// </summary>
            /// <param name="time"></param>
            /// <returns></returns>
            public static string ToDateStr(this long timeStamp)
            {
                return timeStamp.ToDateTime().ToString("yyyy-MM-dd");
            }
            /// <summary>
            /// 时间戳转为C#格式时间
            /// </summary>
            /// <param name="time"></param>
            /// <returns></returns>
            public static string ToDateTimeStr(this long timeStamp)
            {
                return timeStamp.ToDateTime().ToString("yyyy-MM-dd HH:mm:ss");
            }
    }
}
