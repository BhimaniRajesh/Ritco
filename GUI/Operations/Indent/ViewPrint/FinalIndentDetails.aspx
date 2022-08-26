<%@ Page Language="C#" AutoEventWireup="true" 
CodeFile="FinalIndentDetails.aspx.cs" Inherits="GUI_Operations_Indent_IndentView_FinalIndentDetails" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagPrefix="PgBar" TagName="ProgressBar" %>

<script type="text/javascript" language="javascript" src="Indent.js"></script>

<script language="javascript" type="text/javascript">
        function ViewPrint() {
           
	    var prtContent = document.getElementById("divExecutionIndentHdr");
            var btnPrint = document.getElementById("btnPrint")
            btnPrint.style.display = 'none';
            var WinPrint = window.open('', '', 'letf=0,top=05,width=1500,height=600,toolbar=0,scrollbars=0,status=0,dir=ltr');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
        }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" /> 
</head>
<body>
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>

    <div id="divExecutionIndentHdr" runat="server">
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="60%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Final Indent Details Module" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" colspan="3">
                <table border="1" cellpadding="0" cellspacing="0" style="width: 100%;" class="bgbluegrey">
                            <tr align="center" class="bgbluegrey blackboldfnt">
                                <td>Sl.No</td>
                                <td>Docket Number</td>
                                <td>Location</td>
                                <td>Delivery Party Name</td>
                                <td>Billing Party Name</td>
                                <td>Mobile Number</td>
                                <td>Remarks</td>
                                <td>Number of Pkts</td>
                                <td>Number of Pkts Dispatched</td>
                                <td>Material</td>
                                <td>From City</td>
                                <td>To City</td>
                                <td>Booking Station</td>
                                <td>Cust. Ref.</td>
                                <td>Consignor</td>
                                <td>Consignee</td>
                                <td>Weight</td>
                                <td>Delivery Location</td>
                                <td>Status</td>
                                <td>Remarks</td>

                            </tr>
                            <asp:Repeater ID="rptFinnalIndentPendingdocketList" runat="server">
                                <ItemTemplate>
                                        <tr class="bgwhite blackfnt" border="2" cellpadding="0" cellspacing="0" class="bgbluegrey">
                                        <td align="center">
                                            <%#Container.ItemIndex+1 %> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DocketNumber")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label4" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Location")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DeliveryPartyName")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label3" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"BillingPartyName")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label5" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"MobileNumber")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label6" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Remarks")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label7" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TotalPackages")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label8" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DeliveredPackages")%>'></asp:Label> 
                                        </td>
                                         <td align="center">
                                            <asp:Label ID="Label9" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Material")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label10" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"FromCity")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label11" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ToCity")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label12" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"BookingLocation")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label13" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CustomerRefrence")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label14" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Consignor")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label15" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Consignee")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label16" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Weight")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label17" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DeliveryLocation")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label18" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DktStatus")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label19" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DktRemarks")%>'></asp:Label> 
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                 </table>
            </td>
        </tr>
        <tr class="bgwhite">
            <td align="center">
               
                 <asp:Label ID="lbl" runat="server" Width="300px" Visible="false"></asp:Label>
<asp:Button runat="server" ID="btnPrint" Text="Print" Width="100px" OnClientClick="javascript:return ViewPrint()" />
            </td>
        </tr>
    </table>
  </div>
<pgbar:progressbar runat="server" id="ProgressBar" />

  </form>
</body>
</html>