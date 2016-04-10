using System;
using System.Collections;
using System.Data;
using System.Web;
using Dynamicweb;
using Dynamicweb.Extensibility;

namespace CustomDealersearch
{
    [AddInName("CustomDealersearch")]
    public class Frontend : ContentModule
    {
        private string SortBy = string.Empty;
        private string SortOrder = string.Empty;
        private string Where = string.Empty;

        public override string GetContent()
        {
            SortBy = Properties.get_Value("SortBy");
            SortOrder = Properties.get_Value("SortOrder");

            if (Base.Request("SortBy") != string.Empty)
            {
                SortBy = Database.SqlEscapeInjection(Base.Request("SortBy"));
            }
            if (Base.Request("SortOrder") != string.Empty)
            {
                SortOrder = Base.Request("SortOrder");
            }

            if (Base.ChkNumber(Base.Request("DealerID")) > 0)
            {
                int DealerID = Base.ChkNumber(Base.Request("DealerID"));
                return Show(DealerID);
            }
            else
            {
                SetWhere();
                return List();
            }

        }

        private string SortOrderRev
        {
            get
            {
                if (!string.IsNullOrEmpty(SortOrder) && SortOrder.ToUpper() == "ASC")
                {
                    return "DESC";
                }
                else
                {
                    return "ASC";
                }
            }
        }

        private void SetWhere()
        {
            if (Base.Request("Dealerq") != "")
            {
                string dealerq = Database.SqlEscapeInjection(Base.Request("Dealerq"));
                ArrayList SearchFieldList = new ArrayList();
                SearchFieldList.Add("DealerSearchDealerName");
                SearchFieldList.Add("DealerSearchDealerAdress");
                SearchFieldList.Add("DealerSearchDealerZip");
                SearchFieldList.Add("DealerSearchDealerCity");
                SearchFieldList.Add("DealerSearchDealerCountry");

                string strOr = string.Empty;
                Where += "(";
                foreach (string Field in SearchFieldList)
                {
                    Where += strOr + " " + Field + " LIKE '%" + dealerq + "%' ";
                    strOr = "OR";
                }
                Where += ")";
            }
        }

        private string List()
        {

            DealersSQL objDealerSQL = new DealersSQL(Properties.get_Value("CategoryID"));
            objDealerSQL.SortBy = SortBy;
            objDealerSQL.SortOrder = SortOrder;
            objDealerSQL.Where = Where;
            DealerCollection Dealers = new DealerCollection(objDealerSQL.sql);

            Dynamicweb.Rendering.Template ListTemplate = new Dynamicweb.Rendering.Template("CustomDealersearch/List/" + Properties.get_Value("ListTemplate"));

            Dynamicweb.Rendering.Template DealerTemplate;
            DealerTemplate = ListTemplate.GetLoop("Dealers");
            foreach (Dealer objDealer in Dealers)
            {
                ShowElement(objDealer, DealerTemplate);
                DealerTemplate.CommitLoop();
            }

            ListTemplate.SetTag("SortBy", SortBy);
            ListTemplate.SetTag("SortOrder", SortOrder);
            ListTemplate.SetTag("SortOrderRev", SortOrderRev);
            ListTemplate.SetTag("Dealerq", HttpContext.Current.Server.HtmlEncode(Database.SqlEscapeInjection(Base.Request("Dealerq"))));
            ListTemplate.SetTag("PageID", this.Pageview.ID);
            ListTemplate.SetTag("Search", SearchBox());
            //ListTemplate.SetTag("Elements", Output.ToString)

            return ListTemplate.Output();
        }

        private string SearchBox()
        {
            if (Properties.get_Value("SearchTemplate") != "")
            {
                string QueryString = string.Empty;
                if (HttpContext.Current.Request.QueryString.Count > 0)
                {
                    foreach (string Item in HttpContext.Current.Request.QueryString)
                    {
                        if (Item.ToLower() != "dealerq")
                        {
                            QueryString += "<input type=\"hidden\" name=\"" + Item + "\" value=\"" + Base.Request(Item) + "\">" + Environment.NewLine;
                        }
                    }
                }
                Dynamicweb.Rendering.Template DealerSearchTemplate = new Dynamicweb.Rendering.Template("CustomDealersearch/Search" + Properties.get_Value("SearchTemplate"));

                DealerSearchTemplate.SetTag("PageID", this.Pageview.ID);
                DealerSearchTemplate.SetTag("Dealerq", HttpContext.Current.Server.HtmlEncode(Database.SqlEscapeInjection(Base.Request("Dealerq"))));
                DealerSearchTemplate.SetTag("QueryString", QueryString);

                return DealerSearchTemplate.Output();
            }
            else
            {
                return "";
            }
        }

        private void ShowElement(Dealer objDealer, Dynamicweb.Rendering.Template DealerTemplate)
        {
            DealerTemplate.SetTag("Adress", objDealer.Adress);
            DealerTemplate.SetTag("Adress2", objDealer.Adress2);
            DealerTemplate.SetTag("CategoryID", objDealer.CategoryID);
            DealerTemplate.SetTag("City", objDealer.City);
            DealerTemplate.SetTag("Country", objDealer.Country);
            DealerTemplate.SetTag("Description", objDealer.Description);
            DealerTemplate.SetTag("Email", objDealer.Email);
            DealerTemplate.SetTag("Fax1", objDealer.Fax1);
            DealerTemplate.SetTag("Fax2", objDealer.Fax2);
            DealerTemplate.SetTag("ID", objDealer.ID);
            DealerTemplate.SetTag("Name", objDealer.Name);
            DealerTemplate.SetTag("Phone1", objDealer.Phone1);
            DealerTemplate.SetTag("Phone2", objDealer.Phone2);
            DealerTemplate.SetTag("Website", objDealer.Website);
            DealerTemplate.SetTag("Zip", objDealer.Zip);
            DealerTemplate.SetTag("Index", objDealer.Index);
            //This one can be used to apply different colors to elementlines in lists by using CSS
            DealerTemplate.SetTag("IndexMod2", objDealer.Index % 2);

            DealerTemplate.SetTag("PageID", this.Pageview.ID);

        }

        private string Show(int dealerID)
        {
            Dealer objDealer = new Dealer(dealerID);
            Dynamicweb.Rendering.Template template = new Dynamicweb.Rendering.Template("CustomDealersearch/Element/" + Properties.get_Value("ElementTemplate"));
            ShowElement(objDealer, template);
            return template.Output();
        }
    }
}