using System.Collections.Generic;
using System.Xml;
using System.Xml.Xsl;

namespace KIOSK.Integration.Util
{
    /// <summary>
    /// Reads or writes xml file.
    /// </summary>
    public class KIOSKIntegrationXML
    {
        /// <summary>
        /// Xml document object.
        /// </summary>
        private XmlDocument m_XmlDoc;

        /// <summary>
        /// Construct function.
        /// </summary>
        public KIOSKIntegrationXML()
        {
        }

        /// <summary>
        /// Construct function.
        /// </summary>
        /// <param name="xmlDoc">Xml document object.</param>
        public KIOSKIntegrationXML(XmlDocument xmlDoc)
        {
            m_XmlDoc = xmlDoc;
        }

        /// <summary>
        /// Load xml file.
        /// </summary>
        /// <param name="strFileName">The xml's file name.</param>
        public void LoadXml(string strFileName)
        {
            m_XmlDoc = new XmlDocument();
            m_XmlDoc.Load(strFileName);
        }

        /// <summary>
        /// Save xml file.
        /// </summary>
        /// <param name="strFileName">The xml's filename.</param>
        public void Save(string strFileName)
        {
            m_XmlDoc.Save(strFileName);
        }

        /// <summary>
        /// Gets the text of single node.
        /// </summary>
        /// <param name="strNodeName">The name of node.</param>
        /// <returns>The value of node.</returns>
        public string GetSingleNodeText(string strNodeName)
        {
            string strXpath = strNodeName;
            if (!strXpath.EndsWith("/"))
            {
                strXpath += "/";
            }
            strXpath += "text()";

            XmlNode xnText = m_XmlDoc.SelectSingleNode(strXpath);
            if (xnText == null)
            {
                return "";
            }
            else
            {
                return xnText.Value.Trim();
            }
        }

        /// <summary>
        /// Set the value of node.
        /// </summary>
        /// <param name="strParentNodeName">The name of parent node.</param>
        /// <param name="strNodeName">The name of node.</param>
        /// <param name="strNodeValue">The new value of node.</param>
        public void SetSingleNodeText(string strParentNodeName, string strNodeName, string strNodeValue)
        {
            string strXpathParent = strParentNodeName;
            if (strXpathParent.Length == 0)
            {
                strXpathParent = "/";
            }

            string strXpathNode = strXpathParent;
            if (!strXpathNode.EndsWith("/"))
            {
                strXpathNode += "/";
            }
            strXpathNode += strNodeName;

            XmlNode xnParentNode = m_XmlDoc.SelectSingleNode(strXpathParent);
            XmlNode xnSelected = m_XmlDoc.SelectSingleNode(strXpathNode);
            if (xnSelected == null)
            {
                xnSelected = m_XmlDoc.CreateNode(XmlNodeType.Element, strNodeName, null);
                xnParentNode.AppendChild(xnSelected);
            }
            xnSelected.InnerText = strNodeValue;
        }

        /// <summary>
        /// Gets the text of multi node.
        /// </summary>
        /// <param name="strNodeName">The name of node.</param>
        /// <returns>The value of node.</returns>
        public string[] GetMultiNodeText(string strNodeName)
        {
            XmlNodeList xnlSelected = m_XmlDoc.SelectNodes(strNodeName);
            string[] strMultiNodeText = new string[xnlSelected.Count];

            XmlNode xnSelected;
            for (int i = 0; i < xnlSelected.Count; i++)
            {
                xnSelected = xnlSelected.Item(i);
                strMultiNodeText[i] = xnSelected.InnerText;
                strMultiNodeText[i] = strMultiNodeText[i].Trim();
            }

            return strMultiNodeText;
        }
        
        /// <summary>
        /// Gets the attributes of single node.
        /// </summary>
        /// <param name="strNodeName">The name of node.</param>
        /// <returns>The attributes of node.</returns>
        public Dictionary<string, string> GetSingleNodeAttribute(string strNodeName)
        {
            XmlNode xnSelected = m_XmlDoc.SelectSingleNode(strNodeName);
            return GetSingleNodeAttribute(xnSelected);
        }

        /// <summary>
        /// Gets the attributes of single node.
        /// </summary>
        /// <param name="xnSelected">The node object.</param>
        /// <returns>The attributes of node.</returns>
        public Dictionary<string, string> GetSingleNodeAttribute(XmlNode xnSelected)
        {
            Dictionary<string, string> SingleNodeAttribute = new Dictionary<string, string>();

            foreach (XmlAttribute XmlAttr in xnSelected.Attributes)
            {
                SingleNodeAttribute.Add(XmlAttr.Name, XmlAttr.Value.Trim());
            }

            return SingleNodeAttribute;
        }

        /// <summary>
        /// Gets the attributes of multi nodes.
        /// </summary>
        /// <param name="strNodeName">The name of node.</param>
        /// <returns>The attributes of all nodes.</returns>
        public List<Dictionary<string, string>> GetMultiNodeAttribute(string strNodeName)
        {
            XmlNodeList xnlSelected = m_XmlDoc.SelectNodes(strNodeName);

            return GetMultiNodeAttribute(xnlSelected);
        }

        /// <summary>
        /// Gets the attributes of multi nodes.
        /// </summary>
        /// <param name="xnlSelected">The list of node.</param>
        /// <returns>The attributes of all nodes.</returns>
        public List<Dictionary<string, string>> GetMultiNodeAttribute(XmlNodeList xnlSelected)
        {
            List<Dictionary<string, string>> MultiNodeAttribute = new List<Dictionary<string, string>>();

            foreach (XmlNode xnSelected in xnlSelected)
            {
                MultiNodeAttribute.Add(GetSingleNodeAttribute(xnSelected));
            }

            return MultiNodeAttribute;
        }

        /// <summary>
        /// Convert xml file to html file by xsl file.
        /// </summary>
        /// <param name="strXmlFileName">Xml's file name.</param>
        /// <param name="strHtmlFileName">Html's file name.</param>
        /// <param name="strXslFileName">xsl's filename</param>
        public void XmlToHtml(string strXmlFileName, string strHtmlFileName, string strXslFileName)
        {
            XslCompiledTransform xcTransform = new XslCompiledTransform();
            xcTransform.Load(strXslFileName);
            xcTransform.Transform(strXmlFileName, strHtmlFileName); 
        }
    }
}