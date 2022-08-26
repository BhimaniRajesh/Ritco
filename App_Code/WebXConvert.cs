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
/// Summary description for WebXConvert
/// </summary>
public static class WebXConvert
{
    public static double ToDouble(object num)
    {
        try
        {
            return Convert.ToDouble(num);
        }
        catch (Exception ex)
        {
            return 0;
        }
    }
    public static Int16 ToInt16(object num)
    {
        double iNum;
        try
        {
            iNum = Math.Round(Convert.ToDouble(num));
            return Convert.ToInt16(iNum);
        }
        catch (Exception ex)
        {
            return 0;
        }
    }
    public static Int32 ToInt32(object num)
    {
        double iNum;
        try
        {
            iNum = Math.Round(Convert.ToDouble(num));
            return Convert.ToInt32(iNum);
        }
        catch (Exception ex)
        {
            return 0;
        }
    }
    public static Int64 ToInt64(object num)
    {
        double iNum;
        try
        {
            iNum = Math.Round(Convert.ToDouble(num));
            return Convert.ToInt64(iNum);
        }
        catch (Exception ex)
        {
            return 0;
        }
    }

    /// <summary>
    /// Converts to DateTime from string using different cultures
    /// </summary>
    /// <param name="date"></param>
    /// <param name="culture"></param>
    /// <returns></returns>
    public static DateTime ToDateTime(string date, string culture)
    {
        System.Globalization.CultureInfo cif = new System.Globalization.CultureInfo(culture);
        DateTime dt;
        try
        {
            dt = Convert.ToDateTime(date, cif);
        }
        catch (Exception ex)
        {
            dt = DateTime.MinValue;
        }
        return dt;
    }

    public static bool ToBoolean(string Y_N)
    {
        return (Y_N.ToUpper().CompareTo("Y") == 0) ? true : false;
    }

    public static string ToY_N(bool flag)
    {
        return flag ? "Y" : "N";
    }
    /// <summary>
    /// The Function will Convert the Passed object to Dataset and retrun it
    /// it will return the Second Parameter if Passed Object's Value is null
    ///  - Kumar Lachhani
    /// </summary>
    /// <param name="s">Object : The Object to be converted</param>
    /// <param name="valueifNull">DataSet object : The Function will return this Parameter if Passed Object's Value is null</param>
    /// <returns></returns>
    public static DataSet objectToDataSet(Object objToConvert, DataSet valueifNull)
    {
        try
        {
            if ((objToConvert != null))
            {
                DataSet t = (DataSet)(objToConvert);
                return t;
            }
            else
            {
                return valueifNull;

            }
        }
        catch (Exception ex)
        {

            return valueifNull;
        }
    }

    /// <summary>
    /// The function will be used to convert an object type to int type
    ///  - Kumar Lachhani
    /// </summary>
    /// <param name="s">object: The value to convert</param>
    /// <param name="valueifNull">int: returns the value if passed value is null</param>
    /// <returns></returns>
    public static int objectToInt(Object valueToConvert, int valueifNull)
    {
        try
        {
            if ((valueToConvert != null))
            {
                int t = Convert.ToInt32(valueToConvert);
                return t;
            }
            else
            {
                return valueifNull;
            }
        }
        catch (Exception ex)
        {
            return valueifNull;
        }
    }

    /// <summary>
    /// The function will be used to convert an object type to string type
    ///  - Kumar Lachhani
    /// </summary>
    /// <param name="s">object: The value to convert</param>
    /// <param name="valueifNull">string: returns the value if passed value is null</param>
    /// <returns></returns>
    public static string objectToString(Object valueToConvert, string valueifNull)
    {
        try
        {
            if ((valueToConvert != null))
            {
                string t = valueToConvert.ToString();
                return t;
            }
            else
            {
                return valueifNull;
            }
        }
        catch (Exception ex)
        {
            return valueifNull;
        }
    }

    /// <summary>
    /// The function will be used to convert an object type to double type
    ///  - Kumar Lachhani
    /// </summary>
    /// <param name="s">object: The value to convert</param>
    /// <param name="valueifNull">double: returns the value if passed value is null</param>
    /// <returns></returns>
    public static double objectToDouble(Object valueToConvert, double valueifNull)
    {
        try
        {
            if ((valueToConvert != null))
            {
                double t = Convert.ToDouble(valueToConvert);
                return t;
            }
            else
            {
                return valueifNull;
            }
        }
        catch (Exception ex)
        {
            return valueifNull;
        }
    }

    /// <summary>
    /// The function will be used to convert an object type to decimal type
    ///  - Kumar Lachhani
    /// </summary>
    /// <param name="s">object: The value to convert</param>
    /// <param name="valueifNull">double: returns the value if passed value is null</param>
    /// <returns></returns>
    public static decimal objectToDecimal(Object valueToConvert, decimal valueifNull)
    {
        try
        {
            if ((valueToConvert != null) && valueToConvert.ToString() != "")
            {
                decimal t = Convert.ToDecimal(valueToConvert);
                return t;
            }
            else
            {
                return valueifNull;
            }
        }
        catch (Exception ex)
        {
            return valueifNull;
        }
    }

    /// <summary>
    /// The function will be used to convert an object type to boolean type
    ///  - Kumar Lachhani
    /// </summary>
    /// <param name="s">object: The value to convert</param>
    /// <param name="valueifNull">bool: returns the value if passed value is null</param>
    /// <returns></returns>
    public static bool objectToBoolean(Object s, bool valueifNull)
    {
        try
        {
            if ((s != null))
            {
                bool t = Convert.ToBoolean(s);
                return t;
            }
            else
            {
                return valueifNull;
            }
        }
        catch (Exception ex)
        {
            return valueifNull;
        }
    }

    /// <summary>
    /// The function will convert the timeString into TimeSpan object that we can add into DateTime object
    /// </summary>
    /// <param name="txtTime">Time String</param>
    /// <param name="timeFormat">pass the timeFormat i.e. 12HR OR 24HR</param>
    /// <returns></returns>
    public static TimeSpan ConvertToTime(string txtTime, string timeFormat)
    {
        TimeSpan tm = new TimeSpan(0, 0, 0);
        if (!string.IsNullOrEmpty(txtTime.Trim()))
        {
            var strTime = txtTime.Substring(0, 5);
            tm = TimeSpan.Parse(strTime);

            if (timeFormat == "12HR")
            {
                var strAmPm = txtTime.Substring(5, 2).ToUpper();

                if (strAmPm == "PM")
                {
                    if (tm.Hours < 12)
                    {
                        tm = new TimeSpan(tm.Hours + 12, tm.Minutes, tm.Seconds);
                    }
                }
                else if (strAmPm == "AM")
                {
                    if (tm.Hours == 12)
                    {
                        tm = new TimeSpan(0, tm.Minutes, tm.Seconds);
                    }
                }
            }
        }
        return tm;
    }
}
