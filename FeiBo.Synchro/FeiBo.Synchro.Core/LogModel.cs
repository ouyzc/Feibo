
namespace FeiBo.Synchro.Core
{
    public class LogModel
    {

    }
    public class LogToolsModel
    {
            public string cType { get; set; }
            public string cMethod { get; set; }
            public int errcode { get; set; }
            public string errmsg { get; set; }
            public LogToolsModel() {  }
            public LogToolsModel(int errcode, string errmsg, string cType, string cMethod) {
                this.cType = cType;
                this.cMethod = cMethod;
                this.errcode = errcode;
                this.errmsg = errmsg;
            }
    }
    public class LogApiModel
    {
            public string ip{ get; set; }
            public string cIdentity{ get; set; }
            public string cType{ get; set; }
            public string cMethod{ get; set; }
            public int errcode { get; set; }
            public string errmsg { get; set; }
            public string cParams { get; set; }

            public LogApiModel()   {   }
            public LogApiModel(int errcode, string errmsg, string cMethod, string cType, string cParams, string ip, string cIdentity) {
                this.errcode = errcode;
                this.errmsg = errmsg;
                this.cMethod = cMethod;
                this.cType = cType;
                this.cParams = cParams;
                this.ip = ip;
                this.cIdentity = cIdentity;
            }
    }
}
