using System.ComponentModel;
using System.Configuration.Install;

namespace KIOSK.Integration.InboundService.MWL.SCU
{
    [RunInstaller(true)]
    public partial class InboundServiceInstaller : System.Configuration.Install.Installer
    {
        public InboundServiceInstaller()
        {
            InitializeComponent();
        }

        private void siInboundServiceMWLSCU_AfterInstall(object sender, InstallEventArgs e)
        {

        }

        private void spiInboundServiceMWLSCU_AfterInstall(object sender, InstallEventArgs e)
        {

        }
    }
}
