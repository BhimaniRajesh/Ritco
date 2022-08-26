<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_Profit_Loss_Ver1_Query" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="JavaScript" SRC="../../../Images/CalendarPopup.js"></script> 
<script language="javascript" src="../../../images/commonJs.js"></script>
<script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
</script>


            <script language="javascript" type="text/javascript">
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
 <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                            class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>Profit & Loss</strong> </font>
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
                <td valign="top">
            
            <table cellspacing="1" style="width: 9.5in; height: 263px;" border="0">
                <tr align="center">
                    <td style="height: 324px" align="center" colspan="3">
                        <table cellspacing="1" style="width: 7.0in" class="boxbg" border="0"> 
                            <tr class="bgbluegrey">
                                <td colspan="4" align="center" style="height: 21px">
                                    <asp:Label ID="lblQry" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                        Select Branch / Profit Center 

                                    </asp:Label>
                                </td>
                            </tr>
                            
                            <tr  style="font-size: 12pt; font-family: Times New Roman;background-color: white">
                                <td  colspan="2" align="center" style="height: 21px">
                                    <asp:Label ID="Label4" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                        Select Branch / Profit Center :

                                    </asp:Label>
                                </td>
                                
                                <td nowrap align="left" colspan="2" style="width: 395px"><asp:UpdatePanel ID="up3" runat="server">
                                                            <ContentTemplate>
                             
                                     <asp:DropDownList ID="ddlro" runat="server" AutoPostBack="True"  >
                                       <%-- <asp:ListItem Text="---All--" Value=""></asp:ListItem>--%>
                                     </asp:DropDownList>
                                   
                    </ContentTemplate>
                   <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="radFlow" EventName="SelectedIndexChanged" />
                    </Triggers>
                    
                    </asp:UpdatePanel></td>
                            </tr>
                      
                            
                          <tr id="RoWtr" runat="server"    style="font-size: 12pt; font-family: Times New Roman;background-color: white">
                                <td align="center"  colspan="4" valign="top"> <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                            <ContentTemplate>
                                    <asp:RadioButtonList ID="radFlow" runat="server"  CssClass="blackfnt"   AutoPostBack="true" OnSelectedIndexChanged="rdiochanges"    RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True" Text="Individual" Value="0"  ></asp:ListItem>
                                        <asp:ListItem  Text="Cumulative (Branch Wise)" Value="1"></asp:ListItem>
                                           <asp:ListItem  Text="Cumulative (Total)" Value="2"></asp:ListItem>
                                    </asp:RadioButtonList>
                                     </ContentTemplate>
                                <Triggers>
                                    
                                                                     
                                </Triggers>
                            </asp:UpdatePanel></td>
                                    
                            </tr>
                          
                             <tr class="bgbluegrey">
                                <td colspan="4" align="center" style="height: 21px">
                                    <asp:Label ID="Label6" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                       Select Voucher Date Range 


                                    </asp:Label>
                                </td>
                            </tr>
                            
                            
                            
                    
                             
                             <tr style="background-color: white">
                        <td align="center">
                            <font class="blackfnt">Select Voucher Date </font>
                        </td>
                        <td align="left" colspan="3">
                            <Date:DT ID="DT" runat="server" />
                        </td>
                    </tr>
                            <tr style="background-color: white"><td> <asp:Label ID="Label1" CssClass="blackfnt" 
                                        Font-Bold="false" runat="server">
                                      Groupwise  
                                    </asp:Label></td> <td align="left" colspan="3" ><asp:CheckBox ID="grpchk" runat="server" /></td></tr>
                            
                            
                            <%--<asp:RadioButton ID="RadLocWise" runat="server" GroupName="RadGroup" Text="Location Wise" OnCheckedChanged="RadLocWise_CheckedChanged" AutoPostBack="True" />
                                    <asp:RadioButton ID="RadCustWise" runat="server" GroupName="RadGroup" Text="Customer Wise" OnCheckedChanged="RadCustWise_CheckedChanged" AutoPostBack="True" />--%>
<%-- <tr class="bgbluegrey">
                                <td colspan="4" align="center" style="height: 21px">
                                    <asp:Label ID="Label2" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                       Select Accounts


                                    </asp:Label>
                                </td>
                            </tr>--%>
                            
                
                   <%-- <tr style="background-color: white">
                                
                                
                                
                                <td align="center" colspan="4"  valign="top" style="height: 25px; width: 395px;">
                                   <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                            <ContentTemplate>
                                                             <asp:DropDownList ID="DDAccounts" runat="server" AutoPostBack="True"  >
                                        <asp:ListItem Text="All" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="All Bank Accounts" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="All Cash Accounts" Value="2"></asp:ListItem>
                                     </asp:DropDownList> </ContentTemplate>
                                     </asp:UpdatePanel><%--<asp:Button ID="btnBilledAt" runat="server" Text="..." onclick="BranchPopup(this)" PopupURL="../popup-branch.asp?7,A,A" />
                                </td>
                                
                            </tr>--%>
                
                
                <tr style="background-color: white">
                    <td colspan="4" align="center" style="height: 32px">
                        <asp:Button ID="btnShow3" runat="server" Text="Show" OnClientClick="Javascript:return OnSub_DATACHECK()" Width="75px" OnClick="btnShow_Click1"  />
                        
                    </td>
                </tr>
                
                     
                
                
                <%--<tr style="background-color: white">
                    <td colspan="4" align="center" style="height: 32px">
                        <asp:Button ID="btnShow" runat="server" Text="Show" Width="75px" OnClick="btnShow_Click1" />
                        
                         
                        
                        
                    </td>
                </tr>--%>
                 </table>
                  </td></tr></table></div>
                 <DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV>
</asp:Content>
