<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_DKT_Profi_Query" %>

<%@ Register TagName="HR" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="HR_To" TagPrefix="Location_To" Src="~/GUI/Common_UserControls/LOC_HRCHY_TO.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
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
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster3" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="BUT" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
         function OnSub_DATACHECK()
     {
     //alert("HIii")
        if(!DateCheck())
            return false;
      //  alert("HIii")
        //if(!FinDateCheck())
        //    return false;             
     }
    </script>

    <div align="left">
        <table style="width: 8.5in" border="0" align="left" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td height="30">
                   
                        </strong><strong>Sales Profitability</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1"></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0">
                    </a>
                    <div align="Left">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                                <br />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                </td>
            </tr>
             <input type="hidden" id="hdnRptId" runat="server" />
            <tr>
                <td height="300" valign="top">
                    <table cellspacing="1" cellpadding="3" style="width: 8.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Documents Criteria </asp:Label>
                            </td>
                        </tr>
                        
                        <tr  style="background-color: white">
                            <td colspan="2"  align="left">
                                <Location:HR  ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td  align="center">
                                <font class="blackfnt">Select Booking Date </font>
                            </td>
                            <td align="left">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr id="dkttr1" runat="server" style="background-color: white; display: block;">
                            <td align="left">
                                <font class="blackfnt">Select Paybas</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="cboPaybas" DataSourceID="MySQLDataSource_GeneralMaster2"
                                    DataTextField="CodeDesc" DataValueField="CodeID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="dkttr2" runat="server" style="background-color: white; display: block;">
                            <td align="Left">
                                <font class="blackfnt">Select Mode</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="cboMode" DataSourceID="MySQLDataSource_GeneralMaster"
                                    DataTextField="CodeDesc" DataValueField="CodeID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="dkttr3" runat="server" style="background-color: white; display: block;">
                            <td align="Left">
                                <font class="blackfnt">Select Service Type</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="cboType" DataSourceID="MySQLDataSource_GeneralMaster1"
                                    DataTextField="CodeDesc" DataValueField="CodeID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="dkttr4" runat="server" style="background-color: white; display: block;">
                            <td align="Left">
                                <font class="blackfnt">Select Business Type</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="cboBUTType" DataSourceID="MySQLDataSource_GeneralMaster3"
                                    DataTextField="CodeDesc" DataValueField="CodeID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="dkttr5" runat="server" align="left" style="background-color: white; display: block;">
                            <td align="left">
                                <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Customer" runat="server"></asp:Label>
                            </td>
                            <td align="Left">
                                <asp:TextBox ID="txtCustomer" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                    type="button" onclick="cust('C');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                                
                            </td>
                        </tr>
                        <tr id="Tr1" runat="server" align="left" style="background-color: white; display: block;">
                            <td align="center" colspan="2" >
                                <asp:Label ID="Label2" CssClass="blackfnt" Text="OR" runat="server"></asp:Label>
                            </td>
                            
                        </tr>
                        <tr id="Tr2" runat="server" align="left" style="background-color: white; display: block;">
                            <td align="left">
                                <asp:Label ID="Label3" CssClass="blackfnt" Text="Enter Document No." runat="server"></asp:Label>
                            </td>
                            <td align="Left">
                                <asp:TextBox ID="txtxdocknolist" Enabled="true" runat="server" Width="234"></asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                         <tr id="Tr3" runat="server" align="left" style="background-color: white; display: block;">
                            <td align="center" colspan="2" >
                                <asp:RadioButtonList ID="rpttyp"   RepeatDirection="horizontal" runat="server" CssClass="blackfnt"  >
                                <asp:ListItem Selected="true" Text="Summary" Value="0"  ></asp:ListItem>
                                <asp:ListItem Text="Register" Value="1"  ></asp:ListItem></asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript: return OnSub_DATACHECK();"
                                    runat="server" Text="Submit" Width="75px" />
                            </td>
                        </tr>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
