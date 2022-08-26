using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for SessionUtilities
/// </summary>
public class SessionUtilities
{
	public SessionUtilities()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static string ConnectionString
    {
        get { return GetFromSession("SqlProvider"); }
        set { SetOnSession("SqlProvider", value); }
    }
    public static string DefaultCompanyCode
    {
        get { return GetFromSession("DefaultCompany"); }
        set { SetOnSession("DefaultCompany", value); }
    }
    public static string Client
    {
        get { return GetFromSession("Client"); }
        set { SetOnSession("Client", value); }
    }
    public static string CurrentEmployeeID
    {
        get { return GetFromSession("empcd"); }
        set { SetOnSession("empcd", value); }
    }
    public static string CurrentBranchCode
    {
        get { return GetFromSession("brcd"); }
        set { SetOnSession("brcd", value); }
    }
    public static string RedirectURL
    {
        get { return GetFromSession("RedirectURL"); }
        set { SetOnSession("RedirectURL", value); }
    }
    public static string HeadOfficeCode
    {
        get { return GetFromSession("HeadOfficeCode"); }
        set { SetOnSession("HeadOfficeCode", value); }
    }
    public static string FinYear
    {
        get { return GetFromSession("FinYear"); }
        set { SetOnSession("FinYear", value); }
    }
    public static string FinYearStart
    {
        get { return GetFromSession("FinYearStart"); }
        set { SetOnSession("FinYearStart", value); }
    }
    public static string FinYearEnd
    {
        get { return GetFromSession("FinYearEnd"); }
        set { SetOnSession("FinYearEnd", value); }
    }
    public static string LogoFile
    {
        get { return GetFromSession("logofile"); }
        set { SetOnSession("logofile", value); }
    }
    public static string DocketCalledAs
    {
        get { return GetFromSession("DocketCalledAs"); }
        set { SetOnSession("DocketCalledAs", value); }
    }
    public static string THCCalledAs
    {
        get { return GetFromSession("THCCalledAs"); }
        set { SetOnSession("THCCalledAs", value); }
    }
    public static string DocketLength
    {
        get { return GetFromSession("Dktlength"); }
        set { SetOnSession("Dktlength", value); }
    }
    public static string YearVal
    {
        get { return GetFromSession("YearVal"); }
        set { SetOnSession("YearVal", value); }
    }

   public static string CurrencySymbol
    {
        get { return GetFromSession("CurrencySymbol"); }
        set { SetOnSession("CurrencySymbol", value); }
    }
    public static string CurrencyName
    {
        get { return GetFromSession("CurrencyName"); }
        set { SetOnSession("CurrencyName", value); }
    }
     public static DateTime Now
    {
        get { return ConvertTimeFromUtc(DateTime.UtcNow); }
    }
    private static string GetFromSession(string key)
    {
        return System.Web.HttpContext.Current.Session[key].ToString().Trim();
    }
    private static void SetOnSession(string key, string value)
    {
        System.Web.HttpContext.Current.Session[key] = value;
    }
    public static string DuplicateToken
    {
        get { return GetFromSession("DuplicateToken"); }
        set { SetOnSession("DuplicateToken", value); }
    }

    public static string HiddenToken
    {
        get { return GetFromSession("HiddenToken"); }
        set { SetOnSession("HiddenToken", value); }
    }
    public static DateTime ConvertTimeFromUtc(DateTime utcdt)
    {
        return TimeZoneInfo.ConvertTimeFromUtc(utcdt, TimeZoneInfo.FindSystemTimeZoneById("India Standard Time"));
    }
}
