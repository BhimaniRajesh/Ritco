<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="query_new.aspx.cs" Inherits="GUI_query_darshan" %>

<%@ Register TagName="DT" TagPrefix="DT" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="LOC" TagPrefix="LOC" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="LOC_TO" TagPrefix="LOC_TO" Src="~/GUI/Common_UserControls/Region_Loc.ascx"%>




<asp:Content ContentPlaceHolderID="MyCPH1" ID="content1" runat="server">
 <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="PAYTYP" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster1" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="TRN" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster2" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="SVCTYP" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
     <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster3" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="BUT" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>

    <script id="s1" language="javascript" type="text/javascript" src="./../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" src="./../../images/CalendarPopup.js"></script>
     <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
	        cal.setCssPrefix("TEST");
	        cal.showNavigationDropdowns();

	        function cust(ID) {
	            ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
	            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
	            var strPopupURL = "../PopUp_Cust.aspx?ID=" + ID

	            winNew = window.open(strPopupURL, "_blank", strWinFeature)
	        }
        
	 </script>
   <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 26/5/2014 --%>
<table width="1000" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td style="height: 30px">
                    <font class="blklnkund"><strong>&gt; </strong><strong>Salse Profitability</strong></font> 
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
                    <td></td>
                </td>
            </tr>
            <tr>
              <td height="300" valign="top">
                 <table id="Rules" border="0" cellspacing="1" cellpadding="3" class="boxbg" width="800">
                    <tr class="bgwhite">
                        <td colspan="2" class="bgbluegrey"><center><strong>Salse Profitability</strong></center></td>
                    </tr>
                    <tr class="bgwhite">
                        <td width="30%">Select Location</td>
                        <td width="70%"><LOC:LOC ID="LOC" runat="server" /></td>
                    </tr>
                    </tr>
                    <tr class="bgwhite">
                        <td width="30%">Select Zone</td>
                        <td width="70%"><loc_to:loc_to ID="LOC_TO" runat="server" /></td>
                    </tr>
                    
                    <tr class="bgwhite">
                       <td>Select&nbsp;<asp:DropDownList ID="Date" runat="server">
                                <asp:ListItem Text="Booking Date" Value="1"></asp:ListItem>
                                <asp:ListItem Text="EDD Date" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                 
                        <td width="70%"><DT:DT ID="DT" runat="server" /></td>
                    </tr>
                    <tr class="bgwhite">
                        <td width="30%">Select Paybas</td>
                        <td width="70%"><asp:DropDownList ID="dbpaybas" runat="server" DataSourceId="MySQLDataSource_GeneralMaster" DataTextField="CodeDesc" DataValueField="CodeId" >
                                        </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td width="30%">Select Mode</td>
                        <td width="70%"><asp:DropDownList ID="dbmode" runat="server" DataSourceId="MySQLDataSource_GeneralMaster1" DataTextField="CodeDesc" DataValueField="CodeId" >
                                        </asp:DropDownList>
                        </td>
                    </tr>
                     <tr class="bgwhite">
                        <td width="30%">Select Service Class</td>
                        <td width="70%"><asp:DropDownList ID="dbSclass" runat="server" DataSourceId="MySQLDataSource_GeneralMaster2" DataTextField="CodeDesc" DataValueField="CodeId" >
                                        </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td width="30%">Select Business Type</td>
                        <td width="70%"><asp:DropDownList ID="dbbusinesstype" runat="server" DataSourceId="MySQLDataSource_GeneralMaster3" DataTextField="CodeDesc" DataValueField="CodeId" >
                                        </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td width="30%">Select Report Type</td>
                        <td width="70%"><asp:DropDownList ID="dbrptype" runat="server">
                                            <asp:ListItem Text="Region Wise Location Wise" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Zone Wise Location Wise" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Cusomer Wise Location Wise" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Pay Basis Wise" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="Trans Mode Wise" Value="5"></asp:ListItem>
                                            <asp:ListItem Text="Booking type Wise" Value="6"></asp:ListItem>
                                            <asp:ListItem Text="Bussiness type Wise" Value="7"></asp:ListItem>
                                        </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td width="30%">Select Report Type</td>
                        <td width="70%"><asp:DropDownList ID="dbsubrptype" runat="server">
                                            <asp:ListItem Text="Register" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Summary" Value="2"></asp:ListItem>
                                        </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                            <td align="left">
                                <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Customer" runat="server"></asp:Label>
                            </td>
                            <td align="Left">
                                <asp:TextBox ID="txtCustomer" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                    type="button" onclick="cust('C');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr class="bglightblue">
                            <td align="center" colspan="2">OR</td>
                        </tr>
                    <tr class="bgwhite">
                            <td align="left">
                                <asp:Label ID="lblno" CssClass="blackfnt" runat="server"></asp:Label>
                            </td>
                            <td align="Left">
                                <asp:TextBox ID="txtdocket" Enabled="true" runat="server" Width="234"></asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                     <tr class="bgwhite">
                        <td colspan="2" align="center"><asp:Button ID="btn_submit" runat="server" 
                                Text="Submit" onclick="btn_submit_Click" />
                        </td>
                    </tr>
                    
                 </table>
              </td>
           </tr>
     </table>
	
<div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
