using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;
using CustomDealersearch;

partial class CategoryList : System.Web.UI.Page
{

    private void Page_Load(object sender, System.EventArgs e)
    {
        //Put user code to initialize the page here
        StringBuilder sb = new StringBuilder();
        CategoryCollection objCategories = new CategoryCollection();
        objCategories = Category.AllCategories();
        foreach (Category objCategory in objCategories)
        {
            sb.Append("<tr>");
            sb.Append("<td><a href=\"DealerList.aspx?ID=" + objCategory.ID + "\">" + objCategory.Name + "</a></td>");
            sb.Append("<td align=\"center\"><a href=\"javascript:del(" + objCategory.ID + ");\"><img src=\"/Admin/images/Delete.gif\" border=0></a></td>");
            sb.Append("</tr>");
            sb.Append("<tr>");
            sb.Append("<td colspan=\"2\" bgcolor=\"#C4C4C4\"><img src=\"/Admin/images/nothing.gif\" width=1 height=1 alt=\"\" border=\"0\"></td>");
            sb.Append("</tr>");
        }

        Literal1.Text = sb.ToString();
    }

}