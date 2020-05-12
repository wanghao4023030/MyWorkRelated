using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SimulatePrint;
using System.Threading;
using log4net;
using System.Configuration;

namespace MultiThreadPrint
{
    class MultiThreadPrintClass
    {
        private SimulatePrintClass SimPrintObj = new SimulatePrintClass();
        CancellationTokenSource cts = new CancellationTokenSource();
        
        //public Boolean taskliveFlag = true ; 

        string ExecuteMode = ConfigurationManager.AppSettings["Model"];
        int ExecuteTime = Int32.Parse( ConfigurationManager.AppSettings["ExecuteTime"]);
        int ExecuteCount = Int32.Parse(ConfigurationManager.AppSettings["ExecuteCount"]);
        int PrintIntervalTime = Int32.Parse(ConfigurationManager.AppSettings["PrintIntervalTime"]);
        

        string ExecuteLoop = ConfigurationManager.AppSettings["Loop"];
        int ExecuteLoopCount = Int32.Parse(ConfigurationManager.AppSettings["LoopCount"]);
        int ExecuteLoopDelay = Int32.Parse(ConfigurationManager.AppSettings["LoopDelay"]);

        

        
        log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        public void StartThreadTask()
        {
            
            SimPrintObj.init();


            if (ExecuteLoop.ToUpper().Equals("FALSE"))
            {
                cts = new CancellationTokenSource();
                TaskFactory taskFactory = new TaskFactory();
                int count = Int32.Parse(SimPrintObj.WaterMark.threadCount);
                Task[] tasks = new Task[count];

                for (int i = 1; i <= count; i++)
                {
                    int taskID = i;
                    tasks[i - 1] = Task.Factory.StartNew(() => AddTask(cts.Token, taskID));

                    Console.Out.WriteLine("线程" + i + "启动中......" + " Thread " + i + " Start......");
                    log.Info("Thread" + i + "start......");
                    Thread.Sleep(5000);
                }

                taskFactory.ContinueWhenAll(tasks, TasksEnded, CancellationToken.None);
                log.Info("All Threads start......");
                check();
               
                Console.ReadKey();

            }

            if (ExecuteLoop.ToUpper().Equals("TRUE"))
            {
                
                TaskFactory taskFactory = new TaskFactory();
                int count = Int32.Parse(SimPrintObj.WaterMark.threadCount);
                Task[] tasks = new Task[count];

                for (int j = 0; j < ExecuteLoopCount; j++)
                {
                    cts = new CancellationTokenSource();
                    log.Info("Start loop " + (j + 1));
                    Console.Out.WriteLine("Start loop " + (j + 1));
                    for (int i = 1; i <= count; i++)
                    {
                        int taskID = i;
                        tasks[i - 1] = Task.Factory.StartNew(() => AddTask(cts.Token, taskID));
                        
                        Console.Out.WriteLine("线程" + i + "启动中......" + " Thread " + i + " Start......");
                        log.Info("Thread" + i + "start......");
                        Thread.Sleep(1000);
                    }

                    taskFactory.ContinueWhenAll(tasks, TasksEnded, CancellationToken.None);
                    
                    log.Info("All Threads start......");
                    check();
                    log.Info("End loop " + (j + 1));
                    Console.Out.WriteLine("End loop " + (j + 1));

                    Thread.Sleep(PrintIntervalTime * 2 * 1000);

                    if (j < ExecuteLoopCount - 1 )
                    { 

                        Console.Out.WriteLine(DateTime.Now);
                        Console.Out.WriteLine("delay " + ExecuteLoopDelay + " Minutes");
                        Thread.Sleep(ExecuteLoopDelay * 60 * 1000);
                        Console.Out.WriteLine(DateTime.Now);
                    }
 
               }

                Thread.Sleep(PrintIntervalTime * 2 * 1000);
                Console.Out.WriteLine("测试已结束，输入任何值退出....Input any values to quit");
                Console.ReadKey();
            }
            

        }



        public void AddTask(CancellationToken cancellationToken,int TaskID)
        {
               while (!cancellationToken.IsCancellationRequested)
                        {
                            SimPrintObj.SendDicom(TaskID);
                            Thread.Sleep(1000);
                        }

               Console.Out.WriteLine("线程：" + TaskID + " 已退出." + "Thread：" + TaskID + " has quit.");
               log.Debug("Thread：" + TaskID + " exit.");
               
            
        }




        public void check()
        {
            //Stop with parameter Time
            if (ExecuteMode.ToUpper().Equals("TIME"))
            {
                DateTime CurrentDatetime = DateTime.Now;
                Console.Out.WriteLine(CurrentDatetime.ToString());
                DateTime WantedDateTime = CurrentDatetime.AddMinutes(ExecuteTime);
                WantedDateTime = WantedDateTime.AddSeconds(1.5 * PrintIntervalTime);
                
                while (DateTime.Compare(CurrentDatetime, WantedDateTime) < 0)
                {
                    CurrentDatetime = DateTime.Now;
                    //Console.Out.WriteLine("Time is not arrived");
                    Thread.Sleep(1000);
                }
                
                Console.Out.WriteLine(DateTime.Now);
                cts.Cancel();
                //cts.Token.ThrowIfCancellationRequested();

                Console.Out.WriteLine("等待线程退出....Wait the thread to qiut...");

            }

            //Stop with parameter Count
            if (ExecuteMode.ToUpper().Equals("COUNT"))
            {
                Console.Out.WriteLine(ExecuteCount);
                while (SimPrintObj.PrintCount < ExecuteCount)
                {
                    Console.Out.WriteLine("{0} DICOM has printed. The goal is: {1}", SimPrintObj.PrintCount, ExecuteCount);
                    Thread.Sleep(1000);
                }
                Console.Out.WriteLine("{0} DICOM has printed. The goal is: {1}", SimPrintObj.PrintCount, ExecuteCount);
                Console.Out.WriteLine(DateTime.Now);
                cts.Cancel();
                
                Console.Out.WriteLine("等待线程退出....Wait the thread to qiut...");

            }

            //Stop by manual operations
            if (ExecuteMode.ToUpper().Equals("MANUAL"))
            { 
                Console.Out.WriteLine("输入 \'Exit\' 退出程序-Input \'Exit\' to quit.");
                string input = Console.ReadLine();
                if (input.Equals("Exit"))
                {
                    cts.Cancel();
                    Console.Out.WriteLine("等待线程退出....Wait the thread to qiut...");
                }
                else
                {
                    check();
                    
                }
            }


        }


        public void TasksEnded(Task[] tasks)
        {
                Console.WriteLine("等待所有线程退出，请等待！Wait all threads to quit.");
                Console.WriteLine("所有线程已退出！All Threads are quit.");
               // cts.Dispose();
                if (ExecuteLoop.ToUpper().Equals("FALSE"))
                {
                    Console.Out.WriteLine("输入任何值退出....Input any values to quit");
                }
            
        }




    }
}
