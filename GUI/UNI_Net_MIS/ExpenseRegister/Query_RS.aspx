<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query_RS.aspx.cs" Inherits="GUI_UNI_NET_MIS_ExpenseRegister_Query_RS" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="LH_to" TagPrefix="Location_to" Src="~/GUI/Common_UserControls/LocationHirarchy_to.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../../Images/CalendarPopup.js" type="text/javascript"></script>

    <script language="javascript" src="./../../images/commonJs.js" type="text/javascript"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();

function SelectPartyCode()
     {
    
       // var ddl = document.getElementById('ctl00_MyCPH1_documet_type');
       // alert("Hiiiiii")
        
       if(document.getElementById("ctl00_MyCPH1_documet_type_0").checked ==true)
        {
       
            document.getElementById('ctl00_MyCPH1_tbl_dkt').style.display = "none";           
            document.getElementById('ctl00_MyCPH1_tbl_thc').style.display = "block";            
            document.getElementById('ctl00_MyCPH1_tbl_CHKdkt').style.display = "none";
            document.getElementById('ctl00_MyCPH1_tbl_thcchk').style.display = "block";
            document.getElementById('ctl00_MyCPH1_tbl_DRSchk').style.display = "none";  
            document.getElementById('ctl00_MyCPH1_tbl_PRSchk').style.display = "none";
            document.getElementById('ctl00_MyCPH1_tbl_prs').style.display = "none";  
            
        }
        else if(document.getElementById("ctl00_MyCPH1_documet_type_1").checked ==true)
        {
       
            document.getElementById('ctl00_MyCPH1_tbl_dkt').style.display = "none";           
            document.getElementById('ctl00_MyCPH1_tbl_thc').style.display = "none";            
            document.getElementById('ctl00_MyCPH1_tbl_CHKdkt').style.display = "none";
            document.getElementById('ctl00_MyCPH1_tbl_thcchk').style.display = "none";
            document.getElementById('ctl00_MyCPH1_tbl_DRSchk').style.display = "none";  
            document.getElementById('ctl00_MyCPH1_tbl_PRSchk').style.display = "block";
            document.getElementById('ctl00_MyCPH1_tbl_prs').style.display = "block";  
            
        }
        
     }


	
	
	function OnSub_DATACHECK()
     {
     //alert("HIii")
        if(!DateCheck())
            return false;
      //  alert("HIii")
        if(!FinDateCheck())
            return false;             
     }
    </script>

    <div align="center">
        <asp:UpdatePanel ID="UpdatePanel6" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                    <ProgressTemplate>
                        <div id="progressArea">
                            <asp:Label ID="lblLS" runat="server" Text="Please wait..." ForeColor="red" CssClass="blackfnt"
                                Font-Bold="true"></asp:Label>
                            <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <br />
    <div align="left">
        <table style="width: 7.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Expense Register</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1"></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <table cellspacing="1" style="width: 7.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="7" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Sales Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                            <td align="left" colspan="3">
                                <asp:Label ID="Label12" CssClass="blackfnt" Text="Select Document Type" runat="server"></asp:Label></td>
                            <td align="left" colspan="4" valign="top">
                                <asp:RadioButtonList ID="documet_type" runat="server" RepeatDirection="horizontal"
                                    CssClass="blackfnt" OnClick="Javascript:return SelectPartyCode()">
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td align="center" colspan="3">
                                <font class="blackfnt">From</font>
                            </td>
                            <td align="center" colspan="4">
                                <font class="blackfnt">To</font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="3">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                            <td align="left" colspan="4">
                                <Location_to:LH_to ID="Tolc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="3">
                                <font class="blackfnt">Select Documnet Date</font>
                            </td>
                            <td align="left" colspan="4">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="7">
                                <asp:UpdatePanel ID="updatepanel4" runat="server">
                                    <ContentTemplate>
                                        <!-- #include file="./../OPN_DOC_Register/SelectList_DKT.aspx"-->
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="documet_type" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server" Text=" OR "></asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td colspan="7">
                                <asp:Label ID="Labesys" CssClass="blackfnt" runat="server" Text=" Document No(s). (System Generated No.) :� "></asp:Label>
                                <asp:TextBox runat="server" Text="" ID="txtsysno" Width="250"> </asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="7">
                                <asp:UpdatePanel ID="updatepanel5" runat="server">
                                    <ContentTemplate>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="documet_type" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td colspan="7" align="center" style="height: 21px">
                                <asp:RadioButtonList ID="rptfrt" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Selected="True" Text="HTML Format" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="XLS Download" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="CSV Download" Value="3"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript: return OnSub_DATACHECK();"
                                    runat="server" Text="Show" Width="75px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
