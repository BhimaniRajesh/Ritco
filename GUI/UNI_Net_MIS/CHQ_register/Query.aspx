<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_CHQ_register_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
    
   
    
    function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
        function SelectRadio()
        {
            if(document.getElementById("ctl00_MyCPH1_RPT_0").checked ==true)
            {
                document.getElementById('ctl00_MyCPH1_TR1').style.display = "block";
            
                document.getElementById('ctl00_MyCPH1_TR2').style.display = "none";
                document.getElementById('ctl00_MyCPH1_TR3').style.display = "none";           
            }
            else if(document.getElementById("ctl00_MyCPH1_RPT_1").checked ==true)
            {
           
                document.getElementById('ctl00_MyCPH1_TR1').style.display = "none";
            
                document.getElementById('ctl00_MyCPH1_TR2').style.display = "block";
                document.getElementById('ctl00_MyCPH1_TR3').style.display = "block";    
                
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

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();

    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                            class="blklnkund"><strong>Accounts </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>Cheque register</strong></font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1" /></td>
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
                        <img alt="Back" src="./../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table cellspacing="1" style="width: 8.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b>Select Cheque Criteria</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="4">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select </font>
                                <asp:DropDownList ID="DTTYP" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Text="Cheque Date" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Entry Date" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td align="left">
                                <font class="blackfnt">Select Cheque Type</font>
                            </td>
                            <td colspan="3" align="left">
                                <asp:RadioButtonList ID="RPT" RepeatDirection="horizontal" OnClick="Javascript:return SelectRadio()" CssClass="blackfnt" runat="server">
                                    <asp:ListItem Text="Issued" Selected="true" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Received" Value="2"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr id="TR1" runat="server" align="center" bgcolor="white">
                            <td align="left">
                                <font class="blackfnt">Select Issuing Bank</font>
                            </td>
                            <td colspan="3" align="left">
                            <asp:TextBox ID="txtBank" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                    type="button" onclick="cust('B');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        
                        <tr id="TR2" runat="server" align="center" bgcolor="white">
                            <td align="left">
                                <font class="blackfnt">Select Cheque Deposit Status</font>
                            </td>
                            <td colspan="3" align="left">
                            <asp:DropDownList ID="DLLCHQDEPST" runat="server" CssClass="blackfnt">
                             <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="Deposited" Value="Y"></asp:ListItem>
                                    <asp:ListItem Text="Not-Deposited" Value="N"></asp:ListItem>
                                    <asp:ListItem Text="Bounced" Value="B"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="TR3" runat="server" align="center" bgcolor="white">
                            <td align="left">
                                <font class="blackfnt">Select On Account Status</font>
                            </td>
                            <td colspan="3" align="left">
                            <asp:DropDownList ID="DLLAccSt" runat="server" CssClass="blackfnt">
                             <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="Fully Accounted" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Not-Fully Accounted" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                       <tr  align="center" bgcolor="white">
                            <td align="left">
                                <font class="blackfnt">Select Reconciliation Status</font>
                            </td>
                            <td colspan="3" align="left">
                             <asp:DropDownList ID="CLLBamcReco" runat="server" CssClass="blackfnt">
                             <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="Reconciled" Value="N"></asp:ListItem>
                                    <asp:ListItem Text="Not-Reconciled" Value="Y"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td align="left">
                                <font class="blackfnt">Search By Cheque Amount Range</font>
                            </td>
                            <td colspan="3" align="left">
                             <asp:textbox runat="server" text="0" onkeypress="javascript:return validInt(event)"
                id="chqamtfrm" width="100" maxlength="10"> </asp:textbox> -  <asp:textbox runat="server" text="0" onkeypress="javascript:return validInt(event)"
                id="chqamtto" width="100" maxlength="10"> </asp:textbox>
                            </td>
                        </tr>
                         <tr align="center" bgcolor="white">
                            <td colspan="4" align="center">
                                <font class="blackboldfnt">OR</font>
                            </td>
                           
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td align="left">
                                <font class="blackfnt">Search By Cheque No.</font>
                            </td>
                            <td colspan="3" align="left">
                             <asp:textbox runat="server" text="" id="txtChqno" width="250"> </asp:textbox>
            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:RadioButtonList ID="rptmd" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Text="HTML Format" Selected="true" Value="N"></asp:ListItem>
                                    <asp:ListItem Text="XLS Download" Value="Y"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:Button ID="btnShow" OnClientClick="Javascript:return OnSub_DATACHECK();" OnClick="btnShow_Click"
                                    runat="server" Text="Show" Width="75px" />
                                <%--OnClientClick="Javascript: return DateCheck();"--%>
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
