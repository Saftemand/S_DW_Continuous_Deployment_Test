using Dynamicweb;
using System.Collections;

namespace CustomDealersearch
{
    public class DealersSQL
    {
        private string _sql = "";
        public ArrayList CategoryID = new ArrayList();
        public string SortBy = "DealerSearchDealerID";
        public string SortOrder = "ASC";
        public string Where = "";

        public DealersSQL()
        {
        }

        public DealersSQL(string categoryIDcsv)
        {
            if (categoryIDcsv != "")
            {
                categoryIDcsv = categoryIDcsv.Replace(" ", "");
                string[] CategoryIDstr;
                CategoryIDstr = categoryIDcsv.Split();
                foreach (string str in CategoryIDstr)
                {
                    CategoryID.Add(Base.ChkNumber(str));
                }
            }
        }

        public DealersSQL(ArrayList _categoryID)
        {
            CategoryID = _categoryID;
        }

        public string sql
        {
            get
            {
                GenerateSQL();
                return _sql;
            }
            set { _sql = value; }
        }

        private void GenerateSQL()
        {
            _sql = "SELECT * ";
            _sql += "FROM DealerSearchDealer";

            string clause = "WHERE (";
            if (CategoryID.Count > 0)
            {
                foreach (int ID in CategoryID)
                {
                    _sql += " " + clause + " DealerSearchDealerCategoryID = " + ID;
                    clause = "OR";
                }
                _sql += ")";
                if (!string.IsNullOrEmpty(Where))
                {
                    _sql += " AND " + Where;
                }
            }
            if (!string.IsNullOrEmpty(SortBy))
            {
                _sql += " ORDER BY " + SortBy;
            }
            if (!string.IsNullOrEmpty(SortOrder))
            {
                if (SortOrder.ToUpper() == "ASC" | SortOrder.ToUpper() == "DESC")
                {
                    _sql += " " + SortOrder;
                }
            }
        }
    }
}
