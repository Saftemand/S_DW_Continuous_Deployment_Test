using System.Diagnostics;
using Dynamicweb;
using Dynamicweb.Extensibility;

namespace CustomModules.HelloWorld
{
    [AddInName("HelloWorld")]
    public class HelloWorld : ContentModule
    {

        public override string GetContent()
        {
            //TODO: Add code here
            Debug.WriteLine("hej hej med dig");
            return Properties["HelloText"].ToString();
        }

    }
}