<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="frmViewPrintVehicleIssueSlipQueryLegWise.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_frmViewPrintVehicleIssueSlipQueryLegWise" %>

<%@ Reference Control="~/LED/DateSelector.ascx" %>
<%@ Reference Control="~/LED/DateSelectorTo.ascx" %>
<%@Register TagPrefix="SControls" TagName="DateSelector" src="~/LED/DateSelector.ascx" %>
<%@Register TagPrefix="SControlsTo" TagName="DateSelectorTo" src="~/LED/DateSelectorTo.ascx" %> 

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script type="text/javascript" language="javascript" src="../../../../cal/popcalendar.js"></script>
<script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>
<script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

 <script language="javascript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
cal.setCssPrefix("TEST");
cal.showNavigationDropdowns();

    function nwOpen1(mNo)
    {
        window.open("../../../../GUI/popups/Popup-Vehicle.aspx?mNo=" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
    }
    function nwOpen3(mNo)
    {
        window.open("../../../../GUI/popups/Popup-Driver1.aspx?mNo=" + mNo + "&id=D1","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
    }
    function OnSub_DATACHECK()
    {
      var ddlTripsheet=document.getElementById("ctl00_MyCPH1_ddlTripsheet");
       var txtVIssueID=document.getElementById("ctl00_MyCPH1_txtVIssueID");
       var txtDateFrom=document.getElementById("ctl00$MyCPH1$DT$txtDateFrom");
       var txtDateTo=document.getElementById("ctl00$MyCPH1$DT$txtDateTo");
      var ddlro=document.getElementById("ctl00_MyCPH1_ddlro");
       var cboIssueSlipStatus=document.getElementById("ctl00_MyCPH1_cboIssueSlipStatus");
       var txtDriver1=document.getElementById("ctl00_MyCPH1_txtDriver1");
     var txtVehNo=document.getElementById("ctl00_MyCPH1_txtVehNo");
     window.open("frmViewPrintVehicleIssueSlipLegWiseResult.aspx?VSLIPID=" + txtVIssueID.value + "&VSLIPFROMDT=" + txtDateFrom.value + "&VSLIPTODT=" + txtDateTo.value + "&ISSUESTATUS=" + cboIssueSlipStatus.value + "&TRIPSHEETFLAG=" + ddlTripsheet.value + "&Branch=" + ddlro.value + "&Driver=" + txtDriver1.value + "&VehicleNo=" + txtVehNo.value + "");
     
    return false;
    }
    
     function OnSub_DATACHECKTRIP()
    {
      var ddlTripsheet=document.getElementById("ctl00_MyCPH1_ddlTripsheet");
       var txtVIssueID=document.getElementById("ctl00_MyCPH1_txtVIssueID");
       var txtDateFrom=document.getElementById("ctl00$MyCPH1$DT$txtDateFrom");
       var txtDateTo=document.getElementById("ctl00$MyCPH1$DT$txtDateTo");
      var ddlro=document.getElementById("ctl00_MyCPH1_ddlro");
       var cboIssueSlipStatus=document.getElementById("ctl00_MyCPH1_cboIssueSlipStatus");
       var txtDriver1=document.getElementById("ctl00_MyCPH1_txtDriver1");
     var txtVehNo=document.getElementById("ctl00_MyCPH1_txtVehNo");
     window.open("frmViewPrintVehicleIssueSlipLegWiseResult.aspx?VSLIPID=" + txtVIssueID.value + "&VSLIPFROMDT=" + '' + "&VSLIPTODT=" + '' + "&ISSUESTATUS=" + cboIssueSlipStatus.value + "&TRIPSHEETFLAG=" + ddlTripsheet.value + "&Branch=" + 'All' + "&Driver=" + txtDriver1.value + "&VehicleNo=" + txtVehNo.value + "");
     
    return false;
    }
    
</script>
      <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>

 <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                 <ProgressTemplate>
        <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
            -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
            <tr>
                <td align="right">
                    <img src="../../../../gui/images/loading.gif" alt="" />
                </td>
                <td>
                    <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                </td>
            </tr>
        </table>
        <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
            background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
            opacity: .50; -moz-opacity: .50;" runat="server">
            <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                left: 50%;" ID="Panel2" runat="server">
            </asp:Panel>
        </asp:Panel>
    </ProgressTemplate>
          </asp:UpdateProgress>  


    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">View/Print Trip Sheet >> Query</asp:Label>
             
            </td>
            
             <td align=right>
               
         
          </td>    
           
        </tr>
    </table>
<hr align="center" size="1" color="#8ba0e5">
 <br> 

  <table cellspacing="1" style="width: 100%">
            <tr align="left">
                <td>  
       <table cellspacing="1" cellpadding="2" style="width: 700px" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" style="width: 25%">
                             <%--   <asp:Label ID="Label4" CssClass="blackfnt" runat="server" Font-Bold="True">Enter Trip Sheet No.:</asp:Label>--%>
                        
                                  <asp:DropDownList ID="ddlTripsheet" runat="server">
                                        <asp:ListItem Value="M" Text="Enter Manual TripSheet No.:" Selected="true"></asp:ListItem>
                                        <asp:ListItem Value="T" Text="Enter Trip Sheet No.:"></asp:ListItem>
                                   </asp:DropDownList>
                        
                        
                            </td>
                            <td align="left" style="width: 75%">
                                <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline" UpdateMode="Always" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox CssClass="input" ID="txtVIssueID" runat="Server" ValidationGroup="VGRequestID" BorderStyle="Groove"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtVIssueID"
                                            ErrorMessage="*" ValidationGroup="VGRequestID" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                        
                        
                        <tr style="background-color: white">
                            <td colspan="2" align="right" style="width: 100%">
                                <asp:UpdatePanel ID="UpdatePanel5" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnShowSingleRequest" runat="server" Text="Submit" ValidationGroup="VGRequestID" OnClientClick="Javascript: return OnSub_DATACHECKTRIP();"   /> 
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="2">
                                <asp:Label ID="Label5" CssClass="blackfnt" runat="server" Font-Bold="true">
                                OR
                                </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left"  width="400px"  valign=top style="width: 20%; height: 89px;">
                                <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Trip Sheet Date Range:</asp:Label>
                            </td>
                            <td align="left"  width="200px" style="width: 40%; height: 89px;">
                                <Date:DT ID="DT" EnableTillDate="true" runat="server" />
                            </td>
                        </tr>
           <tr style="background-color: white">
               <td align="left" style="width: 20%">
                   <asp:Label ID="Label8" runat="server" CssClass="blackfnt" Font-Bold="true">
                                        Select Branch   

                                    </asp:Label></td>
               <td align="left" style="width: 80%">
               <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Always" RenderMode="Inline" runat="server">
                   <ContentTemplate>
                   <asp:DropDownList ID="ddlro" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlro_SelectedIndexChanged">
                   </asp:DropDownList>
                   </ContentTemplate>
               </asp:UpdatePanel>
               </td>
           </tr>
                    
                    <tr style="background-color: white">
                            <td align="left" style="width: 20%; height: 26px;">
                                <asp:Label ID="Label1" CssClass="blackfnt" runat="server" Font-Bold="True">Select Trip Sheet Status:</asp:Label>
                            </td>
                            <td align="left" style="width: 80%; height: 26px;">
                               <asp:DropDownList ID="cboIssueSlipStatus" runat=server>
                                <asp:ListItem Value="B" Text="Both"></asp:ListItem>
                                <asp:ListItem Value="P" Text="Pending"></asp:ListItem>
                                <asp:ListItem Value="C" Text="Completed"></asp:ListItem>
                               </asp:DropDownList>
                          </td>
                        </tr>                        
           <tr style="background-color: white">
               <td align="left" style="width: 20%">
                   <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Driverwise"></asp:Label></td>
               <td align="left" style="width: 80%">
                   <asp:TextBox ID="txtDriver1" runat="server"  CssClass="input" ></asp:TextBox>
                   <asp:Label ID="Label9" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen3(1)">...</a>'
                       Width="14px"></asp:Label></td>
           </tr>
           <tr style="background-color: white">
               <td align="left" style="width: 20%">
                   <asp:Label ID="lblVehWise" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Vehiclewise"></asp:Label></td>
               <td align="left"  style="width: 80%">
                   <asp:TextBox ID="txtVehNo" runat="server" CssClass="input"></asp:TextBox><asp:Label
                       ID="Label10" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen1(1)">...</a>'
                       Width="14px"></asp:Label></td>
           </tr>
     
                        <tr style="background-color: white">
                            <td colspan="2" align="right">
                                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnShowMultipleRequest" runat="server" Text="Submit"  
                                            ValidationGroup="VGDtFromTo" 
                                            OnClientClick="Javascript: return OnSub_DATACHECK();"  /> 
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                    </table>
                          </td>
            </tr>
        </table>      
       
       

<br />
 
</asp:Content> 
