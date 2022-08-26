<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ViewFMMemoDetails.aspx.cs" Inherits="GUI_Operations_FM_ViewFMMemoDetails"
    Title="FM - Acknowledge Forwarded Document(s) - Memo Details" %>

<%@ OutputCache Location="none" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">        
        function disableenter()
        {
        
        }
               
        function FMDocReceived(objFMDoc)
        {
            var mAckFMDocs = "";
            var mAckFMDocsTemp = "";
            var mArrAckFMDocs;
            
            if(document.getElementById("ctl00_MyCPH1_HidAckFMDocs"))
            {
                mAckFMDocs = document.getElementById("ctl00_MyCPH1_HidAckFMDocs").value;
            }
            
            if(objFMDoc.checked == true)
            {
                mAckFMDocs = (mAckFMDocs == "" ? objFMDoc.value : mAckFMDocs + "," + objFMDoc.value);
            }
            else
            {
                mArrAckFMDocs = mAckFMDocs.split(',');
                
                for(var mLoopCounter = 0; mLoopCounter < mArrAckFMDocs.length; mLoopCounter++)
                {
                    if(objFMDoc.value != mArrAckFMDocs[mLoopCounter])
                    {
                        mAckFMDocsTemp = (mAckFMDocsTemp == "" ? mArrAckFMDocs[mLoopCounter] : mAckFMDocsTemp + "," + mArrAckFMDocs[mLoopCounter]); 
                    }
                }
                mAckFMDocs = mAckFMDocsTemp; 
            }            
            document.getElementById("ctl00_MyCPH1_HidAckFMDocs").value = mAckFMDocs;
        }
            
    </script>
    <script language="javascript" type="text/javascript">
        
        function ValidateData()
        {   
            if(document.getElementById("ctl00_MyCPH1_HidAckFMDocs"))
            {
                if(document.getElementById("ctl00_MyCPH1_HidAckFMDocs").value == "")
                {
                    alert("Select/Check atleast one FM Details!");
                    return false;
                }
            }
            else
            {
                alert("Hidden variable not found for storing Acknowledgement Details!");
                return false;
            }
            
            return true;
        }
        
    </script>
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute;
                z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
            </iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                    Wait...</b></font></div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <label class="blackfnt">
                        <b>View FM Memo Details </b>
                        <hr align="center" size="1" color="#8ba0e5">
                    </label>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="width: 39%" valign="top">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td valign="top">
                                                        <br />
                                                        <center>
                                                            <table border="0" class="boxbg" cellspacing="1" cellpadding="1" width="100%">
                                                                <tr class="bgbluegrey">
                                                                    <td align="center" colspan="6" style="height: 30px;">
                                                                        <label class="blackfnt">
                                                                            <b>Document Forwarding Memo </b>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                <tr style="background-color: White">
                                                                    <td align="left" style="width: 17%">
                                                                        <label class="blackfnt">
                                                                            FM Number:
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 15%" align="left">
                                                                        <label class="blackfnt" runat="server" id="lblFMNo">
                                                                        </label>
                                                                    </td>
                                                                    <td align="left" style="width: 14%" nowrap>
                                                                        <label class="blackfnt">
                                                                            FM Date:
                                                                        </label>
                                                                    </td>
                                                                    <td align="left" style="width: 25%" nowrap>
                                                                        <label class="blackfnt" runat="server" id="lblFMDate">
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                <tr style="background-color: White">
                                                                    <td align="left" style="width: 17%" nowrap>
                                                                        <label class="blackfnt">
                                                                            Manual FM Number:
                                                                        </label>
                                                                    </td>
                                                                    <td align="left" style="width: 25%" nowrap>
                                                                        <label class="blackfnt" runat="server" id="lblManualFMNo">
                                                                        </label>
                                                                    </td>
                                                                    <td align="left" style="width: 14%" nowrap>
                                                                        <label class="blackfnt">
                                                                            FM Entry Date:
                                                                        </label>
                                                                    </td>
                                                                    <td align="left">
                                                                        <label class="blackfnt" runat="server" id="lblFMEntryDate">
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                <tr style="background-color: White">
                                                                    <td align="left" style="width: 17%">
                                                                        <label class="blackfnt">
                                                                            Forward Document To:
                                                                        </label>
                                                                    </td>
                                                                    <td align="left" style="width: 15%">
                                                                        <label class="blackfnt" runat="server" id="lblFwdDocTo">
                                                                        </label>
                                                                    </td>
                                                                    <td align="left" style="width: 14%" nowrap>
                                                                        <label class="blackfnt">
                                                                            Customer/Location:
                                                                        </label>
                                                                    </td>
                                                                    <td align="left" colspan="3">
                                                                        <label class="blackfnt" runat="server" id="lblCustLoc">
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                <tr style="background-color: White">
                                                                    <td align="left" style="width: 17%">
                                                                        <label class="blackfnt">
                                                                            Document Type:
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 15%" align="left">
                                                                        <label class="blackfnt" id="lblDocType" runat="server">
                                                                        </label>
                                                                    </td>
                                                                    <td align="left" style="width: 14%" nowrap>
                                                                        <label class="blackfnt">
                                                                            Courier Name:
                                                                        </label>
                                                                    </td>
                                                                    <td align="left" colspan="3">
                                                                        <label class="blackfnt" id="lblCourier" runat="server">
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                <tr style="background-color: White">
                                                                    <td align="left" style="width: 17%">
                                                                        <label class="blackfnt">
                                                                            Way Bill No.:
                                                                        </label>
                                                                    </td>
                                                                    <td style="width: 15%" align="left">
                                                                        <label class="blackfnt" id="lblWayBillNo" runat="server">
                                                                        </label>
                                                                    </td>
                                                                    <td align="left" style="width: 14%" nowrap>
                                                                        <label class="blackfnt">
                                                                            Way Bill Date:
                                                                        </label>
                                                                    </td>
                                                                    <td align="left" colspan="3">
                                                                        <label class="blackfnt" id="lblWayBillDate" runat="server">
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <br />                                                            
                                                            <table border="0" cellspacing="0" cellpadding="1" width="100%" class="boxbg">
                                                                <tr style="background-color: White" id="trDocketList" runat="server" visible="false">
                                                                    <td style="width: 100%">
                                                                        <table cellspacing="1" cellpadding="1" border="0" width="100%" class="boxbg">
                                                                            <tr style="background-color: White; height: 20px;" runat="server">
                                                                                <td align="left" id="tdColSpanForFMFWDCaption" runat="server" colspan="8">
                                                                                    <label class="blackfnt">
                                                                                        <b>Document Forwarding Memo Details </b>
                                                                                    </label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr class="bgbluegrey" id="trTableHeadersForDocket" runat="server" visible="false">
                                                                                <td align="center">
                                                                                    <label class="blackfnt">
                                                                                        <b>Sr. No. </b>
                                                                                    </label>
                                                                                </td>
                                                                                <td align="left">
                                                                                    <label class="blackfnt">
                                                                                        <b>
                                                                                            <%=Session["DocketCalledAs"].ToString()%>
                                                                                            No.
                                                                                            <br />
                                                                                            | Date </b>
                                                                                    </label>
                                                                                </td>
                                                                                <td align="left">
                                                                                    <label class="blackfnt">
                                                                                        <b>Document No.
                                                                                            <br />
                                                                                            | Date </b>
                                                                                    </label>
                                                                                </td>
                                                                                <td align="left">
                                                                                    <label class="blackfnt">
                                                                                        <b>Amount </b>
                                                                                    </label>
                                                                                </td>
                                                                                <td align="left">
                                                                                    <label class="blackfnt">
                                                                                        <b>Origin-Destination </b>
                                                                                    </label>
                                                                                </td>
                                                                                <td align="left">
                                                                                    <label class="blackfnt">
                                                                                        <b>From-To </b>
                                                                                    </label>
                                                                                </td>
                                                                                <td align="left">
                                                                                    <label class="blackfnt">
                                                                                        <b>Delivery Date </b>
                                                                                    </label>
                                                                                </td>
                                                                                <td align="center">
                                                                                    <label class="blackfnt">
                                                                                        <b>Received </b>
                                                                                    </label>
                                                                                </td>
                                                                            </tr>
                                                                            <asp:Repeater ID="rptDocketList" runat="server" Visible="false">
                                                                                <ItemTemplate>
                                                                                    <tr style="background-color: White">
                                                                                        <td align="center">
                                                                                            <label class="blackfnt">
                                                                                                <%#DataBinder.Eval(Container.DataItem, "SrNo")%>
                                                                                            </label>
                                                                                        </td>
                                                                                        <td align="left">
                                                                                            <label class="blackfnt">
                                                                                                <%#DataBinder.Eval(Container.DataItem, "DocketNo")%>
                                                                                                <br />
                                                                                                <%#DataBinder.Eval(Container.DataItem, "DocketDate")%>
                                                                                            </label>
                                                                                        </td>
                                                                                        <td align="left">
                                                                                            <label class="blackfnt">
                                                                                                <%#DataBinder.Eval(Container.DataItem, "DocumentNo")%>
                                                                                                <br />
                                                                                                <%#DataBinder.Eval(Container.DataItem, "DocumentDate")%>
                                                                                            </label>
                                                                                        </td>
                                                                                        <td align="left">
                                                                                            <label class="blackfnt">
                                                                                                <%#DataBinder.Eval(Container.DataItem, "Amount")%>
                                                                                            </label>
                                                                                        </td>
                                                                                        <td align="left">
                                                                                            <label class="blackfnt">
                                                                                                <%#DataBinder.Eval(Container.DataItem, "OrgnDest")%>
                                                                                            </label>
                                                                                        </td>
                                                                                        <td align="left">
                                                                                            <label class="blackfnt">
                                                                                                <%#DataBinder.Eval(Container.DataItem, "FromToLoc")%>
                                                                                            </label>
                                                                                        </td>
                                                                                        <td align="left">
                                                                                            <label class="blackfnt">
                                                                                                <%#DataBinder.Eval(Container.DataItem, "DelyDate")%>
                                                                                            </label>
                                                                                        </td>
                                                                                        <td align="center">
                                                                                            <input type="checkbox" id="chkReceive" runat="server" value='<%#DataBinder.Eval(Container.DataItem, "ID")%>'
                                                                                                onclick="FMDocReceived(this)" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </ItemTemplate>
                                                                            </asp:Repeater>
                                                                            <tr class="bgbluegrey" id="trBillList" runat="server" visible="false">
                                                                                <td align="center">
                                                                                    <label class="blackfnt">
                                                                                        <b>Sr. No. </b>
                                                                                    </label>
                                                                                </td>
                                                                                <td align="left">
                                                                                    <label class="blackfnt">
                                                                                        <b>Bill No. </b>
                                                                                    </label>
                                                                                </td>
                                                                                <td align="left">
                                                                                    <label class="blackfnt">
                                                                                        <b>Manual Bill No. </b>
                                                                                    </label>
                                                                                </td>
                                                                                <td align="left">
                                                                                    <label class="blackfnt">
                                                                                        <b>Bill Date </b>
                                                                                    </label>
                                                                                </td>
                                                                                <td align="left">
                                                                                    <label class="blackfnt">
                                                                                        <b>Billing Party </b>
                                                                                    </label>
                                                                                </td>
                                                                                <td align="left">
                                                                                    <label class="blackfnt">
                                                                                        <b>Bill Amount (in Rs.) </b>
                                                                                    </label>
                                                                                </td>
                                                                                <td align="left">
                                                                                    <label class="blackfnt">
                                                                                        <b>Submission Location </b>
                                                                                    </label>
                                                                                </td>
                                                                                <td align="center">
                                                                                    <label class="blackfnt">
                                                                                        <b>Received </b>
                                                                                    </label>
                                                                                </td>
                                                                            </tr>
                                                                            <asp:Repeater ID="rptBillList" runat="server" Visible="false">
                                                                                <ItemTemplate>
                                                                                    <tr style="background-color: White">
                                                                                        <td align="center">
                                                                                            <label class="blackfnt">
                                                                                                <%#DataBinder.Eval(Container.DataItem, "SrNo")%>
                                                                                            </label>
                                                                                        </td>
                                                                                        <td align="left">
                                                                                            <label class="blackfnt">
                                                                                                <%#DataBinder.Eval(Container.DataItem, "BillNo")%>
                                                                                            </label>
                                                                                        </td>
                                                                                        <td align="left">
                                                                                            <label class="blackfnt">
                                                                                                <%#DataBinder.Eval(Container.DataItem, "ManualBillNo")%>
                                                                                            </label>
                                                                                        </td>
                                                                                        <td align="left">
                                                                                            <label class="blackfnt">
                                                                                                <%#DataBinder.Eval(Container.DataItem, "BillDate")%>
                                                                                            </label>
                                                                                        </td>
                                                                                        <td align="left">
                                                                                            <label class="blackfnt">
                                                                                                <%#DataBinder.Eval(Container.DataItem, "BillingParty")%>
                                                                                            </label>
                                                                                        </td>
                                                                                        <td align="left">
                                                                                            <label class="blackfnt">
                                                                                                <%#DataBinder.Eval(Container.DataItem, "BillAmount")%>
                                                                                            </label>
                                                                                        </td>
                                                                                        <td align="left">
                                                                                            <label class="blackfnt">
                                                                                                <%#DataBinder.Eval(Container.DataItem, "SubmissionLocation")%>
                                                                                            </label>
                                                                                        </td>
                                                                                        <td align="center">
                                                                                            <input type="checkbox" id="chkReceiveForBill" runat="server" value='<%#DataBinder.Eval(Container.DataItem, "ID")%>'
                                                                                                onclick="FMDocReceived(this)" />
                                                                                        </td>
                                                                                    </tr>
                                                                                </ItemTemplate>
                                                                            </asp:Repeater>
                                                                            <tr style="background-color: White" runat="server" id="trForwardDocument" visible="false">
                                                                                <td align="center" id="tdSubmit" runat="server" colspan="8">
                                                                                    <br style="font-size: 4pt;" />
                                                                                    <asp:Button ID="btnSubmit" Text="Submit" runat="server" OnClientClick="return ValidateData()"
                                                                                        OnClick="btnSubmit_Click" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr style="background-color: White" runat="server" id="trErrorMsg" visible="false">
                                                                                <td id="tdErrorMsg" runat="server" align="left" colspan="8">
                                                                                    <label runat="server" class="blackfnt" style="color: Red;" id="lblFMFWDDocErrorMsg">
                                                                                    </label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <input type="hidden" id="HidTotalRecords" runat="server" />
                                                            <input type="hidden" id="HidSelectedDocketNos" runat="server" />
                                                            <input type="hidden" id="HidSelectedDockets" runat="server" />
                                                            <input type="hidden" id="HidAckFMDocIDs" runat="server" />
                                                            <input type="hidden" id="HidFMID" runat="server" />
                                                            <input type="hidden" id="HidFMNo" runat="server" />
                                                            <input type="hidden" id="HidAckFMDocs" runat="server" />
                                                        </center>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
