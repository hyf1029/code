using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(PMS.UI.Startup))]
namespace PMS.UI
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
