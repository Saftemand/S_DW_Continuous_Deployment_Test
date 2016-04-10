using System;
using Dynamicweb;

namespace CustomModules.HelloWorld
{
    public partial class HelloWorld_Edit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Properties properties = Dynamicweb.Properties.LoadProperties();

            //Set default values
            properties.SetDefaultValue("HelloText", "Hi Dynamicweb!");

            HelloText.Value = properties["HelloText"].ToString();
        }
    }
}