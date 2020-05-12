using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
//using System.Threading.Tasks;

namespace PUMA_Platform_OS_Patches_App
{
    class AdminTool
    {
        public string standardPatchesListFolder = Path.Combine(Directory.GetParent(Directory.GetCurrentDirectory()).Parent.FullName, "PatchesStandardList");
        OSClass OS = new OSClass();
        public string saveCurrentPatchesList(string content)
        {
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
            try
            {
                string standardPatchesFilePath = Path.Combine(standardPatchesListFolder, FileName);
                System.IO.File.WriteAllText(standardPatchesFilePath, content, Encoding.UTF8);
                return standardPatchesFilePath;
            }
            catch(Exception e)
            {
                throw e;
            }
            
        }
        
    }
}
