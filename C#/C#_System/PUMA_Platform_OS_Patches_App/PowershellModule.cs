using System;
using System.Diagnostics;


namespace PUMA_Platform_OS_Patches_App
{
    /*
     * The module to use powershell.exe execute the script or command in the application
     */
    class PowershellModule
    {
        /*
         Define a function to Execute the PS command or scrips with process.
         Note: Must set the Execute polocy to localmachine, then it can execute the scripts.
         You can use open the settings use the functions <SetLocalMacheCanExecuteScript(), SetLocalMacheCanNotExecuteScript()>
             */
        public string ExecutePSByProcess(string arg)
        {
            Process powershell_process = new Process();
            powershell_process.StartInfo.FileName = "powershell.exe";
            powershell_process.StartInfo.UseShellExecute = false;
            powershell_process.StartInfo.RedirectStandardOutput = true;
            powershell_process.StartInfo.RedirectStandardError = true;
            powershell_process.StartInfo.CreateNoWindow = true;
            powershell_process.StartInfo.Arguments = arg;
            powershell_process.Start();
            var output = powershell_process.StandardOutput.ReadToEnd();
            powershell_process.WaitForExit();
            powershell_process.Close();
            powershell_process.Dispose();
            return output;
        }


        /*
         * Set the local machine can execute the PS script.
         */

        public Boolean SetLocalMacheCanExecuteScript()
        {
            string PSCommandString = "Set-ExecutionPolicy -Scope LocalMachine Unrestricted";
            string PSResultCheckString = "Get-ExecutionPolicy -Scope LocalMachine";

            string CanExecutePSScript = ExecutePSByProcess(PSResultCheckString).Trim();

            if (CanExecutePSScript.Equals("Unrestricted"))
            {
                return true;
            }
            else
            {
                ExecutePSByProcess(PSCommandString);
                CanExecutePSScript = ExecutePSByProcess(PSResultCheckString).Trim();

                if (CanExecutePSScript.Equals("Unrestricted"))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        
        }


        /*
         *Reset the local configuration to cannot execute PS script in local machine. 
         */
        public Boolean SetLocalMacheCanNotExecuteScript()
        {
            string PSCommandString = "Set-ExecutionPolicy -Scope LocalMachine Undefined";
            string PSResultCheckString = "Get-ExecutionPolicy -Scope LocalMachine";

            string CanExecutePSScript = ExecutePSByProcess(PSResultCheckString).Trim();

            if (CanExecutePSScript.Equals("Undefined"))
            {
                return true;
            }
            else
            {
                ExecutePSByProcess(PSCommandString);
                CanExecutePSScript = ExecutePSByProcess(PSResultCheckString).Trim();

                if (CanExecutePSScript.Equals("Undefined"))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }

        }
        
    }
}
