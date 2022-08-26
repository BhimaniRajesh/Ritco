<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="MoneyRecieptBills_Step1.aspx.cs" Inherits="GUI_Finance_MoneyRecpt_MoneyRecieptBills_Step1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">


                               <%--THIS TWO FILES ARE FOR CALENDAR CONTROL--%>
<script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>
<script language="JavaScript" type="text/javascript">
	var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
</script>
                      <%--THIS FILE IS USED FOR DATEVALIDATION FUNCTION--%>
<script language="javascript" type="text/javascript" src="../../../Octroi/ViewnPrint/JS/ViewPrint.js"></script>

<script language="javascript" type="text/javascript">


function validateData()
{
    var str="ctl00_MyCPH1_";

    var txtpartycode=document.getElementById(str + "txtpartycode");
    var cmbbilltype=document.getElementById(str + "cmbbilltype");
    var cmbbillstatus=document.getElementById(str + "cmbbillstatus");
    var date1=document.getElementById(str + "txtDateFrom");
    var date2=document.getElementById(str + "txtDateTo");
    var optdates=document.getElementById(str + "optdate");
    
        if(optdates.checked==true)  
        {
            if(!isValidDate(date1.value,"From"))
                return false;
            if(!isValidDate(date2.value,"To"))
                return false;
        }
}



</script>

    
    <div align="center">

    <table style="width: 100%">
        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="View & Print SPECIFIC Bills" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
    </table>
    <br />

                                  <%--Back Link To First Page in Viewing Octroy Bills--%>
    
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="right" style="height: 33px">
                <a href="javascript:window.history.go(-1)" title="back">
                <img alt="" border="0" src="../../../images/back.gif" /></a>
            </td>
        </tr>
    </table>
    <br />
    
    
                                            <%-- Main Table --%>

    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
          <tr class="bgbluegrey">
              <td align="center" colspan="3">
                   <font class="blackfnt">View & Print SPECIFIC Bills</font>
              </td>
          </tr>
          
                                
           <tr bgcolor="#ffffff">
               <td align="left" class="blackfnt" valign="top">
                    <asp:RadioButton ID="optdate" Checked="true" GroupName="grpopt" runat="server" />Select Bill Date
               </td>
               <td colspan="2">
                    <table cellpadding="0" cellspacing="0" class="boxbg" border="0"> 
                        <tr style="background-color: white">
                            <td align="left" valign="top" class="blackfnt">
                              <asp:UpdatePanel ID="UpdatePanel1" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
                                    <ContentTemplate>
                                        <asp:RadioButtonList ID="radDate" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                            OnSelectedIndexChanged="radDate_OnSelectedIndexChange" ValidationGroup="VGDtFromTo"
                                            Width="210px">
                                            <asp:ListItem Selected="True" Text=" Date Range [dd/mm/yyyy]" Value="0"></asp:ListItem>
                                            <asp:ListItem Text=" Last Week (Including Today)" Value="1"></asp:ListItem>
                                            <asp:ListItem Text=" Today:" Value="2"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </ContentTemplate>
                              </asp:UpdatePanel>
                            </td>
                        <td align="left" valign="top" class="blackfnt">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:Label ID="lblFrom" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                        <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"  name="anchor1" id="a1" ><img src="../../../images/calendar.jpg" alt="calendar.jpg" border="0"> 
                                            
                                        </a> (dd/mm/yyyy)
                                   
                                    <asp:Label ID="lblTo" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                        <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor11','dd/MM/yyyy'); return false;"  name="anchor11" id="anchor11" ><img src="../../../images/calendar.jpg" alt="calendar.jpg" border="0"></a>(dd/mm/yyyy)
                                    <br />
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                      </tr>
                  </table>
                </td>
           </tr>

          <tr bgcolor="#ffffff">
              <td valign="top" align="left" class="blackfnt" ></td>
              <td class="blackfnt" align="left" colspan="2">Select Mr Type : 
                    <asp:DropDownList runat="server" ID="cmbmrtype">
                        <asp:ListItem>All</asp:ListItem>
                        <asp:ListItem>Bill MR</asp:ListItem>
                        <asp:ListItem>To Pay</asp:ListItem>
                        <asp:ListItem>Paid</asp:ListItem>
                    </asp:DropDownList>
              </td>
           
          </tr>
          <tr bgcolor="#ffffff">
              <td align ="left" class="blackfnt" valign="top">
                   <asp:RadioButton ID="optmrno" GroupName="grpopt" runat="server" />
                   Enter MR No
              </td>
              <td  align="left" colspan="2">
                  <asp:TextBox ID="txtmrno" runat="server" CssClass="blackfnt" Width="60px"></asp:TextBox>
               </td>
          </tr>
           
          <tr bgcolor="#ffffff">
              <td align ="left" class="blackfnt" valign="top">
                   <asp:RadioButton ID="optdocno" GroupName="grpopt" runat="server" />
                   Enter Docket No
              </td>
              <td  align="left" colspan="2">
                  <asp:TextBox ID="txtdocno" runat="server" CssClass="blackfnt" Width="60px"></asp:TextBox>
                  <asp:TextBox ID="txtdocsf" runat="server" CssClass="blackfnt" Text="." Enabled="false" Width="20px"></asp:TextBox>
               </td>
           </tr>
         
           <tr bgcolor="#ffffff">
              <td align="center" colspan="3">
                    <asp:Button  runat="server" ID="btnsubmit" Text="Submit" OnClick="btnsubmit_Click"/>
              </td>
           </tr>
       </table>
                                  
            </div>
            
             <div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
</asp:Content>
