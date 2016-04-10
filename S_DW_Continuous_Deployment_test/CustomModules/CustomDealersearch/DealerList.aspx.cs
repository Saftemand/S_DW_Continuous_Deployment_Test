using System.Text;
using Dynamicweb;
using CustomDealersearch;

partial class DealerList : System.Web.UI.Page
{

    private void Page_Load(object sender, System.EventArgs e)
    {
        //Put user code to initialize the page here
        StringBuilder sb = new StringBuilder();

        int ID = 0;
        if (Dynamicweb.Base.Request("ID") != "")
        {
            ID = Dynamicweb.Base.ChkNumber(Dynamicweb.Base.Request("ID"));
        }

        DealerCollection objDealers = new DealerCollection(ID);
        foreach (Dealer objDealer in objDealers)
        {
            sb.Append("<tr>");
            sb.Append("<td><a href=\"DealerEdit.aspx?ID=" + objDealer.ID + "&CategoryID=" + ID + "\">" + objDealer.Name + "</a></td>");
            sb.Append("<td>" + objDealer.Adress + "</td>");
            sb.Append("<td>" + objDealer.City + "</td>");
            sb.Append("<td align=\"center\"><a href=\"DealerCopy.aspx?ID=" + objDealer.ID + "&CategoryID=" + ID + "\"><img src=\"/Admin/images/Copy.gif\" border=0></a></td>");
            sb.Append("<td align=\"center\"><a href=\"javascript:del(" + objDealer.ID + ");\"><img src=\"/Admin/images/Delete.gif\" border=0></a></td>");
            sb.Append("</tr>");
            sb.Append("<tr>");
            sb.Append("<td colspan=\"5\" bgcolor=\"#C4C4C4\"><img src=\"/Admin/images/nothing.gif\" width=1 height=1 alt=\"\" border=\"0\"></td>");
            sb.Append("</tr>");
        }

        Literal1.Text = sb.ToString();
    }

}
