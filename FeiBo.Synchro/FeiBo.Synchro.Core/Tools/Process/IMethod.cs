
namespace FeiBo.Synchro.Core.Tools.Process
{
    /// <summary>
    /// 对内规范接口
    /// </summary>
    interface IMethod
    {
        /// <summary>
        /// 加载
        /// </summary>
        /// <param name="op">操作值1-add,2-update,3-del</param>
        void Load(int op);
        /// <summary>
        /// 添加
        /// </summary>
        void Add();
        /// <summary>
        /// 修改
        /// </summary>
        void Modify();
        /// <summary>
        /// 删除
        /// </summary>
        void Del();
    }
}
