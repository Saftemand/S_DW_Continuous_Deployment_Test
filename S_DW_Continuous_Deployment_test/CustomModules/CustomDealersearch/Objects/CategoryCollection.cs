using Dynamicweb;
using System.Collections;
using System.Collections.Generic;

namespace CustomDealersearch
{
    public class CategoryCollection : System.Collections.Generic.List<Category>
    {
        public void SortByName()
        {
            NameSorter myComparer = new NameSorter();
            this.Sort(myComparer);
        }

        private class NameSorter : System.Collections.Generic.IComparer<CustomDealersearch.Category>
        {
            int IComparer<CustomDealersearch.Category>.Compare(CustomDealersearch.Category x, CustomDealersearch.Category y)
            {
                return x.Name.CompareTo(y.Name);
            }
        }
    }
}
