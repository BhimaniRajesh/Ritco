<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_NET_MIS_Bill_ENtry_ACCPAY_Query" %>

<%@ Register TagName="HR" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="BETYPE" Type="string" />
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
            var strPopupURL = "./../PopUp_Cust.aspx?ID="+ID
            
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

     <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 22/5/2014 --%>
 <div align="left">
    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                    </strong><strong>Payable Register</strong> </font>
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
        <tr>
            <td height="300" valign="top">
                <table cellspacing="1" cellpadding="3" style="width: 8.5in" class="boxbg" align="left">
                    <tr class="bgbluegrey">
                        <td colspan="2" align="center" style="height: 21px">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Documnets Criteria </asp:Label>
                        </td>
                    </tr>
                    <tr id="Tr1" runat="server" style="background-color: white; display: block;">
                        <td align="left">
                            <font class="blackfnt">Select Location</font>
                        </td>
                        <td align="left">
                            <Location:HR ID="Fromlc" runat="server" />
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="center">
                            <font class="blackfnt">Select
                                <asp:DropDownList ID="DT_TYPE" runat="server">
                                    <asp:ListItem Text="Bill Date" Value="billdt"></asp:ListItem>
                                    <asp:ListItem Text="Entry Date" Value="entrydt"></asp:ListItem>
                                </asp:DropDownList></font>
                        </td>
                        <td align="left">
                            <Date:DT ID="DT" runat="server" />
                        </td>
                    </tr>
                    <tr id="dkttr1" runat="server" style="background-color: white; display: block;">
                        <td align="left">
                            <font class="blackfnt">Select Bill Type</font>
                        </td>
                        <td align="left">
                            <asp:DropDownList runat="server" ID="cbobiltyp" DataSourceID="MySQLDataSource_GeneralMaster"
                                DataTextField="CodeDesc" DataValueField="CodeID">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="tr_vend" runat="server" style="background-color: white; ">
                        <td align="center">
                            <asp:Label ID="Label5" CssClass="blackfnt" Text="Select Vendor" runat="server"></asp:Label>
                        </td>
                        <td align="Left" >
                            <asp:TextBox ID="txtVendor" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                type="button" onclick="cust('V');" value="..." style="width: 18px; height: 21px"
                                size="" />
                            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                        </td>
                    </tr>
                    <tr align="center" bgcolor="white">
                        <td align="center">
                            <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Report Format" runat="server"></asp:Label>
                        </td>
                        <td align="Left" >
                            <asp:RadioButtonList ID="DLLRPTTYP"  RepeatDirection="horizontal"
                                CssClass="blackfnt" runat="server">
                                <asp:ListItem Selected="True" Text="Month Wise" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Bill Type Wise" Value="2"></asp:ListItem>
                                <asp:ListItem Text="none" Value="3"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <%-- <tr align="center" bgcolor="white">
                        <td colspan="6">
                            <asp:RadioButtonList ID="DLLRPTTYP" onClick="javascript:ChkPgsize1(this);" RepeatDirection="horizontal"
                                CssClass="blackfnt" runat="server">
                                <asp:ListItem Selected="True" Text="Register" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Summary" Value="2"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>--%>
                    <tr align="center" bgcolor="white">
                        <td colspan="7">
                            <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript: return OnSub_DATACHECK();"
                                runat="server" Text="Submit" Width="75px" />
                        </td>
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
