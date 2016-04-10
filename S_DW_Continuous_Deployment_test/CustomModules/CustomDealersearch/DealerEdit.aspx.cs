using CustomDealersearch;
partial class DealerEdit : System.Web.UI.Page
{
    public string Description;

    private void Page_Load(object sender, System.EventArgs e)
    {
        //Put user code to initialize the page here
        int ID;
        Dealer objDealer;

        if (Dynamicweb.Base.Request("ID") != "")
        {
            ID = Dynamicweb.Base.ChkNumber(Dynamicweb.Base.Request("ID"));
            objDealer = new Dealer(ID);
        }
        else
        {
            objDealer = new Dealer();
        }
        _ID.Value = objDealer.ID.ToString();
        Name.Value = objDealer.Name;
        Adress.Value = objDealer.Adress;
        Adress2.Value = objDealer.Adress2;
        Zip.Value = objDealer.Zip;
        City.Value = objDealer.City;
        Country.Value = objDealer.Country;
        Description = objDealer.Description;
        Phone1.Value = objDealer.Phone1;
        Phone2.Value = objDealer.Phone2;
        Fax1.Value = objDealer.Fax1;
        Fax2.Value = objDealer.Fax2;
        Email.Value = objDealer.Email;
        Website.Value = objDealer.Website;
    }

}
