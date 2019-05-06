using System;
namespace FeiBo.Synchro.Core.Api.Process
{
    /// <summary>
    /// 公共类
    /// </summary>
    public class Common
    {
        #region Back
        /// <summary>
        /// 回调
        /// </summary>
        /// <param name="errmsg">错误信息</param>
        /// <param name="dtocode">受影响编码</param>
        /// <returns>ResultModel对象</returns>
        public ResultModel ReJson(string errmsg, string dtocode)
        {
            MyParams.log.Write(errmsg, "Ex");
            return new ResultModel(errmsg, dtocode);
        }
        /// <summary>
        /// 回调
        /// </summary>
        /// <param name="errmsg">错误信息</param>
        /// <param name="errcode">错误编码</param>
        /// <returns>ResultModel对象</returns>
        public ResultModel ReJson(string errmsg, int errcode = -1)
        {
            MyParams.log.Write(errmsg, "Ex");
            return new ResultModel(errcode, errmsg);
        }
        /// <summary>
        /// 回调override1
        /// </summary>
        /// <param name="ex">异常对象</param>
        /// <returns>ResultModel对象</returns>
        public ResultModel ReJson(Exception ex)
        {
            MyParams.log.Write($"{ex.Message}\r\n\t{ex.StackTrace}", "ExFill");
            return ReJson(ExceptionExt.HandleEX(ex), -1);
        }
        /// <summary>
        /// 回调override2
        /// </summary>
        /// <param name="errmsg">错误信息</param>
        /// <param name="errcode">是否成功</param>
        /// <returns>ResultModel对象</returns>
        public ResultModel ReJson(string errmsg, bool flag)
        {
            return ReJson(errmsg, flag ? 0 : -1);
        }
        #endregion
        #region Common

        /// <summary>
        /// 请求数据
        /// </summary>
        /// <param name="roottag">类型</param>
        /// <param name="head">参数头</param>
        /// <param name="entrys">参数体</param>
        /// <returns>请求结果</returns>
        protected ResultModel EAI_Process(ZM.EAPI.EAI.Roottag roottag, dynamic head, dynamic entrys)
        {
            ZM.EAPI.EAI eai = new ZM.EAPI.EAI(MyParams.sender, roottag, MyParams.host);
            //拼接XML
            dynamic xml = eai.GetThree(head, entrys);
            MyParams.log.Write(xml, "To");
            //请求数据
            dynamic result = eai.SendProcess(xml);
            //记录日志
            MyParams.log.Write(result.responseText, "Back");
            return ReJson(result.errmsg, result.bflag);
        }

        /// <summary>
        /// 公共校验数据
        /// </summary>
        /// <param name="dto">数据载体</param>
        protected void VerifyDate(RdrecordDTO dto)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(dto.businesstype))
                {
                    throw new Exception("[业务类型]为空!");
                }

                if (string.IsNullOrWhiteSpace(dto.subproducingcode))
                {
                    throw new Exception("[工单号]为空!");
                }
                if (string.IsNullOrWhiteSpace(dto.maker))
                {
                    dto.maker = "MES";
                }
                if (string.IsNullOrWhiteSpace(dto.departmentcode))
                {
                    throw new Exception("[部门]为空!");
                }
                if (dto.dtos == null || dto.dtos?.Count == 0)
                {
                    throw new Exception("[表体数量]为空!");
                }
                foreach (RdrecordDTOs item in dto.dtos)
                {
                    if (string.IsNullOrWhiteSpace(item.inventorycode))
                    {
                        throw new Exception("[存货]为空!");
                    }

                    if (item.quantity == 0)
                    {
                        throw new Exception("[数量]为0!");
                    }

                    if (item.quantity < 0)
                    {
                        throw new Exception("数量必须大于0!");
                    }

                    if (string.IsNullOrWhiteSpace(item.define22))
                    {
                        throw new Exception("[生产序列号]为空!");
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("[验证失败]=>" + ex.Message);
            }
        }
        #endregion

    }
}