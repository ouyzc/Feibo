using FeiBo.Synchro.Core.Tools.Process;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace FeiBo.Synchro.Tools
{
    internal class Program
    {
        private static void Main(string[] args)
        { 
            //CancellationTokenSource ts = new CancellationTokenSource();
            //ts.Cancel();
            ///判断线程,避免重复运行
            if (System.Diagnostics.Process.GetProcessesByName(System.Diagnostics.Process.GetCurrentProcess().ProcessName).Length > 1)
            {
                Environment.Exit(0);
            }
            else
            {
                ///声明线程集合
                Task.WaitAll(new List<Task>
                    {
                        //Task.Run(() =>
                        //{
                        //    IProcess process = new UnitProcess();//计量单位
                        //    process.Invork();
                        //}),
                        //Task.Run(() =>
                        //{
                        //    IProcess process = new CustomerProcess();//客户
                        //    process.Invork();
                        //}),
                        //Task.Run(() =>
                        //{
                        //    IProcess process = new VendorProcess();//供应商
                        //    process.Invork();
                        //}),
                        //Task.Run(() =>
                        //{
                        //    IProcess process = new DepartmentProcess();//部门
                        //    process.Invork();
                        //}),
                        //Task.Run(() =>
                        //{
                        //    IProcess process = new InventoryClassProcess();//存货分类
                        //    process.Invork();
                        //}),
                        //Task.Run(() =>
                        //{
                        //    IProcess process = new InventoryProcess();//存货
                        //    process.Invork();
                        //}),
                        //Task.Run(() =>
                        //{
                        //    IProcess process = new BomProcess();//BOM
                        //    process.Invork();
                        //}),
                        Task.Run(() =>
                        {
                            IProcess process = new WorkOrderProcess();//生产订单
                            process.Invork();
                        }),
                        //Task.Run(() =>
                        //{
                        //    IProcess process = new DeliveryProcess();//发货
                        //    process.Invork();
                        //}),
                    }.ToArray());
            }
        }
    }
}
