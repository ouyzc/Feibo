

namespace FeiBo.Synchro.Core.Api.Process
{
    internal interface IMethod
    {
        ResultModel Create(RdrecordDTO dto);
        void Relation(ResultModel result, RdrecordDTO dto);
    }
}
