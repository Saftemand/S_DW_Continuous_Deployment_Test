using System.Data;
using System.IO;
using System;
using System.Runtime.Serialization.Formatters.Binary;
using Dynamicweb;

namespace CustomDealersearch
{
    [Serializable()]
    public class Category
    {
        private int _id = 0;
        private string _name = "";
        private DealerCollection _dealers;

        public int ID
        {
            get { return _id; }
            set { _id = value; }
        }

        public string Name
        {
            get { return _name; }
            set { _name = value; }
        }

        public DealerCollection Dealers
        {
            get
            {
                if (_dealers == null)
                {
                    _dealers = new DealerCollection(this.ID);
                }
                return _dealers;
            }
            set { _dealers = value; }
        }

        public Category()
        {
        }

        public void Fill(IDataReader dataReader)
        {
            _id = Base.ChkNumber(dataReader["DealerSearchCategoryID"]);
            _name = Base.ChkString(dataReader["DealerSearchCategoryName"]);
        }

        public void Save()
        {
            DataSet objDataset = new DataSet();
            DataRow objRow;
            string SQL = "SELECT * FROM DealerSearchCategory WHERE DealerSearchCategoryID = " + _id;

            DataManager dbMan = new DataManager();
            try
            {
                objDataset = dbMan.CreateDataSet("DealerSearch.mdb", SQL);

                if (_id != 0)
                {
                    objRow = objDataset.Tables[0].Rows[0];
                }
                else
                {
                    objRow = objDataset.Tables[0].NewRow();
                    objDataset.Tables[0].Rows.Add(objRow);
                }

                objRow["DealerSearchCategoryName"] = _name;

                dbMan.Update(objDataset);

                if (_id == 0)
                {
                    _id = dbMan.GetAddedIdentityKey();
                }
            }
            catch
            {
            }
            finally
            {
                objDataset.Dispose();
                dbMan.Dispose();
            }
        }

        public void Delete()
        {
            if (_id != 0)
            {
                Delete(_id);
            }
        }

        public static void Delete(int id)
        {
            Database.ExecuteNonQuery("DELETE FROM DealerSearchCategory WHERE DealerSearchCategoryID = " + id, "DealerSearch.mdb");
        }

        public Category Copy()
        {
            Category objCategory = new Category();
            objCategory = this.Clone();
            objCategory.ID = 0;
            objCategory.Name = "Copy of " + objCategory.Name;
            objCategory.Save();
            return objCategory;
        }

        public Category Clone()
        {
            //This is why the class is serializable.
            MemoryStream memStream = new MemoryStream();
            BinaryFormatter binFormatter = new BinaryFormatter();

            binFormatter.Serialize(memStream, this);
            memStream.Position = 0;
            return (Category)binFormatter.Deserialize(memStream);
        }

        public static CategoryCollection AllCategories()
        {
            CategoryCollection myCol = new CategoryCollection();
            Category objCategory;

            using (IDataReader objDataReader = Database.CreateDataReader("SELECT * FROM DealerSearchCategory ORDER BY DealerSearchCategoryID", "DealerSearch.mdb"))
            {
                while (objDataReader.Read())
                {
                    objCategory = new Category();
                    objCategory.Fill(objDataReader);
                    myCol.Add(objCategory);
                }
            }

            return myCol;
        }

        public static Category GetCategoryById(int categoryID)
        {
            Category cat = null;
            using (IDataReader objDataReader = Database.CreateDataReader("SELECT * FROM DealerSearchCategory WHERE DealerSearchCategoryID = " + categoryID, "DealerSearch.mdb"))
            {
                if (objDataReader.Read())
                {
                    cat = new Category();
                    cat.Fill(objDataReader);
                }
            }
            return cat;
        }

    }
}
