using Dynamicweb;
using Dynamicweb.Backend;
using CustomDealersearch;

partial class CategorySave : System.Web.UI.Page
{

    private void Page_Load(object sender, System.EventArgs e)
    {
        //Put user code to initialize the page here
        if (Base.Request("_ID") != "")
        {
            Category objCategory;
            int ID;
            ID = Base.ChkNumber(Base.Request("_ID"));

            if (ID != 0)
            {
                //Saving changes
                objCategory = Category.GetCategoryById(ID);
            }
            else
            {
                //Creating new
                objCategory = new Category();
            }
            objCategory.Name = Base.ChkValue(Base.Request("Name"));

            objCategory.Save();

        }
        Response.Redirect("CategoryList.aspx");
    }

}

