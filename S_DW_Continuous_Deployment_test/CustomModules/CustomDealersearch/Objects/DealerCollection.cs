using Dynamicweb;
using System.Data;

namespace CustomDealersearch
{
    public class DealerCollection : System.Collections.Generic.List<Dealer>
    {
        public DealerCollection()
        {
        }

        public DealerCollection(int categoryID)
        {
            string SQL = "SELECT * ";
            SQL += "FROM DealerSearchDealer ";
            if (categoryID > 0)
            {
                SQL += "WHERE DealerSearchDealerCategoryID = " + categoryID;
            }
            //SQL += " AND DatoFelt > " & Database.SqlDate(Dates.DWNow)
            Init(SQL);
        }

        public DealerCollection(string sql)
        {
            Init(sql);
        }

        public void Init(string sql)
        {
            Dealer objDealer;
            using (IDataReader objDataReader = Database.CreateDataReader(sql, "DealerSearch.mdb"))
            {
                int index = 0;
                while (objDataReader.Read())
                {
                    index += 1;
                    objDealer = new Dealer();
                    objDealer.Fill(objDataReader);
                    objDealer.Index = index;
                    Add(objDealer);
                }
            }
        }
    }
}
