

namespace FeiBo.Synchro.Core.Api.Process
{
    internal interface IMethod
    {
        ResultModel Create(RdrecordDTO dto);
        ResultModel Relation(RdrecordDTO dto);
    }
}
