using System;
using Microsoft.Win32;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Collections;
using System.Text.RegularExpressions;

namespace PUMA_Platform_OS_Patches_App
{
    public class OSClass
    {
        public string PSScripts_dir = Path.Combine(Directory.GetParent(Directory.GetCurrentDirectory()).Parent.FullName, "PSScripts");
        public string[] OS_Property = { "Caption", "Version", "ServicePackMajorVersion", "OSArchitecture", "CSName", "WindowsDirectory" };
        public string[] OS_Pathch_Property = { "HotFixID", "Description", "InstalledOn"};
        public Dictionary<string, string> OSBaseInfo = new Dictionary<string, string>();
        public ArrayList LocalSucessedInstalledList = null;
        public string LocalAllInstalledPatchesList = null;

        //public OSClass()
        //{
        //    this.OS_GetInfo();
        //    this.OS_GetOS_AllInstalledPatches();
        //    this.OS_GetOS_SuccessedInstalledPatches();
        //}

        /*
         * Get the OS information and init the class property with Powershell script.
         */
        public void OS_GetInfo()
        {
            OSBaseInfo.Clear();
            PowershellModule PSModule = new PowershellModule();
            PSModule.SetLocalMacheCanExecuteScript();

            string GetOSInfo_Script_path = PSScripts_dir + "\\GetOSInfo.ps1";
            string output = PSModule.ExecutePSByProcess(GetOSInfo_Script_path).Trim();
            PSModule.SetLocalMacheCanNotExecuteScript();
            string[] arr_output = output.Split(Environment.NewLine.ToCharArray());
            arr_output = arr_output.Where(s => !string.IsNullOrEmpty(s)).ToArray();

            foreach (string property_value in OS_Property)
            {
                string key = "", value = "";
                foreach (string str in arr_output)
                {
                    var arr = str.Split(':');

                    if (arr.Count() == 2)
                    {
                        key = arr[0].Trim();
                        value = arr[1].Trim();
                    }

                    else if (arr.Count() > 2)
                    {
                        key = arr[0].Trim();
                        value = arr[1].Trim();
                        for (int i = 1; i < arr.Count() - 1; i++)
                        {
                            value = value + ":" + arr[i + 1].Trim();
                        }

                    }

                    if (key.Equals(property_value))
                    {
                        OSBaseInfo.Add(key, value);
                    }

                }

                if (OSBaseInfo.ContainsKey(property_value) == false)
                {
                    throw new Exception("The propery \"" + property_value + "\" cannot find from output " + output);
                }
            }
        }

        public void OS_GetOS_AllInstalledPatches()
        {
            //GetOSInstalledPathesTable.ps1
            LocalAllInstalledPatchesList = null;
            PowershellModule PSModule = new PowershellModule();

            PSModule.SetLocalMacheCanExecuteScript();
            string output = PSModule.ExecutePSByProcess(PSScripts_dir + "\\GetOSInstalledPathesTable.ps1").Trim();
            PSModule.SetLocalMacheCanNotExecuteScript();

            //string[] arr_output = output.Split(Environment.NewLine.ToCharArray());
            //arr_output = arr_output.Where(s => !string.IsNullOrEmpty(s)).ToArray();
            //ArrayList SucessList = GetOS_FormatSuccessedDataFromPS(arr_output, OS_Pathch_Property);
            //SucessList = GetOS_GetPatchesNumber(SucessList);
            LocalAllInstalledPatchesList = output;

        }

        //Offline Tool 不保留安装记录这种方式有问题
        //public void OS_GetOS_SuccessedInstalledPatches()
        //{
        //    //GetOSInstalledPathesTable.ps1
        //    LocalSucessedInstalledList = null;
        //    PowershellModule PSModule = new PowershellModule();

        //    PSModule.SetLocalMacheCanExecuteScript();
        //    string output = PSModule.ExecutePSByProcess(PSScripts_dir  +"\\GetOSInstalledPathesList.ps1").Trim();
        //    PSModule.SetLocalMacheCanNotExecuteScript();

