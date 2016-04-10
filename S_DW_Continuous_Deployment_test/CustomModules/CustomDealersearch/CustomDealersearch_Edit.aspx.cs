using System.Data;
using System.Web;
using System.Web.UI.HtmlControls;
using Dynamicweb.Backend;
using Dynamicweb;
using CustomDealersearch;

partial class CustomDealersearch_Edit : System.Web.UI.Page
{


    private void Page_Load(object sender, System.EventArgs e)
    {
        Properties Properties = Dynamicweb.Properties.LoadProperties();

        //Set default values
        Properties.SetDefaultValue("SortBy", "DealerSearchDealerName");
        Properties.SetDefaultValue("SortOrder", "ASC");
        Properties.SetDefaultValue("SearchTemplate", "Search.html");
        Properties.SetDefaultValue("ListTemplate", "List.html");
        Properties.SetDefaultValue("ListElementTemplate", "ListElement.html");
        Properties.SetDefaultValue("ElementTemplate", "Element.html");

        SortOrderASC.SelectedFieldValue = Properties.get_Value("SortOrder");
        SortOrderDESC.SelectedFieldValue = Properties.get_Value("SortOrder");

        SortByDealerSearchDealerAdress.SelectedFieldValue = Properties.get_Value("SortBy");
        SortByDealerSearchDealerCity.SelectedFieldValue = Properties.get_Value("SortBy");
        SortByDealerSearchDealerCountry.SelectedFieldValue = Properties.get_Value("SortBy");
        SortByDealerSearchDealerName.SelectedFieldValue = Properties.get_Value("SortBy");
        SortByDealerSearchDealerZip.SelectedFieldValue = Properties.get_Value("SortBy");

        SearchTemplate.File = Properties.get_Value("SearchTemplate");
        ListTemplate.File = Properties.get_Value("ListTemplate");
        ListElementTemplate.File = Properties.get_Value("ListElementTemplate");
        ElementTemplate.File = Properties.get_Value("ElementTemplate");


        string CategoryIDList = "@" + Properties.get_Value("CategoryID").Replace(",", "@") + "@";
        CategoryCollection Categories = Category.AllCategories();
        Categories.SortByName();

        foreach (Category category in Categories)
        {
            HtmlGenericControl div = new HtmlGenericControl("div");

            System.Web.UI.HtmlControls.HtmlInputCheckBox CheckBox = new System.Web.UI.HtmlControls.HtmlInputCheckBox();
            CheckBox.Value = category.ID.ToString();
            CheckBox.Name = "CategoryID";
            CheckBox.ID = "CategoryID" + category.ID;
            if (CategoryIDList.IndexOf("@" + category.ID + "@") > 0)
            {
                CheckBox.Checked = true;
            }
            else
            {
                CheckBox.Checked = false;
            }
            div.Controls.Add(CheckBox);

            HtmlGenericControl nobr = new HtmlGenericControl("nobr");
            nobr.InnerText = category.Name;

            HtmlGenericControl label = new HtmlGenericControl("label");
            label.Attributes.Add("for", "CategoryID" + category.ID);
            label.Controls.Add(nobr);

            div.Controls.Add(label);
            CategoryCell.Controls.Add(div);
        }

    }
}