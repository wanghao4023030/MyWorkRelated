using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using log4net;
using Microsoft.VisualBasic;

namespace PUMA_Platform_OS_Patches_App
{

    class ServiceTool
    {
        log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        OSClass OS = new OSClass();
        public string[] NeedInstallPatches = null;
        public List<string> NotFindPathLists = new List<string>();
        public string standardPatchesListFolder = Path.Combine(Directory.GetParent(Directory.GetCurrentDirectory()).Parent.FullName, "PatchesStandardList");
        public string patches_dir = Path.Combine(Directory.GetParent(Directory.GetCurrentDirectory()).Parent.FullName, "Patches");
        public int hasinstalledCount = 0;
        public string current_installPatchName = ""; 
        
        public string getCurrentOSinfo()
        {
            string rtn_text = null;
            OS.OS_GetInfo();
            foreach (string txt_temp in OS.OS_Property)
            {
                rtn_text += txt_temp + ":" + OS.OSBaseInfo[txt_temp] + "\r\n";
            }
            
            return rtn_text;
        }

        public string getAllInstalledPatches()
        {
            OS.OS_GetOS_AllInstalledPatches();
            return OS.LocalAllInstalledPatchesList;
        }

        public string getSuccessedPatches()
        {
            string rtn_text = null;
            OS.OS_GetOS_SuccessedInstalledPatches();
            ArrayList LocalSucessedList = OS.LocalSucessedInstalledList;
            foreach (object list in LocalSucessedList)
            {
                rtn_text = rtn_text + list.ToString() + "\r\n";
            }

            return rtn_text;
        }

        public string[] delDateFromResult(string [] CurrentPatchesList)
        {
            for (int index = 0; index < CurrentPatchesList.Count()-1; index++)
            {
                string[] temp = CurrentPatchesList[index].Split(';');
                string temp_string = null;
                for (int i = 0; i < temp.Count() - 1; i++)
                {
                    if (i < temp.Count() - 2)
                    {
                        temp_string = temp_string + temp[i] + ";";
                    }
                    else
                    {
                        temp_string = temp_string + temp[i];
                    }
                    
                }

                CurrentPatchesList[index] = temp_string;

            }

            return CurrentPatchesList;
        }


        public string compareNeedInstallPatches(string CurrentPatchesContent)
        {
            ServiceTool ST = new ServiceTool();
            OS.OS_GetInfo();
            string FileName = null;
            // Thinke the property "Version" need added or not. 
            foreach (KeyValuePair<string, string> keyValue in OS.OSBaseInfo)
            {
                if (keyValue.Key.Equals("Caption"))
                {
                    FileName += keyValue.Value + "_";
                }

                if (keyValue.Key.Equals("OSArchitecture"))
                {
                    FileName += keyValue.Value;
                }
            }

            FileName += ".txt";
            FileName = Path.Combine(standardPatchesListFolder, FileName);

            string WantedPatchesContent = File.ReadAllText(FileName, Encoding.UTF8);
            string[] CurrentPatchesList = CurrentPatchesContent.Split('\n');
            string[] WantedPatchesList = WantedPatchesContent.ToLower().Split('\n');

            CurrentPatchesList = ST.delDateFromResult(CurrentPatchesList).Where(s => !string.IsNullOrEmpty(s)).ToArray();
            WantedPatchesList = ST.delDateFromResult(WantedPatchesList).Where(s => !string.IsNullOrEmpty(s)).ToArray();


            string NeedInstallPatchesContent = null;

            foreach (string wanted in WantedPatchesList)
            {

                bool installed_flag = false;

                foreach (string current in CurrentPatchesList)
                {
                    if (wanted.Equals(current))
                    {
                        installed_flag = true;
                    }
                }

                if (installed_flag == false)
                {
                    NeedInstallPatchesContent = NeedInstallPatchesContent + wanted + "\n";
                }
            }
            if (NeedInstallPatchesContent != null)
            {
                NeedInstallPatches = NeedInstallPatchesContent.ToLower().Split('\n').Where(s => !string.IsNullOrEmpty(s)).ToArray();
            }
            else
            {
                NeedInstallPatchesContent = "No patch need to install.";
            }

            
            return NeedInstallPatchesContent;
        }

        
        public string findNeedInstallPatches(string patch_number)
        {
            string path_string = null;
            string[] all_files = Directory.GetFiles(this.patches_dir, "*.*");
            patch_number = patch_number.Split(';')[0];
            patch_number = patch_number.ToLower().Trim();

            foreach (string file in all_files)
            {
                if (file.ToLower().Contains(patch_number))
                {
                    return file;
                }
            }

            this.NotFindPathLists.Add(patch_number);
            return path_string;
        }

