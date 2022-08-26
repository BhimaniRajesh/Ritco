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
/// Summary description for Cheque
/// </summary>
namespace WebX.Entity
{
    public class Cheque
    {
        private string chqno, depobankcode, brankbrcd, issuebank, voucherno, docno, partycode;
        private string partyname, flagonaac, flagdeposited, flagowncust, doctype, comments, entryby;
        private double chqamt, collamt,adjustamt;
        DateTime chqdt;
        public Cheque()
        {

            chqno = ""; depobankcode = ""; brankbrcd = ""; issuebank = ""; voucherno = ""; docno = ""; partycode = "";
            partyname = ""; flagonaac = ""; flagdeposited = ""; flagowncust = ""; doctype = ""; comments = ""; entryby = "";
            chqamt = 0; collamt = 0; adjustamt = 0;
            chqdt = DateTime.MinValue;
        }

        public string ChequeNo { set { chqno = value; } get { return chqno; } }
        public DateTime ChequeDate { set { chqdt = value; } get { return chqdt; } }
        public double ChequeAmount { set { chqamt = value; } get { return chqamt; } }
        public double CollAmount { set { collamt = value; } get { return collamt; } }
        public double AdjustAmount { set { adjustamt = value; } get { return adjustamt; } }
        public string DepoBankCode { set { depobankcode = value; } get { return depobankcode; } }
        public string BankBranchCode { set { brankbrcd = value; } get { return brankbrcd; } }
        public string IssueBank { set { issuebank = value; } get { return issuebank; } }
        public string VoucherNo { set { voucherno = value; } get { return voucherno; } }
        public string DocumentNo { set { docno = value; } get { return docno; } }
        public string PartyCode { set { partycode = value; } get { return partycode; } }
        public string PartyName { set { partyname = value; } get { return partyname; } }
        public string FlagOnAcc { set { flagonaac = value; } get { return flagonaac; } }
        public string FlagDeposited { set { flagdeposited = value; } get { return flagdeposited; } }
        public string FlagOwnCust { set { flagowncust = value; } get { return flagowncust; } }
        public string DocType { set { doctype = value; } get { return doctype; } }
        public string Comments { set { comments = value; } get { return comments; } }
        public string EntryBy { set { entryby = value; } get { return entryby; } }
    }
}
