<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_NET_MIS_MISFuelPointsReport_Query" %>
<%@ Register TagName="DT" TagPrefix="DT" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
      <script type="text/javascript" language="javascript" src="./../../images/commonJs.js"></script>
    <script type="text/javascript" language="javascript" src="./../../images/CalendarPopup.js"></script>
    <script type="text/javascript" language="JavaScript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
     <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>MIS Fuel Points Report </strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
       <tr>
           <td>

                <table id="selection" border="0" cellspacing="1" cellpadding="3" class="boxbg" width="800">
                         <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Criteria </asp:Label>
                            </td>
                        </tr>
					    <tr class="bgwhite">
                            <td>Select Date                 
                            </td>
                            <td><DT:DT ID="DT" runat="server" /></td>
                        </tr>
                        <tr align="center" bgcolor="white" class="bgwhite">
                            <td colspan="2">
                                <asp:Button ID="btnShow" runat="server" Text="Submit" onclick="btnShow_Click"  />
                            </td>
                        </tr>
        
                  </table>
           </td>
                          </tr>
            </table>
      
        <div id="testdiv1" name="testdiv1" style="position:absolute; visibility: hidden;
            background-color: white; layer-background-color: white; z-index: 99;">
        </div>
</asp:Content>

