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
/// Summary description for TaxRate
/// </summary>

namespace WebX.Entity
{
    public class TaxRate
    {
        public TaxRate()
        {
            staxrate = 0; educessrate = 0;
            heducessrate = 0; after_rebate_per = 0;
            date = DateTime.MinValue;

            /* SB Cess*/
            SbcRate = 0;
            /* SB Cess*/

            /* KK Cess*/
            KKCessRate = 0;
            /* KK Cess*/
        }

        private double staxrate, educessrate, heducessrate, after_rebate_per;

        private DateTime date;

        public DateTime Date { get { return date; } set { date = value; } }
        public double ServiceTaxRate { get { return staxrate; } set { staxrate = value; } }
        public double EduCessRate { get { return educessrate; } set { educessrate = value; } }
        public double HEduCessRate { get { return heducessrate; } set { heducessrate = value; } }
        public double AfterRebatePer { get { return after_rebate_per; } set { after_rebate_per = value; } }

        /* SB Cess*/
        public double SbcRate { get; set; }
        /* SB Cess*/

        /* KK Cess*/
        public double KKCessRate { get; set; }
        /* KK Cess*/
    }
}
