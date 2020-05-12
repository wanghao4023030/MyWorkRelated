using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace CloseProcessByName
{
    class Program
    {
        [DllImport("kernel32.dll")]
        public static extern IntPtr OpenProcess(int dwDesiredAccess, bool bInheritHandle, int dwProcessId);




        static void Main(string[] args)
        {

            Process[] process = Process.GetProcessesByName("chrome");
            foreach (var p in process)
            {
                Console.WriteLine(p.Id);
                Console.ReadKey();

                p.CloseMainWindow();
                p.Close();
            }

            


        }
    }
}
