using CustomDealersearch;

partial class CategoryEdit : System.Web.UI.Page
{

    private void Page_Load(object sender, System.EventArgs e)
    {
        //Put user code to initialize the page here
        int ID;
        Category objCategory;
        if (Dynamicweb.Base.Request("ID") != "")
        {
            ID = Dynamicweb.Base.ChkNumber(Dynamicweb.Base.Request("ID"));
            objCategory = Category.GetCategoryById(ID);
        }
        else
        {
            objCategory = new Category();
        }
        _ID.Value = objCategory.ID.ToString();
        Name.Value = objCategory.Name;
    }

}
