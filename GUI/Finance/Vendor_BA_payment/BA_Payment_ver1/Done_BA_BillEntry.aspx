<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Done_BA_BillEntry.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_BA_Payment_ver1_Done_BA_BillEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript" src="../../../Images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	

    </script>
     <script language="javascript" type="text/javascript">
        function ViewPrint(arg1,arg2) 
        { 
        window.open("./ViewPrint/View_BillEntry.aspx?BillNo=" + arg1 + "," + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=590,status=no,left=60,top=125"); 
        }
    </script>

    <div align="left">
        <table style="width: 8.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong>&gt;<font
                            class="blklnkund"><strong> Finance </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>BA Bill Entry</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="../../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" style="width: 8.0in">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="3">
                                <font class="bluefnt"><b>Following document has been successfully generated </b>&nbsp;</font>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                            <td align="center">
                                <font class="blackfnt"><b>Document name</b> </font>
                            </td>
                            <td align="center">
                                <font class="blackfnt"><b>Document No.</b> </font>
                            </td>
                            <td align="center">
                                <font class="blackfnt"><b></b></font>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                            <td align="center">
                                <font class="blackfnt">Bill Entry </font>
                            </td>
                            <td align="center">
                                <font class="blackfnt">
                                    <asp:Label ID="lbldocno" runat="server"></asp:Label></font>
                            </td>
                            <td align="center">
                                <a href="Javascript:ViewPrint('<%=docno%>',0)"><font class="blklnkund">View</font></a>
                                | <a href="Javascript:ViewPrint('<%=docno%>',1)"><font class="blklnkund">Print </font>
                                </a>
                                <%--<font class="blackfnt"> <asp:LinkButton ID="LinkButton2" CssClass="bluefnt" runat="server" Font-Bold="false" Text="View" PostBackUrl="#" /></font>
                 <font class="blackfnt">|</font>
                <font class="blackfnt"> <asp:LinkButton ID="LinkButton3" CssClass="bluefnt" runat="server" Font-Bold="false" Text="XLS" PostBackUrl="#" /></font>
                 <font class="blackfnt">|</font>
                <font class="blackfnt"> <asp:LinkButton ID="LinkButton4" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Email" PostBackUrl="#" /></font>
       --%>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                            <td align="left" colspan="3">
                                <font class="bluefnt"><b>Your Next Step: </b>&nbsp;</font>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                            <%--<td align="center"  class="bullet">
                <font class="blackfnt"><img  src="../../../images/clear.gif"width="4" height="4"/></font>
            </td>--%>
                            <td align="left" colspan="3">
                                <asp:LinkButton ID="LinkButton13" CssClass="blackfnt" runat="server" Font-Bold="false"
                                    Text="Prepare More Bill Entry" PostBackUrl="~/GUI/Finance/VendorPayment_new/BA_Payment/BAPayment_BillEntry_step1.aspx" />
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                            <%--<td align="center"  class="bullet">
                <font class="blackfnt"><img  src="../../../images/clear.gif"width="4" height="4"/></font>
            </td>--%>
                            <td align="left" colspan="3">
                                <asp:LinkButton ID="LinkButton1" CssClass="blackfnt" runat="server" Font-Bold="false"
                                    Text="View & Print Bill Entry" PostBackUrl="#" />
                            </td>
                        </tr>
                    </table>
                </td>
        </table>
        </td> </tr> </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
