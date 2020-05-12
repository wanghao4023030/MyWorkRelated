using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace nameSpace_FodlerFileOperation
{
    public class FolderFileOperation
    {
  
        public string CreateFolderByCurrectFolder(string strName)
        {
            string strCurrentFolderPath = null;

                strCurrentFolderPath = System.AppDomain.CurrentDomain.BaseDirectory;
                string NewTempPath = System.IO.Path.Combine(strCurrentFolderPath, strName);
                System.IO.Directory.CreateDirectory(NewTempPath);
                DirectoryInfo Di = new DirectoryInfo(NewTempPath);
                try
                {
                    if (Di.Exists)
                    {
                        return NewTempPath;
                    }
                    else
                    {
                        return null;

                    }

                }
                catch(Exception ex)
                {
                    return ex.ToString();
                }

            }

        public Boolean MoveFolder(string strsource,string strdest)
        {
            System.IO.Directory.Move(strsource,strdest);
            if (Directory.Exists(strdest) == true && Directory.Exists(strsource) == false)
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