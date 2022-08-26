<%@ Page Language="C#"  MasterPageFile="~/CustomerLogin/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_Cust_Tracking_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/CustomerLogin/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="LH_to" TagPrefix="Location_to" Src="~/CustomerLogin/GUI/Common_UserControls/LocationHirarchy_to.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/CustomerLogin/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
 <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="TRN" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
     <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster1" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="SVCTYP" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
     <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster2" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="PAYTYP" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>

    <script language="JavaScript" type="text/javascript" src="./../Images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript"  src="./../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	function OnSub_DATACHECK()
     {     
     
     //alert("HIii")
     
        if(!DateCheck())
            return false;
      //  alert("HIii")
        //if(!FinDateCheck())
           // return false;          
     }</script>
     
     
     <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"></font><font class="bluefnt"><strong>
                            &gt; </strong><strong>Tracking</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../images/clear.gif" width="2" height="1" /></td>
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
                        <img alt="Back" src="./../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <table cellspacing="1" style="width: 8.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="0">
                                <font class="blackfnt"></font>
                            </td>
                            <td colspan="4">
                                <font class="blackfnt"><b>Select Sales Criteria</b></font>
                            </td>
                        </tr>
                        <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                            <td align="left" colspan="2">
                                <asp:Label ID="Label12" CssClass="blackfnt" Text="Select Document Type" runat="server"></asp:Label></td>
                            <td align="left" colspan="2" valign="top">
                                <asp:DropDownList ID="documet_type"  OnChange="Javascript:return DOCTYPEChange();" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td align="center" colspan="2" style="width: 3.5in">
                                <font class="blackfnt">From</font>
                            </td>
                            <td align="center" colspan="2">
                                <font class="blackfnt">To</font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="2">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                            <td align="left" colspan="2">
                                <Location_to:LH_to ID="Tolc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="2">
                                <font class="blackfnt">Select Documnet Date</font>
                            </td>
                            <td align="left" colspan="2">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                         <tr style="background-color: white">
                            <td align="center" colspan="2">
                                <font class="blackfnt">Select Paybas</font>
                            </td>
                            <td align="left" colspan="2">
                                 <asp:DropDownList runat="server" ID="cboPaybas"  DataSourceID="MySQLDataSource_GeneralMaster2"
                            DataTextField="CodeDesc" DataValueField="CodeID" >
                        </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="2">
                                <font class="blackfnt">Select Mode</font>
                            </td>
                            <td align="left" colspan="2">
                                 <asp:DropDownList runat="server" ID="cboMode"  DataSourceID="MySQLDataSource_GeneralMaster"
                            DataTextField="CodeDesc" DataValueField="CodeID" >
                        </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="2">
                                <font class="blackfnt">Select Type</font>
                            </td>
                            <td align="left" colspan="2">
                                 <asp:DropDownList runat="server" ID="cboType" DataSourceID="MySQLDataSource_GeneralMaster1"
                            DataTextField="CodeDesc" DataValueField="CodeID" >
                        </asp:DropDownList>
                            </td>
                        </tr>
                       
                        <tr id="TRN1" runat="server"  style="background-color: white;display:none;">
                            <td align="left" colspan="2">
                                <font class="blackfnt">Document No(s). (System Generated No.) :</font>
                            </td>
                            <td align="left" colspan="2">
                                <asp:TextBox runat="server" Text="" ID="txtsysno" Width="250"> </asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr id="TRN2" runat="server"  style="background-color: white;display:none;">
                            <td align="left" colspan="2">
                                <font class="blackfnt">Document No(s). (Manual No./Invoice No.):</font>
                            </td>
                            <td align="left" colspan="2">
                                <asp:TextBox runat="server" Text="" ID="txtmanno" Width="250"> </asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr  id="TRN3" runat="server"  style="background-color: white;display:none;">
                            <td align="left" colspan="2">
                                <font class="blackfnt">Customer Ref. No./Vehicle No. :</font>
                            </td>
                            <td align="left" colspan="2">
                                <asp:TextBox runat="server" Text="" ID="txtCustRefno" Width="250"> </asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr id="TRN4" runat="server"  style="background-color: white;display:none;">
                            <td align="left" colspan="2">
                                <font class="blackfnt">Free Text :</font>
                            </td>
                            <td align="left" colspan="2">
                                <asp:TextBox runat="server" Text="" ID="txtFreeText" Width="250"> </asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" runat="server" Text="Show" Width="75px" />
                            </td>
                            <%--OnClientClick="Javascript: return DateCheck();"--%>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
