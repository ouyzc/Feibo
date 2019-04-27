using System;
using System.Threading.Tasks;
using System.Collections.Generic;
using FeiBo.Synchro.Core.Tools.Process;

namespace FeiBo.Synchro.Tools
{
    class Program
    {
            static void Main(string[] args)
            {
                //CancellationTokenSource ts = new CancellationTokenSource();
                //ts.Cancel();
                if (System.Diagnostics.Process.GetProcessesByName(System.Diagnostics.Process.GetCurrentProcess().ProcessName).Length > 1)
                {
                    Environment.Exit(0);
                }
                else {

                    List<Task> tasks = new List<Task>
                    {
                        Task.Run(() =>
                        {
                            IProcess process = new UnitProcess();
                            process.Invork();
                        }),
                        Task.Run(() =>
                        {
                            IProcess process = new CustomerProcess();
                            process.Invork();
                        }),
                    };
                    Task.WaitAll(tasks.ToArray());
                }
            }
    }
}
