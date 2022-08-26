using Microsoft.ApplicationBlocks.Data;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Xml;
using WebX.Controllers;
using WebX.Entity;

/// <summary>
/// Summary description for TMS_Track_Docket
/// </summary>
[WebService(Namespace = "http://www.webxpress.in/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class TMS_Track_Docket : System.Web.Services.WebService
{

    public TMS_Track_Docket()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public XmlDocument TrackDocketXML(string DocType, string DockNo)
    {
        string strRet = "";
        XmlDocument DocRet = new XmlDocument();

        string strHdr = "EXEC USP_DOCKET_TRACK_HEADER_DUAL_DATA_VER1 ";
        if (DocType == "1")
            strHdr += " '" + DockNo + "',''";
        if (DocType == "2")
            strHdr += " '','" + DockNo + "'";

        XmlDocument XDOC = new XmlDocument();
        XmlElement DLXREPLY = XDOC.CreateElement("DLXREPLY");
        XmlElement CONSIGNMENT = XDOC.CreateElement("CONSIGNMENT");
        try
        {
            DataSet DS = SqlHelper.ExecuteDataset(GetConnectionString(), CommandType.Text, strHdr);
            if (DS.Tables.Count > 0)
            {
                if (DS.Tables[0].Rows.Count > 0)
                {
                    DataRow dr = DS.Tables[0].Rows[0];

                    XmlElement AXBHEADER = XDOC.CreateElement("AXBHEADER");
                    AXBHEADER.AppendChild(CreateElement(XDOC, "AXBTRACK", "TRUE"));

                    if (dr["DOCKNO"] != DBNull.Value)
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strShipmentNo", dr["DOCKNO"].ToString() }));
                    else
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strShipmentNo", "" }));

                    if (dr["CTR_No"] != DBNull.Value)
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strRefNo", dr["CTR_No"].ToString() }));
                    else
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strRefNo", "" }));

                    if (dr["TRN_MODE"] != DBNull.Value)
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strMode", dr["TRN_MODE"].ToString() }));
                    else
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strMode", "" }));

                    if (dr["ORIGIN"] != DBNull.Value)
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strOrigin", dr["ORIGIN"].ToString() }));
                    else
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strOrigin", "" }));

                    if (dr["DOCKDT"] != DBNull.Value)
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strBookedOn", dr["DOCKDT"].ToString() }));
                    else
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strBookedOn", "" }));

                    if (dr["PKGSNO"] != DBNull.Value)
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strPieces", dr["PKGSNO"].ToString() }));
                    else
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strPieces", "0" }));

                    if (dr["ACTUWT"] != DBNull.Value)
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strWeight", dr["ACTUWT"].ToString() }));
                    else
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strWeight", "" }));

                    if (dr["Destination"] != DBNull.Value)
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strDestination", dr["Destination"].ToString() }));
                    else
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strDestination", "" }));

                    if (dr["STATUS"] != DBNull.Value)
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strStatus", dr["STATUS"].ToString() }));
                    else
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strStatus", "" }));

                    AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strRemarks", "" }));

                    if (dr["NO_OF_ATT"] != DBNull.Value)
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strNoOfAttempts", dr["NO_OF_ATT"].ToString() }));
                    else
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strNoOfAttempts", "" }));

                    if (dr["BookedBy"] != DBNull.Value)
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strBookedBy", dr["BookedBy"].ToString() }));
                    else
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strBookedBy", "" }));

                    if (dr["ReceivedBy"] != DBNull.Value)
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strReceivedBy", dr["ReceivedBy"].ToString() }));
                    else
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strReceivedBy", "" }));

                    if (dr["AssuredDeliveryDate"] != DBNull.Value)
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strAssuredDeliveryDate", dr["AssuredDeliveryDate"].ToString() }));
                    else
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strAssuredDeliveryDate", "" }));

                    if (dr["deldt"] != DBNull.Value)
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strActualDeliveryDate", dr["deldt"].ToString() }));
                    else
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strActualDeliveryDate", "" }));

                    if (dr["recname"] != DBNull.Value)
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "ReceiversName", dr["recname"].ToString() }));
                    else
                        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "ReceiversName", "" }));



                    AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strError", "" }));

                    CONSIGNMENT.AppendChild(AXBHEADER);

                    string strDET = "EXEC VWNET_DELEMILESTONE_DUAL_DATA_VER1 '" + dr["DOCKNO"].ToString() + "','.'";

                    DataSet DSD = SqlHelper.ExecuteDataset(GetConnectionString(), CommandType.Text, strDET);
                    if (DSD.Tables.Count > 0)
                    {
                        if (DSD.Tables[0].Rows.Count > 0)
                        {
                            XmlElement AXBBODY = XDOC.CreateElement("AXBBODY");
                            AXBBODY.AppendChild(CreateElement(XDOC, "AXBACTIONTRACK", "TRUE"));
                            try
                            {
                                //START Loop
                                foreach (DataRow drd in DSD.Tables[0].Rows)
                                {
                                    if (drd["Status"] != DBNull.Value)
                                    {
                                        if (drd["Status"].ToString().Trim() != "")
                                        {
                                            XmlElement AXBACTION = XDOC.CreateElement("AXBACTION");
                                            AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strAction", drd["Status"].ToString() }));
                                            AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strDocumentNo", drd["DOCNO"].ToString() }));
                                            AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strLocation", drd["LOCNAME"].ToString() }));
                                            AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strActionDate", drd["DT"].ToString() }));
                                            AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strActionTime", drd["TM"].ToString() }));
                                            AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strRemarks", "" }));
                                            AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strError", "" }));
                                            AXBBODY.AppendChild(AXBACTION);
                                        }
                                    }
                                    if (drd["Status1"] != DBNull.Value)
                                    {
                                        if (drd["Status1"].ToString().Trim() != "")
                                        {
                                            XmlElement AXBACTION_1 = XDOC.CreateElement("AXBACTION");
                                            AXBACTION_1.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strAction", drd["Status1"].ToString() }));
                                            AXBACTION_1.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strDocumentNo", drd["DOCNO"].ToString() }));
                                            AXBACTION_1.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strLocation", drd["LOCNAME"].ToString() }));
                                            AXBACTION_1.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strActionDate", drd["DT1"].ToString() }));
                                            AXBACTION_1.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strActionTime", drd["TM1"].ToString() }));
                                            AXBACTION_1.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strRemarks", "" }));
                                            AXBACTION_1.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strError", "" }));
                                            AXBBODY.AppendChild(AXBACTION_1);
                                        }
                                    }
                                    if (drd["Status2"] != DBNull.Value)
                                    {
                                        if (drd["Status2"].ToString().Trim() != "")
                                        {
                                            XmlElement AXBACTION_2 = XDOC.CreateElement("AXBACTION");
                                            AXBACTION_2.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strAction", drd["Status2"].ToString() }));
                                            AXBACTION_2.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strDocumentNo", drd["DOCNO"].ToString() }));
                                            AXBACTION_2.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strLocation", drd["LOCNAME"].ToString() }));
                                            AXBACTION_2.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strActionDate", drd["DT2"].ToString() }));
                                            AXBACTION_2.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strActionTime", drd["TM2"].ToString() }));
                                            AXBACTION_2.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strRemarks", "" }));
                                            AXBACTION_2.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strError", "" }));
                                            AXBBODY.AppendChild(AXBACTION_2);
                                        }
                                    }
                                }
                                //END Loop                            
                            }
                            catch (Exception ex)
                            {
                                AXBBODY.AppendChild(Track_On_DetailNotFound(XDOC, ex.Message));
                            }
                            CONSIGNMENT.AppendChild(AXBBODY);
                        }
                        else
                            CONSIGNMENT.AppendChild(Track_On_DetailNotFound(XDOC, "AXB detail does not found."));
                    }
                    else
                        CONSIGNMENT.AppendChild(Track_On_DetailNotFound(XDOC, "AXB detail does not found."));

                    DLXREPLY.AppendChild(CONSIGNMENT);
                    XDOC.AppendChild(DLXREPLY);
                    DocRet = XDOC;
                    strRet = XDOC.InnerXml;
                }
                else
                    DocRet = TrackXML_NotFound("AXB does not found.");
            }
            else
                DocRet = TrackXML_NotFound("AXB does not found.");
        }
        catch (Exception ex)
        {
            DocRet = TrackXML_NotFound(ex.Message);
        }
        return DocRet;
    }

    private XmlElement Track_On_DetailNotFound(XmlDocument XDOC, string errorMsg)
    {
        XmlElement AXBBODY = XDOC.CreateElement("AXBBODY");
        AXBBODY.AppendChild(CreateElement(XDOC, "AXBACTIONTRACK", "FALSE"));

        //START Loop

        XmlElement AXBACTION = XDOC.CreateElement("AXBACTION");
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strAction", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strDocumentNo", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strLocation", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strActionDate", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strActionTime", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strRemarks", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strError", errorMsg }));
        AXBBODY.AppendChild(AXBACTION);

        return AXBBODY;
    }

    private string TrackXML_On_NotFound(string errorMsg)
    {
        string strRet = "";

        XmlDocument XDOC = new XmlDocument();
        XmlElement DLXREPLY = XDOC.CreateElement("DLXREPLY");
        XmlElement CONSIGNMENT = XDOC.CreateElement("CONSIGNMENT");

        XmlElement AXBHEADER = XDOC.CreateElement("AXBHEADER");
        AXBHEADER.AppendChild(CreateElement(XDOC, "AXBTRACK", "FALSE"));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strShipmentNo", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strRefNo", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strMode", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strOrigin", "" }));

        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strBookedOn", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strBookedBy", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strPieces", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strWeightUnit", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strWeight", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strDestination", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strStatus", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strRemarks", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strNoOfAttempts", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strError", errorMsg }));
        CONSIGNMENT.AppendChild(AXBHEADER);

        XmlElement AXBBODY = XDOC.CreateElement("AXBBODY");
        AXBBODY.AppendChild(CreateElement(XDOC, "AXBACTIONTRACK", "FALSE"));

        //START Loop

        XmlElement AXBACTION = XDOC.CreateElement("AXBACTION");
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strAction", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strDocumentNo", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strLocation", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strActionDate", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strActionTime", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strRemarks", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strError", errorMsg }));
        AXBBODY.AppendChild(AXBACTION);

        //END Loop
        CONSIGNMENT.AppendChild(AXBBODY);
        DLXREPLY.AppendChild(CONSIGNMENT);

        XDOC.AppendChild(DLXREPLY);

        strRet = XDOC.InnerXml;
        return strRet;
    }
    private XmlDocument TrackXML_NotFound(string errorMsg)
    {
        XmlDocument XDOC = new XmlDocument();
        XmlElement DLXREPLY = XDOC.CreateElement("DLXREPLY");
        XmlElement CONSIGNMENT = XDOC.CreateElement("CONSIGNMENT");

        XmlElement AXBHEADER = XDOC.CreateElement("AXBHEADER");
        AXBHEADER.AppendChild(CreateElement(XDOC, "AXBTRACK", "FALSE"));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strShipmentNo", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strRefNo", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strMode", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strOrigin", "" }));

        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strBookedOn", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strBookedBy", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strPieces", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strWeightUnit", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strWeight", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strDestination", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strStatus", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strRemarks", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strNoOfAttempts", "" }));
        AXBHEADER.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strError", errorMsg }));
        CONSIGNMENT.AppendChild(AXBHEADER);

        XmlElement AXBBODY = XDOC.CreateElement("AXBBODY");
        AXBBODY.AppendChild(CreateElement(XDOC, "AXBACTIONTRACK", "FALSE"));

        //START Loop

        XmlElement AXBACTION = XDOC.CreateElement("AXBACTION");
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strAction", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strDocumentNo", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strLocation", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strActionDate", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strActionTime", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strRemarks", "" }));
        AXBACTION.AppendChild(CreateElementWithAtter(XDOC, "FIELD", new string[] { "NAME", "VALUE" }, new string[] { "strError", errorMsg }));
        AXBBODY.AppendChild(AXBACTION);

        //END Loop

        CONSIGNMENT.AppendChild(AXBBODY);
        DLXREPLY.AppendChild(CONSIGNMENT);
        XDOC.AppendChild(DLXREPLY);

        return XDOC;
    }

    private XmlAttribute CreateAttribute(XmlDocument XDoc, string name, string value)
    {
        XmlAttribute xa = XDoc.CreateAttribute(name);
        xa.Value = value;
        return xa;
    }

    private XmlElement CreateElement(XmlDocument XDoc, string name, string value)
    {
        XmlElement xa = XDoc.CreateElement(name);
        xa.InnerText = value;
        return xa;
    }

    private XmlElement CreateElementWithAtter(XmlDocument XDoc, string NodeName, string[] AttrName, string[] value)
    {
        XmlElement xa = XDoc.CreateElement(NodeName);
        for (int i = 0; i < AttrName.Length; i++)
        {
            xa.Attributes.Append(CreateAttribute(XDoc, AttrName[i], value[i]));
        }
        return xa;
    }

    private string GetConnectionString()
    {
        return ConfigurationManager.ConnectionStrings["dbConnection"].ConnectionString;
    }

    /// <summary>
    /// Return POD name from Database
    /// </summary>
    /// <param name="DocketNo"></param>
    /// <returns></returns>
    private DataSet GetPODData(string DocketNo)
    {

        return SqlHelper.ExecuteDataset(GetConnectionString(), CommandType.StoredProcedure, "Usp_Get_PODLink", new SqlParameter[] 
                    {                       
                        new SqlParameter("@DocketNo",DocketNo)
                    });
    }


    /// <summary>
    ///  Check POD Exist Or Not Response
    /// </summary>
    /// <param name="objRequest"></param>
    /// <returns></returns>
    [WebMethod]
    public PODLinkResponse GetPODLink(string DockNo)
    {
        DataSet ds = new DataSet();
        PODLinkResponse objResponse = new PODLinkResponse();
        ds = GetPODData(DockNo);
        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            objResponse.PODLink = AzureStorageHelper.GetBlobViewLink(ds.Tables[0].Rows[0]["PODName"].ToString());
            objResponse.IsSuccess = Convert.ToBoolean(ds.Tables[0].Rows[0]["IsSuccess"].ToString());
            objResponse.ErrorMessage = ds.Tables[0].Rows[0]["ErrorMessage"].ToString();
        }
        return objResponse;
    }
}
