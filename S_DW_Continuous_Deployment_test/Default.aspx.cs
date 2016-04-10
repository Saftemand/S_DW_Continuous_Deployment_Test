using System;
using Dynamicweb;

namespace S_DW_Continuous_Deployment_test
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Note: you can disable the performance counter in the Management Center or through the Global Settings. See: http://developer.dynamicweb-cms.com/forum/development/better-way-to-disable-performance-comment.aspx
            Output.Controls.Add(new Dynamicweb.Frontend.PageviewControl());
        }
    }
}