using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace WebX.Entity
{
    /// <summary>
    /// Summary description for PasswordPolicy
    /// </summary>
    [Serializable]
    public class PasswordPolicy
    {
        public const string ALPHA_REQUIRED = "ALPHA_REQUIRED";
        public const string COMPLEXITY_EXPRESSION = "COMPLEXITY_EXPRESSION";
        public const string ENABLE_PASSWORD_COPLEXCITY = "ENABLE_PASSWORD_COPLEXCITY";
        public const string MAXIMUM_LENGTH = "MAXIMUM_LENGTH";
        public const string MINIMUM_LENGTH = "MINIMUM_LENGTH";
        public const string NUMBER_REQUIRED = "NUMBER_REQUIRED";
        public const string SP_CHAR_REQUIRED = "SP_CHAR_REQUIRED";
        public const string USE_ENCRYPTED_PASSWORD = "USE_ENCRYPTED_PASSWORD";
        public const string EXPIRE_AFTER = "EXPIRE_AFTER";
        public const string REMEMBER_LAST_PASSWORD = "REMEMBER_LAST_PASSWORD";

        private int _ID = 0;
        private string _CodeID = "";
        private string _CodeDesc = "";
        private string _DefaultValue = "";
        private string _SetValue = "";
        private string _Active = "N";
        private DateTime _EntryDate = DateTime.MinValue;
        private string _EntryBy = "";
        private DateTime _UpdateDate = DateTime.MinValue;
        private string _UpdateBy = "";

        public PasswordPolicy()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public int ID { get { return _ID; } set { _ID = value; } }
        public string CodeID { get { return _CodeID; } set { _CodeID = value; } }
        public string CodeDesc { get { return _CodeDesc; } set { _CodeDesc = value; } }
        public string DefaultValue { get { return _DefaultValue; } set { _DefaultValue = value; } }
        public string SetValue { get { return _SetValue; } set { _SetValue = value; } }
        public string Active { get { return _Active; } set { _Active = value; } }
        public DateTime EntryDate { get { return _EntryDate; } set { _EntryDate = value; } }
        public string EntryBy { get { return _EntryBy; } set { _EntryBy = value; } }
        public DateTime UpdateDate { get { return _UpdateDate; } set { _UpdateDate = value; } }
        public string UpdateBy { get { return _UpdateBy; } set { _UpdateBy = value; } }
    }

    public enum PasswordPolicy_Columns
    {
        ID = 0,
        CodeID,
        CodeDesc,
        DefaultValue,
        SetValue,
        Active,
        EntryDate,
        EntryBy,
        UpdateDate,
        UpdateBy
    }
}