        //    string[] arr_output = output.Split(Environment.NewLine.ToCharArray());
        //    arr_output = arr_output.Where(s => !string.IsNullOrEmpty(s)).ToArray();
        //    for (int i = 0; i < arr_output.Count(); i++)
        //    {
        //        bool flag = false;
        //        for (int j = 0; j < OS_Pathch_Property.Count(); j++)
        //        {
        //            if (arr_output[i].Contains(OS_Pathch_Property[j]))
        //            {
        //                flag = true;
        //            }
        //        }

        //        if (flag == false)
        //        {
        //            arr_output[i - 1] = arr_output[i - 1] + arr_output[i].TrimStart();
        //            arr_output[i] = null;
        //        }

        //    }

        //    arr_output = arr_output.Where(s => !string.IsNullOrEmpty(s)).ToArray();

        //    ArrayList SucessList = GetOS_FormatSuccessedDataFromPS(arr_output, OS_Pathch_Property);
        //    SucessList = GetOS_GetPatchesNumber(SucessList);
        //    LocalSucessedInstalledList = SucessList;

        //}

        public void OS_GetOS_SuccessedInstalledPatches()
        {
            //GetOSInstalledPathesTable.ps1
            LocalSucessedInstalledList = null;
            PowershellModule PSModule = new PowershellModule();

            PSModule.SetLocalMacheCanExecuteScript();
            string output = PSModule.ExecutePSByProcess(PSScripts_dir + "\\GetOSInstalledPathesList_GetHotfix.ps1").Trim();
            PSModule.SetLocalMacheCanNotExecuteScript();

            string[] arr_output = output.Split(Environment.NewLine.ToCharArray());
            arr_output = arr_output.Where(s => !string.IsNullOrEmpty(s)).ToArray();
            for (int i = 0; i < arr_output.Count(); i++)
            {
                bool flag = false;
                for (int j = 0; j < OS_Pathch_Property.Count(); j++)
                {
                    if (arr_output[i].Contains(OS_Pathch_Property[j]))
                    {
                        flag = true;
                    }
                }

                if (flag == false)
                {
                    arr_output[i - 1] = arr_output[i - 1] + arr_output[i].TrimStart();
                    arr_output[i] = null;
                }

            }

            arr_output = arr_output.Where(s => !string.IsNullOrEmpty(s)).ToArray();

            ArrayList SucessList = GetOS_FormatSuccessedDataFromPS(arr_output, OS_Pathch_Property);
            SucessList = GetOS_GetPatchesNumber(SucessList);
            LocalSucessedInstalledList = SucessList;

        }



        //Format the list data which from PS script.
        //Asign each patches data to a list.
        public ArrayList GetOS_FormatSuccessedDataFromPS(string[] arr_output, string[] OS_Pathch_Property)
        {
            ArrayList arrlist = new ArrayList();
            int data_arry_count = OS_Pathch_Property.Count();

            string temp_string = null;
            string list_data = null;

            for (int i = 0; i < arr_output.Count(); i++)
            {

                string[] temp = arr_output[i].Split(':');
                for (int j = 1; j < temp.Count(); j++)
                {
                    if (temp.Count() > 2 ) 
                    {
                        if (temp_string == null)
                        {
                            temp_string = temp[j];
                        }
                        else
                        {
                            temp_string = temp_string + ":" + temp[j];
                        }
                        
                    }
                    else
                    {
                        temp_string += temp[j];
                    }
                }

                if ((i + 1) % data_arry_count != 0)
                {
                    list_data += temp_string + ";";
                }
                else
                {
                    list_data += temp_string;
                }

                temp_string = null;

                if ((i + 1) % data_arry_count == 0)
                {
                    arrlist.Add(list_data);
                    list_data = null;
                }
            }

            return arrlist;
        }

        //Get the patches number of string and return arrayList.
        public ArrayList GetOS_GetPatchesNumber(ArrayList SucessList)
        {
            //Match matchResult;
            //string RegexStr = string.Empty;
            //RegexStr = @"KB\d+";
            
            //for (int i = 0; i < SucessList.Count; i++)
            //{
            //    matchResult = Regex.Match(SucessList[i].ToString(), RegexStr);
            //    if (matchResult.Success)
            //    {
            //        SucessList[i] = matchResult.Value.ToString() + ";" + SucessList[i];
            //    }
            //    else
            //    {
            //        SucessList[i] = "No KB number" + ";" + SucessList[i];
            //    }

            //}
            return SucessList;
        }

    }
}

