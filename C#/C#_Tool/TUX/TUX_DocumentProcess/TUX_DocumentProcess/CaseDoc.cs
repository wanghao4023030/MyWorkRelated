using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MSWord = Microsoft.Office.Interop.Word;
using System.Reflection;
using System.Windows.Forms;


namespace TUX_DocumentProcess
{
    class CaseDoc
    {
        public string currentPath = Environment.CurrentDirectory;
        public List<string> fileNamesList = new List<string>();
        public List<string> folderNamesList = new List<string>();
        public List<string> CasesDocPathList = new List<string>();

        public void GetAlldocFiles()
        {
            fileNamesList.Clear();
            DirectoryInfo root = new DirectoryInfo(currentPath);
            foreach (FileInfo f in root.GetFiles("*.doc*"))
            {
                if (!f.Name.ToString().Contains("~$"))
                {
                    fileNamesList.Add(f.Name.ToString());
                }
                
            }
        }

        public void FormatFolder()
        {
            foreach (string filename in fileNamesList)
            {
                //string foldername = filename.Replace(".doc", "").Replace(".docx", "");
                string foldername = Path.GetFileNameWithoutExtension(filename);
                foldername = Path.Combine(currentPath, foldername);
                string directory = Path.Combine(currentPath, foldername);
                if (!Directory.Exists(directory))
                {
                    Directory.CreateDirectory(directory);
                }
                else
                {
                    Directory.Delete(directory, true);
                    System.Threading.Thread.Sleep(5*1000);
                    Directory.CreateDirectory(directory);
                }
            }
        }

        public List<string> SplitCasesAndSaveas(string caseindentfyWord, object orginaldocPath, string detFolder)
        {
            //try
            //{
            MSWord.Application wordApp;                   //Word应用程序变量 
            MSWord.Document wordDoc;                  //Word文档变量
            MSWord.Document wordDocNew;                  //Word新文档变量
            MSWord.Tables wordTables;
            MSWord.Lists wordLists;


            object format = MSWord.WdSaveFormat.wdFormatDocument; // office 2007就是wdFormatDocumentDefault
            object Nothing = Missing.Value;

            wordApp = new MSWord.Application(); //初始化
            wordApp.Visible = true;//使文档可见

            //如果已存在，则删除
            if (!File.Exists((string)orginaldocPath))
            {
                MessageBox.Show("The files is not exist." + orginaldocPath.ToString());
                return null;
            }


            wordDoc = wordApp.Documents.Open(orginaldocPath);
            wordDoc.Activate();
            wordApp.Activate();
            wordDoc.Select();

            //MessageBox.Show(wordDoc.TrackRevisions.ToString());
            if (wordDoc.TrackRevisions = true)
            {
                wordDoc.TrackRevisions = false;
            }
            //MessageBox.Show(wordDoc.TrackRevisions.ToString());

            //将所有list的编号全部转化为文字
            wordLists = wordDoc.Lists;
            foreach (MSWord.List templist in wordLists)
            {
                //Get all list and covert the list number to Text
                try
                {
                    templist.Range.Select();
                    //object NumberType = MSWord.WdNumberType.wdNumberListNum;
                    //templist.ConvertNumbersToText(NumberType);
                    templist.ConvertNumbersToText();
                    System.Threading.Thread.Sleep(1 * 1000);

                }
                catch (Exception e)
                {
                    MessageBox.Show("Convert list number to text failed: " + templist.Range.Text +
                        "\n " + e.ToString());
                    
                }
                    

            }


            wordTables = wordDoc.Tables;
            foreach (MSWord.Table table in wordTables)
            {
                for (int rowindex = 1; rowindex <= table.Rows.Count; rowindex++)
                {
                    table.Rows[rowindex].Range.Select();
                    for (int colindex = 1; colindex <= table.Columns.Count; colindex++)
                    {
                        string cellText = table.Cell(rowindex, colindex).Range.Text;
                        if (cellText.Contains(caseindentfyWord) == true)
                        {
                            //新建一个文本，保存到一个目录里面
                            table.Cell(rowindex, colindex).Range.Copy();
                            wordDocNew = wordApp.Documents.Add(ref Nothing, ref Nothing, ref Nothing, ref Nothing);
                            MSWord.Range temprandge = wordDocNew.Range();
                            temprandge.Paste();
                            string content = table.Cell(rowindex, colindex).Range.Text.ToString();
                            content = content.Split(Environment.NewLine.ToCharArray())[0].Replace("\t", " ");


                            StringBuilder str = new StringBuilder();
                            var invalidFileNameChars = System.IO.Path.GetInvalidFileNameChars();
                            foreach (var c in content)
                            {
                                if (invalidFileNameChars.Contains(c))
                                {
                                    str.Append("" ?? "");
                                }
                                else
                                {
                                    str.Append(c);
                                }

                            }
                            content = str.ToString();
                            string newFilepath = detFolder + "\\" + content + ".doc";

                            wordDocNew.SaveAs(newFilepath, ref format, ref Nothing, ref Nothing, ref Nothing, ref Nothing, ref Nothing, ref Nothing, ref Nothing, ref Nothing, ref Nothing, ref Nothing, ref Nothing, ref Nothing, ref Nothing, ref Nothing);
                            wordDocNew.Close(ref Nothing, ref Nothing, ref Nothing);
                            CasesDocPathList.Add(newFilepath);
                        }

                    }
                }


            }
            wordDoc.Close(ref Nothing, ref Nothing, ref Nothing);
            System.Threading.Thread.Sleep(5 * 1000);
            wordApp.Quit(ref Nothing, ref Nothing, ref Nothing);
            System.Threading.Thread.Sleep(5 * 1000);
            return CasesDocPathList;
            //}
            //catch (Exception e)
            //{
            //    throw e;
            //    MessageBox.Show(e.ToString());
            //}

        }
    }
}
