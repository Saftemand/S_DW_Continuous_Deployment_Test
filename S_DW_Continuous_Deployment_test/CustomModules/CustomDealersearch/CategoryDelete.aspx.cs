using Dynamicweb;
using CustomDealersearch;
partial class CategoryDelete : System.Web.UI.Page
{

    private void Page_Load(object sender, System.EventArgs e)
    {
        //Put user code to initialize the page here
        if (Dynamicweb.Base.Request("ID") != "")
        {
            int ID = Dynamicweb.Base.ChkNumber(Dynamicweb.Base.Request("ID"));
            //Right way
            //Category objCategory = new Category();
            Category.Delete(ID);

            //Wrong way - it works - but takes two DB operations
            //Dim objCategory As New Category(ID)
            //objCategory.Delete()
        }
        Response.Redirect("CategoryList.aspx");
    }

}