        public bool InstallPatchesByFileName(string filename)
        {

            bool result1 = ExecuteMSUPatches(filename);
            bool result2 = ExecuteCabPatches(filename);
            bool result3 = ExecuteExePatches(filename);
            if (result1 || result2 || result3)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public bool ExecuteMSUPatches(string filename)
        {
            string filetype = Path.GetExtension(filename);
            if (filetype.ToLower().Equals(".msu"))
            {
                string cmdstring = " " + filename + " /quiet /norestart";
                string result = ExcuteApp("wusa.exe", cmdstring);
                return true;
            }
            return false;
        }

        public bool ExecuteCabPatches(string filename)
        {
            string filetype = Path.GetExtension(filename);
            if (filetype.ToLower().Equals(".cab"))
            {
                string cmdstring = " /Online /Add-Package /PackagePath:" + filename + " /quiet /norestart";
                string result = ExcuteApp("dism.exe", cmdstring);

            }
            return false;
        }

        public bool ExecuteExePatches(string filename)
        {
            try
            {
                string filetype = Path.GetExtension(filename);
                if (filetype.ToLower().Equals(".exe"))
                {
                    Process powershell_process = new Process();
                    powershell_process.StartInfo.FileName = filename;
                    powershell_process.StartInfo.UseShellExecute = false;
                    powershell_process.StartInfo.RedirectStandardOutput = true;
                    powershell_process.StartInfo.RedirectStandardError = true;
                    powershell_process.StartInfo.CreateNoWindow = true;
                    powershell_process.Start();
                    var output = powershell_process.StandardOutput.ReadToEnd();
                    powershell_process.WaitForExit();
                    powershell_process.Close();
                    powershell_process.Dispose();
                    return true;
                }
                else
                {
                    return false;
                }
                
            }
            catch (Exception ex)
            {
                throw ex;
                
            }
            
        }

        public string ExcuteApp(string app, string para)
        {
            Process powershell_process = new Process();
            powershell_process.StartInfo.FileName = app;
            powershell_process.StartInfo.UseShellExecute = false;
            powershell_process.StartInfo.RedirectStandardOutput = true;
            powershell_process.StartInfo.RedirectStandardError = true;
            powershell_process.StartInfo.CreateNoWindow = true;
            powershell_process.StartInfo.Arguments = para;
            //powershell_process.Exited += installExit;
            powershell_process.Start();
            var output = powershell_process.StandardOutput.ReadToEnd();
            powershell_process.WaitForExit();
            powershell_process.Close();
            powershell_process.Dispose();
            return output;
        }


        public void InstallPatchesWithThread()
        {

            if (this.NeedInstallPatches.Count() >= 1)
            {
                foreach (string KB_Value in this.NeedInstallPatches)
                {
                    string patch_file_name = findNeedInstallPatches(KB_Value);

                    if (patch_file_name != null)
                    {
                        this.current_installPatchName = KB_Value.ToString();
                        log.Info("Service: Try to install the patch : " + KB_Value);
                        if (this.InstallPatchesByFileName(patch_file_name))
                        {
                            string success_patches = this.getSuccessedPatches().ToLower();
                            if (success_patches.Trim().ToLower().Contains(KB_Value.Trim()))
                            {
                                log.Info("Service: Install the patch : " + KB_Value + " successfully.");
                            }
                            else
                            {
                                log.Info("Service: Install the patch : " + KB_Value + " Failed.");
                            }
                        }
                    }
                    else
                    {
                        log.Info("Service: Patch cannot find in the folder path 'Patches' of : " + KB_Value + "");
                    }

                    this.hasinstalledCount = this.hasinstalledCount + 1;
                }
            }
            else
            {
                log.Info("No patches need to install");
            }

            this.hasinstalledCount = 0;
        }
    }

}
