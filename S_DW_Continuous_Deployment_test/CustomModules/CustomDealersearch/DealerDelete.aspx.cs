using Dynamicweb;
using CustomDealersearch;


partial class DealerDelete : System.Web.UI.Page
{

    private void Page_Load(object sender, System.EventArgs e)
    {
        //Put user code to initialize the page here
        if (Base.Request("ID") != "")
        {
            int ID = Base.ChkNumber(Base.Request("ID"));
            int CategoryID = Base.ChkNumber(Base.Request("CategoryID"));

            //Dealer objDealer = new Dealer();
            Dealer.Delete(ID);
            Response.Redirect("DealerList.aspx?ID=" + CategoryID);
        }
    }

}
