using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace WebX.Controllers
{
    /// <summary>
    /// Summary description for MR
    /// </summary>
    public class MR
    {
        public MR()
        {
            cashamount = 0; mramount = 0; chequeamount = 0; paymode = ""; mrclosed = "N"; chequeno = "";
            oct_prcchrg = 0.0; octamt = 0.0; mrdate = DateTime.MinValue; dockdate = DateTime.MinValue; edd = DateTime.MinValue;
            entrydate = DateTime.MinValue; mrschqdt = DateTime.MinValue; depobankcode = ""; issuebank = "";
        }
        private string mrno, mrsf, mrbr, mrtype, paymode, chequeno, mrclosed, dockno, docksf, orgnloc, delloc, paybas;
        private string ptcd, ptname, ptaddr, ptpincode, ptphone, bacode, flagrebook, entryby, depobankcode, issuebank;
        private double freight, servicetax, educess, heducess, mramount, netamt, staxrate, cessrate, hcessrate;
        private double cashamount, chequeamount, octamt, oct_prcchrg;

        private Int64 noofpkgs, chargedweight;

        DateTime mrdate, dockdate, entrydate, edd, mrschqdt;

        public DateTime MRDate { get { return mrdate; } set { mrdate = value; } }
        public DateTime EDD { get { return edd; } set { edd = value; } }
        public DateTime DockDate { get { return dockdate; } set { dockdate = value; } }
        public DateTime EntryDate { get { return entrydate; } set { entrydate = value; } }

        public string MRNo { get { return mrno; } set { mrno = value; } }
        public string MRSF { get { return mrsf; } set { mrsf = value; } }
        public string MRBr { get { return mrbr; } set { mrbr = value; } }
        public string MRType { get { return mrtype; } set { mrtype = value; } }
        public string DockNo { get { return dockno; } set { dockno = value; } }
        public string DockSF { get { return docksf; } set { docksf = value; } }
        public string OrgnLoc { get { return orgnloc; } set { orgnloc = value; } }
        public string DelLoc { get { return delloc; } set { delloc = value; } }
        public string PayBas { get { return paybas; } set { paybas = value; } }
        public string PartyCode { get { return ptcd; } set { ptcd = value; } }
        public string PartyName { get { return ptname; } set { ptname = value; } }
        public string PartyAddress { get { return ptaddr; } set { ptaddr = value; } }
        public string PartyPinCode { get { return ptpincode; } set { ptpincode = value; } }
        public string PartyPhone { get { return ptphone; } set { ptphone = value; } }
        public string BACode { get { return bacode; } set { bacode = value; } }
        public string FlagMRClose { get { return mrclosed; } set { mrclosed = value; } }
        public string FlagReBook { get { return flagrebook; } set { flagrebook = value; } }
        public string EntryBy { get { return entryby; } set { entryby = value; } }

        public Int64 NoOfPkgs { get { return noofpkgs; } set { noofpkgs = value; } }
        public Int64 ChargedWeight { get { return chargedweight; } set { chargedweight = value; } }
        public double Freight { get { return freight; } set { freight = value; } }
        public double OctroiAmount { get { return octamt; } set { octamt = value; } }
        public double OctroiProcessCharge { get { return oct_prcchrg; } set { oct_prcchrg = value; } }
        public double ServiceTax { get { return servicetax; } set { servicetax = value; } }
        public double EduCess { get { return educess; } set { educess = value; } }
        public double HEduCess { get { return heducess; } set { heducess = value; } }
        public double MRAmount { get { return mramount; } set { mramount = value; } }
        public double NetAmount { get { return netamt; } set { netamt = value; } }
        public double STaxRate { get { return staxrate; } set { staxrate = value; } }
        public double EduCessRate { get { return cessrate; } set { cessrate = value; } }
        public double HEduCessRate { get { return hcessrate; } set { hcessrate = value; } }

        public string PayMode { get { return paymode; } set { paymode = value; } }
        public string ChequeNo { get { return chequeno; } set { chequeno = value; } }
        public DateTime ChequeDate { get { return mrschqdt; } set { mrschqdt = value; } }
        public double ChequeAmount { get { return chequeamount; } set { chequeamount = value; } }
        public double CashAmount { get { return cashamount; } set { cashamount = value; } }
        public string DepositeBankCode { get { return depobankcode; } set { depobankcode = value; } }
        public string IssueBankName { get { return issuebank; } set { issuebank = value; } }
    }

    public class MRCharges
    {
        private double[] schg = new double[34];
        private double freight, subtotal, servicetax, educess, heducess, mramount, freightdiff;
        string mrno, mrsf, dockno;

        public string MRNo
        {
            get { return mrno; }
            set { mrno = value; }
        }

        public string MRSF
        {
            get { return mrsf; }
            set { mrsf = value; }
        }

        public string DockNo
        {
            get { return dockno; }
            set { dockno = value; }
        }

        public double[] Charges
        {
            get { return schg; }
            set { schg = value; }
        }

        public double FreightDifference
        {
            get { return freightdiff; }
            set { freightdiff = value; }
        }


        public double Freight
        {
            get { return freight; }
            set { freight = value; }
        }

        public double SubTotal
        {
            get { return subtotal; }
            set { subtotal = value; }
        }

        public double ServiceTax
        {
            get { return servicetax; }
            set { servicetax = value; }
        }

        public double EduCess
        {
            get { return educess; }
            set { educess = value; }
        }

        public double HEduCess
        {
            get { return heducess; }
            set { heducess = value; }
        }

        public double MRAmount
        {
            get
            { return mramount; }
            set { mramount = value; }
        }


    }
}
