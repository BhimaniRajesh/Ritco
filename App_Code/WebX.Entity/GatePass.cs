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
/// Summary description for GatePass
/// </summary>
public class GatePass
{
    private string gatepassno, flagupdate, activeflag, receivercode, receivername, partycode, partyname;
    private string updateby, lasteditby, entryby, dockno, docksf, mrsno, gpbrcd, del_veh, remark;
    private DateTime gatepassdate, updatedate, lasteditdate, entrydate;
    public GatePass()
    {
        gatepassno = ""; flagupdate = ""; activeflag = ""; receivercode = ""; receivername = ""; partycode = ""; partyname = "";
        updateby = ""; lasteditby = ""; entryby = ""; dockno = ""; mrsno = ""; gpbrcd = ""; docksf = "";
        gatepassdate = DateTime.MinValue; updatedate = DateTime.MinValue; lasteditdate = DateTime.MinValue;
        entrydate = DateTime.MinValue;
    }

    public string GatePassNo { get { return gatepassno; } set { gatepassno = value; } }
    public string PartyCode { get { return partycode; } set { partycode = value; } }

    public string DockNo { get { return dockno; } set { dockno = value; } }
    public string DockSF { get { return docksf; } set { docksf = value; } }
    public string MRNo { get { return mrsno; } set { mrsno = value; } }
    public string GatePassLoc { get { return gpbrcd; } set { gpbrcd = value; } }

    public string PartyName { get { return partyname; } set { partyname = value; } }
    public string ReceiverCode { get { return receivercode; } set { receivercode = value; } }
    public string ReceiverName { get { return receivername; } set { receivername = value; } }

    public string DeliveryVehicle { get { return del_veh; } set { del_veh = value; } }
    public string Remarks { get { return remark; } set { remark = value; } }

    public string EntryBy { get { return entryby; } set { entryby = value; } }
    public string UpdateBy { get { return updateby; } set { updateby = value; } }
    public string LastEditBy { get { return lasteditby; } set { lasteditby = value; } }

    public string FlagUpdate { get { return flagupdate; } set { flagupdate = value; } }
    public string FlagActive { get { return activeflag; } set { activeflag = value; } }

    public DateTime GatePassDate { get { return gatepassdate; } set { gatepassdate = value; } }
    public DateTime EntryDate { get { return entrydate; } set { entrydate = value; } }
    public DateTime UpdateDate { get { return updatedate; } set { updatedate = value; } }
    public DateTime LastEditDate { get { return lasteditdate; } set { lasteditdate = value; } }
}
