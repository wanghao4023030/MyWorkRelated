using System.ComponentModel;
using System.Configuration.Install;

namespace KIOSK.Integration.InboundService.RISReport.PDFGenerator
{
    [RunInstaller(true)]
    public partial class InboundServiceInstaller : System.Configuration.Install.Installer
    {
        public InboundServiceInstaller()
        {
            InitializeComponent();
        }

        private void siInboundServiceRISReportPDFGenerator_AfterInstall(object sender, InstallEventArgs e)
        {

        }

        private void spiInboundServiceRISReportPDFGenerator_AfterInstall(object sender, InstallEventArgs e)
        {

        }
    }
}