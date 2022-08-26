<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master" CodeFile="VendorBillRegister.aspx.cs" Inherits="admin_TireSearch" %>
<%@ Register TagName="popUp" TagPrefix="popUp" Src="~/GUI/Common_UserControls/PopUpControl.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="CMPFT" TagPrefix="Company" Src="~/GUI/Common_UserControls/CompayFilter.ascx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MyCPH1" runat="Server">

<script src="../../images/commonJs.js"  language="javascript" type="text/javascript"></script>

<script src="../../images/CalendarPopup.js"  language="javascript" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
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
       var ddlStatus=document.getElementById("ctl00_MyCPH1_ddlStatus");
       var ddlVendorType=document.getElementById("ctl00_MyCPH1_ddlVendorType");
       var ddlVendorName=document.getElementById("ctl00_MyCPH1_ddlVendorName");
       var ddlCompanyList=document.getElementById("ctl00$MyCPH1$CMPFT1$ddlCompanyList");
       var hdnRptId = document.getElementById("ctl00_MyCPH1_hdnRptId"); // added by Manisha 21/5/2014

       window.open("VendorBillRegisterResult.aspx?CreatedFrom=" + txtDateFrom.value + "&CreatedTo=" + txtDateTo.value + "&Status=" + ddlStatus.value + "&VendorType=" + ddlVendorType.value + "&VendorName=" + ddlVendorName.value + "&Company_Code=" + ddlCompanyList.value + "&hdnRptId=" + hdnRptId.value + "");


    }
    </script>
    
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
       <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 21/5/2014 --%>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Vendor Bill Register</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>
 <table cellspacing="1" style="width: 800px">
        <tr align="left">
            <td>
                <table cellspacing="1" class="boxbg">
                    
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                    </tr>
                     <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                            <td   align="left" colspan="1" style="width: 250px"  >
                                <asp:Label ID="Label18"  Font-Bold="True" CssClass="blackfnt" Text="Select Company" runat="server"></asp:Label></td>
                            <td align="left" valign="top"  colspan="2" >
                             
                                 <Company:CMPFT ID="CMPFT1" runat="server" />
                              
                            </td>
                        </tr> 
                    <tr style="background-color: white">
                        <td align="right" valign="center" style="text-align: left; width: 69px;">
                        <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True" Width="171px">Vendor Bill Entry Date Range:</asp:Label></td>
                        <td align="left" colspan="1">
                        <Date:DT ID="DT" EnableTillDate="false" runat="server" />
                        </td>
                    </tr>
                    
                    <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; height: 18px; text-align: left; width: 69px;">
                            <asp:Label ID="Label1" runat="server" Width="200px"  CssClass="blackfnt" Font-Bold="True">Select Status:</asp:Label></td>
                        <td align="left" style="height: 18px">
                            <asp:DropDownList ID="ddlStatus" runat="server">
                            </asp:DropDownList></td>
                        
                    </tr>
                    <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; height: 13px; text-align: left; width: 69px;">
                            <asp:Label ID="Label2"  Width="250px"   runat="server" CssClass="blackfnt" Font-Bold="True">Select Vendor Type:</asp:Label></td>
                        <td align="left" style="height: 18px">
                            <asp:DropDownList ID="ddlVendorType" runat="server" Width="183px">
                            </asp:DropDownList></td>
                        
                    </tr>
                    
                    <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; height: 13px; text-align: left; width: 69px;">
                            <asp:Label ID="Label3" Width="250px"   runat="server" CssClass="blackfnt" Font-Bold="True">Select Vendor Name:</asp:Label></td>
                        <td align="left" style="height: 18px">
                            <asp:DropDownList ID="ddlVendorName" runat="server" Width="184px">
                            </asp:DropDownList></td>
                        
                    </tr>
                    
                   


                    <tr style="background-color: white">
                        <td colspan="3" align="right" style="width: 100%">
                            <asp:UpdatePanel ID="UPShowTyre" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnShow" runat="server" Text="Show Vendors >>" ValidationGroup="VGDtFromTo" 
                                        OnClientClick="Javascript: return OnSub_DATACHECK();"  />
                                    <asp:UpdateProgress runat="server" ID="Prog1">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgWait" ImageUrl="~/GUI/images/indicator.gif" runat="server" BorderStyle="none" />
                                            <%--                                            <asp:Label ID="lblProgress" CssClass="blackfnt" Text="Wait.." runat="server" ForeColor="Red"></asp:Label>
--%>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                      
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
       
    </table>
   <br />
   <p align="center">
   </p>
 
 
 </asp:Content>
