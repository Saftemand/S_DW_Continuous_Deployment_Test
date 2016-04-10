using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using Dynamicweb;
using System.Data;
using System;

namespace CustomDealersearch
{
    [Serializable()]
    public class Dealer
    {
        private string _name = "";
        private string _adress = "";
        private string _adress2 = "";
        private string _zip = "";
        private string _city = "";
        private string _country = "";
        private string _description = "";
        private string _phone1 = "";
        private string _phone2 = "";
        private string _fax1 = "";
        private string _fax2 = "";
        private string _email = "";
        private string _website = "";
        private int _index = 1;
        private Category _category;

        public int ID { get; set; }
        public int CategoryID { get; set; }
        public string Name
        {
            get { return _name; }
            set { _name = value; }
        }

        public string Adress
        {
            get { return _adress; }
            set { _adress = value; }
        }
        public string Adress2
        {
            get { return _adress2; }
            set { _adress2 = value; }
        }
        public string Zip
        {
            get { return _zip; }
            set { _zip = value; }
        }
        public string City
        {
            get { return _city; }
            set { _city = value; }
        }
        public string Country
        {
            get { return _country; }
            set { _country = value; }
        }
        public string Description
        {
            get { return _description; }
            set { _description = value; }
        }
        public string Phone1
        {
            get { return _phone1; }
            set { _phone1 = value; }
        }
        public string Phone2
        {
            get { return _phone2; }
            set { _phone2 = value; }
        }
        public string Fax1
        {
            get { return _fax1; }
            set { _fax1 = value; }
        }
        public string Fax2
        {
            get { return _fax2; }
            set { _fax2 = value; }
        }
        public string Email
        {
            get { return _email; }
            set { _email = value; }
        }
        public string Website
        {
            get { return _website; }
            set { _website = value; }
        }
        public int Index
        {
            get { return _index; }
            set { _index = value; }
        }

        public Category Category
        {
            get
            {
                if (_category == null)
                {
                    _category = Category.GetCategoryById(CategoryID);
                }
                return _category;
            }
            set { _category = value; }
        }

        public Dealer()
        {
        }

        public Dealer(int id)
        {
            using (IDataReader objDataReader = Database.CreateDataReader("SELECT * FROM DealerSearchDealer WHERE DealerSearchDealerID = " + id, "DealerSearch.mdb"))
            {
                if (objDataReader.Read())
                {
                    Fill(objDataReader);
                }
            }
        }

        public void Fill(IDataReader dataReader)
        {
            ID = Base.ChkNumber(dataReader["DealerSearchDealerID"]);
            CategoryID = Base.ChkNumber(dataReader["DealerSearchDealerCategoryID"]);
            _name = dataReader["DealerSearchDealerName"].ToString();
            _adress = dataReader["DealerSearchDealerAdress"].ToString();
            _adress2 = dataReader["DealerSearchDealerAdress2"].ToString();
            _zip = dataReader["DealerSearchDealerZip"].ToString();
            _city = dataReader["DealerSearchDealerCity"].ToString();
            _country = dataReader["DealerSearchDealerCountry"].ToString();
            _description = dataReader["DealerSearchDealerDescription"].ToString();
            _phone1 = dataReader["DealerSearchDealerPhone1"].ToString();
            _phone2 = dataReader["DealerSearchDealerPhone2"].ToString();
            _fax1 = dataReader["DealerSearchDealerFax1"].ToString();
            _fax2 = dataReader["DealerSearchDealerFax2"].ToString();
            _email = dataReader["DealerSearchDealerEmail"].ToString();
            _website = dataReader["DealerSearchDealerWebsite"].ToString();
        }

        public void Save()
        {
            DataSet objDataset = new DataSet();
            DataRow objRow;
            string SQL = "SELECT * FROM DealerSearchDealer WHERE DealerSearchDealerID = " + ID;
            DataManager DbMan = new DataManager();

            try
            {
                objDataset = DbMan.CreateDataSet("DealerSearch.mdb", SQL);

                if (ID != 0)
                {
                    objRow = objDataset.Tables[0].Rows[0];
                }
                else
                {
                    objRow = objDataset.Tables[0].NewRow();
                    objDataset.Tables[0].Rows.Add(objRow);
                }

                objRow["DealerSearchDealerCategoryID"] = CategoryID;
                objRow["DealerSearchDealerName"] = _name;
                objRow["DealerSearchDealerAdress"] = _adress;
                objRow["DealerSearchDealerAdress2"] = _adress2;
                objRow["DealerSearchDealerZip"] = _zip;
                objRow["DealerSearchDealerCity"] = _city;
                objRow["DealerSearchDealerCountry"] = _country;
                objRow["DealerSearchDealerDescription"] = _description;
                objRow["DealerSearchDealerPhone1"] = _phone1;
                objRow["DealerSearchDealerPhone2"] = _phone2;
                objRow["DealerSearchDealerFax1"] = _fax1;
                objRow["DealerSearchDealerFax2"] = _fax2;
                objRow["DealerSearchDealerEmail"] = _email;
                objRow["DealerSearchDealerWebsite"] = _website;

                DbMan.Update(objDataset);

                if (ID == 0)
                {
                    ID = DbMan.GetAddedIdentityKey();
                }
            }
            catch
            {
            }
            finally
            {
                objDataset.Dispose();
                DbMan.Dispose();
            }
        }

        public void Delete()
        {
            if (ID != 0)
            {
                Delete(ID);
            }
        }

        public static void Delete(int id)
        {
            Database.ExecuteNonQuery("DELETE FROM DealerSearchDealer WHERE DealerSearchDealerID = " + id, "DealerSearch.mdb");
        }

        public Dealer Copy()
        {
            Dealer objDealer = new Dealer();

            objDealer = Clone();
            objDealer.ID = 0;
            objDealer.Name = "Copy of " + objDealer.Name;
            objDealer.Save();
            return objDealer;
        }

        public Dealer Clone()
        {
            //This is why the class is serializable.
            MemoryStream memStream = new MemoryStream();
            BinaryFormatter binFormatter = new BinaryFormatter();

            binFormatter.Serialize(memStream, this);
            memStream.Position = 0;
            return (Dealer)binFormatter.Deserialize(memStream);
        }
    }
}
