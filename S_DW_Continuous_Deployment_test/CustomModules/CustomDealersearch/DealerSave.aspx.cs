using Dynamicweb;
using Dynamicweb.Backend;
using CustomDealersearch;

partial class DealerSave : System.Web.UI.Page
{

    private void Page_Load(object sender, System.EventArgs e)
    {
        //Put user code to initialize the page here
        if (Dynamicweb.Base.Request("_ID") != "")
        {
            int ID;
            ID = Dynamicweb.Base.ChkNumber(Dynamicweb.Base.Request("_ID"));

            int CategoryID;
            CategoryID = Dynamicweb.Base.ChkNumber(Dynamicweb.Base.Request("CategoryID"));

            Dealer objDealer;
            if (ID != 0)
            {
                //Saving changes
                objDealer = new Dealer(ID);
            }
            else
            {
                //Creating new
                objDealer = new Dealer();
            }
            objDealer.Name = Base.ChkValue(Dynamicweb.Base.Request("Name"));
            objDealer.CategoryID = Base.ChkNumber(Dynamicweb.Base.Request("CategoryID"));
            objDealer.Name = Base.ChkValue(Dynamicweb.Base.Request("Name"));
            objDealer.Adress = Base.ChkValue(Dynamicweb.Base.Request("Adress"));
            objDealer.Adress2 = Base.ChkValue(Dynamicweb.Base.Request("Adress2"));
            objDealer.Zip = Base.ChkValue(Dynamicweb.Base.Request("Zip"));
            objDealer.City = Base.ChkValue(Dynamicweb.Base.Request("City"));
            objDealer.Country = Base.ChkValue(Dynamicweb.Base.Request("Country"));
            objDealer.Description = Base.ChkValueNoStrip(Dynamicweb.Base.Request("Description"));
            objDealer.Phone1 = Base.ChkValue(Dynamicweb.Base.Request("Phone1"));
            objDealer.Phone2 = Base.ChkValue(Dynamicweb.Base.Request("Phone2"));
            objDealer.Fax1 = Base.ChkValue(Dynamicweb.Base.Request("Fax1"));
            objDealer.Fax2 = Base.ChkValue(Dynamicweb.Base.Request("Fax2"));
            objDealer.Email = Base.ChkValue(Dynamicweb.Base.Request("Email"));
            objDealer.Website = Base.ChkValue(Dynamicweb.Base.Request("Website"));

            objDealer.Save();
            Response.Redirect("DealerList.aspx?ID=" + CategoryID.ToString());
        }
    }

}
