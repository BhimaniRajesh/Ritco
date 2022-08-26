<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Tripsheet_Outstanding_Register.aspx.cs" Inherits="Tripsheet_Outstanding_Register" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>


<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="CMPFT" TagPrefix="Company" Src="~/GUI/Common_UserControls/CompayFilter.ascx" %>

  <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
<script src="../../images/commonJs.js"  language="javascript" type="text/javascript"></script>
<script src="../../images/DateControl.js"  language="javascript" type="text/javascript"></script>

<script src="../../images/CalendarPopup.js"  language="javascript" type="text/javascript"></script>
  <script language="javascript">
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
         var txtDateFrom=document.getElementById("ctl00$MyCPH1$DT$txtDateFrom");
         var txtDateTo=document.getElementById("ctl00$MyCPH1$DT$txtDateTo");
         var ddlcustname=document.getElementById("ctl00_MyCPH1_ddlcustname");
         var txtfromcity=document.getElementById("ctl00_MyCPH1_txtfromcity");
         var txttocity=document.getElementById("ctl00_MyCPH1_txttocity");
         var ddlCompanyList=document.getElementById("ctl00$MyCPH1$CMPFT1$ddlCompanyList");
        //window.open("Tripsheet_Outstanding_Report.aspx","");
         window.open("Tripsheet_Outstanding_Report.aspx?start_dt="+txtDateFrom.value+"&End_dt="+txtDateTo.value+"&Custnm="+ddlcustname.value+"&From_City="+txtfromcity.value+"&To_City="+txttocity.value+"&Company_Code="+ddlCompanyList.value +"");
        return false;
    }
         
         </script>
         <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>

        <asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Tripsheet Out Standing Bill Register</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>
    
 <table cellspacing="1" style="width: 800px">
        <tr>
            <td>
            <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                <ContentTemplate>
                  <table cellspacing="1" style="width: 100%" class="boxbg">
                    
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td align="left" colspan="3" style="color: red;">
                            Note : Please Note that This Report Will be Work on or after 20th November 2009
                            onwards (THC wise collection)</td>
                    </tr>
                    <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                        <td   align="left" colspan="1" style="width: 250px"  >
                            <asp:Label ID="Label18"  Font-Bold="True" CssClass="blackfnt" Text="Select Company" runat="server"></asp:Label>
                        </td>
                        <td align="left" valign="top"  colspan="2" >
                           <Company:CMPFT ID="CMPFT1" runat="server" />
                       </td>
                    </tr> 
                  <tr style="background-color: white"> 
                        <td align="left"  valign="center" width="250PX" >
                            <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">License Expiry Date</asp:Label></td>
                        <td align="left" colspan="2" width="77%" >
                            <Date:DT ID="DT" EnableTillDate="true" runat="server" />
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; width: 25%; text-align: left">
                            <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="True">Customer Name :</asp:Label></td>
                        <td align="left" style="width: 123%;" colspan="2">
                            <asp:DropDownList ID="ddlcustname" runat="server">
                            </asp:DropDownList>
                         </td>
                    </tr>
                   
                    <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; width: 25%; text-align: left">
                            <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="True" Width="104px">From City:</asp:Label></td>
                        <td align="left" style="width: 123%;" colspan="2">
                            <asp:TextBox ID="txtfromcity" runat="server"  CssClass="input">
                            </asp:TextBox></td>
                        
            
              
                    </tr>
                    <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; width: 25%; text-align: left; height: 26px;">
                            <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Font-Bold="True" Width="85px">To City</asp:Label></td>
                        <td align="left" style="width: 123%; height: 26px;" colspan="2">
                            <asp:TextBox ID="txttocity" runat="server"  CssClass="input"></asp:TextBox></td>
                       
                       
                    </tr>

   <tr style="background-color: white">
                        <td colspan="4" align="right" style="width: 100%">
                           <asp:UpdatePanel ID="UPShowCustomer" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                 <asp:Button ID="btnShow" runat="server" Text="Submit" ValidationGroup="VGDtFromTo"  OnClientClick="Javascript: return OnSub_DATACHECK();" />
                                   <%-- <asp:UpdateProgress runat="server" ID="Prog1">
                                        
                                        <ProgressTemplate>
                                        
                                            <asp:Image ID="imgWait" ImageUrl="~/GUI/images/indicator.gif" runat="server" BorderStyle="none" />
                                            <%--                                            <asp:Label ID="lblProgress" CssClass="blackfnt" Text="Wait.." runat="server" ForeColor="Red"></asp:Label>

                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                      --%>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        
            </td>
        </tr>
       
    </table>
    <br>
  
    
 
 </asp:Content>
