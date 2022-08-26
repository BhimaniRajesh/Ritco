using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Reflection;
using System.Text.RegularExpressions;

public sealed class GenericComparer<T> : IComparer<T>
{
    public enum SortOrder { Ascending, Descending };

    #region member variables
    private string sortColumn;
    private SortOrder sortingOrder;
    #endregion

    #region constructor
    public GenericComparer(string sortColumn, SortOrder sortingOrder)
    {
        this.sortColumn = sortColumn;
        this.sortingOrder = sortingOrder;
    }
    #endregion

    #region public property
    /// <summary>
    /// Column Name(public property of the class) to be sorted.
    /// </summary>
    public string SortColumn
    {
        get { return sortColumn; }
    }

    /// <summary>
    /// Sorting order.
    /// </summary>
    public SortOrder SortingOrder
    {
        get { return sortingOrder; }
    }
    #endregion

    #region public methods
    /// <summary>
    /// Compare interface implementation
    /// </summary>
    /// <param name="x">custom Object</param>
    /// <param name="y">custom Object</param>
    /// <returns>int</returns>
    public int Compare(T x, T y)
    {
        PropertyInfo propertyInfo = typeof(T).GetProperty(sortColumn);
        IComparable obj1 = (IComparable)propertyInfo.GetValue(x, null);
        IComparable obj2 = (IComparable)propertyInfo.GetValue(y, null);
        if (sortingOrder == SortOrder.Ascending)
        {
            return (obj1.CompareTo(obj2));
        }
        else
        {
            return (obj2.CompareTo(obj1));
        }
    }
    #endregion

}

