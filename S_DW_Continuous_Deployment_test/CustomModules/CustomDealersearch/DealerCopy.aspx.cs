using Dynamicweb;
using CustomDealersearch;


partial class DealerCopy : System.Web.UI.Page
{

    private void Page_Load(object sender, System.EventArgs e)
    {
        //Put user code to initialize the page here
        int ID = 0;
        if (Base.Request("ID") != "")
        {
            ID = Base.ChkNumber(Base.Request("ID"));
        }
        int CategoryID = 0;
        if (Base.Request("CategoryID") != "")
        {
            CategoryID = Base.ChkNumber(Base.Request("CategoryID"));
        }

        Dealer objDealer = new Dealer(ID);
        objDealer.Copy();
        Response.Redirect("DealerList.aspx?ID=" + CategoryID);
    }

}
