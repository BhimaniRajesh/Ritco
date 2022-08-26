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
/// Summary description for RupeesToWords
/// </summary>
public class RupeesToWords
{
	public RupeesToWords()
	{
		
	}
    public string NumberToText(Int64 n)
    {
        if (n < 0)
            return "Minus " + NumberToText(-n);
        else if (n == 0)
            return "";
        else if (n <= 19)
            return new string[] { "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen" }[n - 1] + " ";
        else if (n <= 99)
            return new string[] { "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety" }[n / 10 - 2] + " " + NumberToText(n % 10);
        else if (n <= 199)
            return "One Hundred " + NumberToText(n % 100);
        else if (n <= 999)
            return NumberToText(n / 100) + "Hundreds " + NumberToText(n % 100);
        else if (n <= 1999)
            return "One Thousand " + NumberToText(n % 1000);
        //*********
        else if (n <= 99999)
            return NumberToText(n / 1000) + "Thousand " + NumberToText(n % 1000);
        else if (n <= 19999)
            return "One Lac " + NumberToText(n % 100000);
        else
            return NumberToText(n / 100000) + "Lacs " + NumberToText(n % 100000);

    }

}
