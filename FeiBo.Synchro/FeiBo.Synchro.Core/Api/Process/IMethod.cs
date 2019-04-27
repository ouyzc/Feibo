

namespace FeiBo.Synchro.Core.Api.Process
{
    interface IMethod
    {
        ResultModel Create(RdrecordDTO dto);
        ResultModel Relation(RdrecordDTO dto);
    }
}
