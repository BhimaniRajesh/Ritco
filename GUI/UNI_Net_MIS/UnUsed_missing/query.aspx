<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="query.aspx.cs" Inherits="GUI_UNI_MIS_UnUsed_missing_query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="JavaScript" SRC="./../../Images/CalendarPopup.js"></script> 
<script language="javascript" src="./../../images/commonJs.js"></script>
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
       /* if(!FinDateCheck())
            return false;     */        
     }

</script>
    <div align="center">
 <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                    <ContentTemplate>
                                    <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                                <ProgressTemplate>
                                    <div id="progressArea">
                                        <asp:Label ID="lblLS" runat="server" Text="Please wait..." ForeColor="red" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                        <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
</div>
    <br />
    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>
                            &gt; </strong><strong>Document Series Control Report</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1"></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
<img alt="Back" src="./../../images/back.gif" border="0"> </a>
</td>
            </tr>
            <tr>
                <td height="300" valign="top">
    <div align="left">
        <table cellspacing="1" style="width: 9.0in" class="boxbg" align="left">
            <tr class="bgbluegrey">
                <td colspan="4" align="center" style="height: 21px">
                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Sales Criteria </asp:Label>
                </td>
            </tr>
           <tr style="background-color: white">
                            <td align="left" colspan="4">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Booking Date</font>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                 <tr style="background-color: white">
                <td  align="left">
                    <asp:Label ID="Label1" CssClass="blackfnt" Text="Series Containing :" runat="server"
                        Width="102px"></asp:Label>
                </td>
                <td colspan="3" align="left"><asp:TextBox ID="txtcustcd" runat="server" ></asp:TextBox></td>
               
                </tr>
                
            <tr align="center" bgcolor="white">
                <td  colspan="4">
                <asp:RadioButtonList  ID="rpttyp" RepeatDirection="horizontal"   CssClass="blackfnt"  runat="server">
                <asp:ListItem  Selected="True" Text="Missing List " Value="M"></asp:ListItem>
                <asp:ListItem    Text="UnUsed List" Value="U"></asp:ListItem>
                 
                 
                </asp:RadioButtonList>
                 </td>
            </tr>
            <tr bgcolor="white"> <td  colspan="7"></td></tr>
            <tr align="center" bgcolor="white">
                <td  colspan="7">
                <asp:Button  ID="btnShow"  OnClick="btnShow_Click" OnClientClick="Javascript:return OnSub_DATACHECK();"  runat="server" Text="Show" Width="75px" />
                 </td>
            </tr>
        </table>
        </td>
            </tr>
        </table>
    </div>
     <DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV>
</asp:Content><%--OnClick="btnShow_Click"--%>
