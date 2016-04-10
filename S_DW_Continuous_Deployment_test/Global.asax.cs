using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace S_DW_Continuous_Deployment_test
{
    public class Global : System.Web.HttpApplication
    {
        public void Application_Start(object sender, EventArgs e)
        {
            // Fires when the application is started
            Dynamicweb.Frontend.GlobalAsaxHandler.Application_Start(sender, e);
        }

        public void Session_Start(object sender, EventArgs e)
        {
            // Fires when the session is started
            Dynamicweb.Frontend.GlobalAsaxHandler.Session_Start(sender, e);
        }

        public void Application_BeginRequest(object sender, EventArgs e)
        {
            // Fires at the beginning of each request
            //GlobalAsax.Application_BeginRequest(sender, e);
        }

        public void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            // Fires upon attempting to authenticate the use
            Dynamicweb.Frontend.GlobalAsaxHandler.Application_AuthenticateRequest(sender, e);
        }

        public void Application_Error(object sender, EventArgs e)
        {
            // Fires when an error occurs
            Dynamicweb.Frontend.GlobalAsaxHandler.Application_Error(sender, e);
        }

        public void Session_End(object sender, EventArgs e)
        {
            // Fires when the session ends
            Dynamicweb.Frontend.GlobalAsaxHandler.Session_End(sender, e);
        }

        public void Application_End(object sender, EventArgs e)
        {
            // Fires when the application ends
            Dynamicweb.Frontend.GlobalAsaxHandler.Application_End(sender, e);
        }

        public void Application_OnPreRequestHandlerExecute(object sender, EventArgs e)
        {
            Dynamicweb.Frontend.GlobalAsaxHandler.Application_OnPreRequestHandlerExecute(sender, e);
        }
    }
}