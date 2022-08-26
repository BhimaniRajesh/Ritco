<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_StateWiseVehicleRegistration_Query" Title="Untitled Page" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="CMPFT" TagPrefix="Company" Src="~/GUI/Common_UserControls/CompayFilter.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script src="../../../images/commonJs.js"  language="javascript" type="text/javascript"></script>

<script language="javascript" type="text/javascript">  
  function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
    function OnSub_DATACHECK()
   {
  var txtVehicleNo=document.getElementById("ctl00_MyCPH1_txtVehicleNo");
     var ddlCompanyList=document.getElementById("ctl00$MyCPH1$CMPFT1$ddlCompanyList");
     var hdnRptId = document.getElementById("ctl00_MyCPH1_hdnRptId"); // added by Manisha 21/5/2014
     window.open("Result.aspx?state=" + txtVehicleNo.value + "&Company_Code=" + ddlCompanyList.value + "&hdnRptId=" + hdnRptId.value + "");
        return false;
   }
</script>

<asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>
   <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 21/5/2014 --%>

<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >State Wise Vehicle Registration</asp:Label>
            </td> 
            
             <td align="right">

          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
      <br> 
    
    <table cellspacing="1" cellpadding="2" style="width:700px" class="boxbg">
    
            <tr class="bgbluegrey">
                <td colspan="3" align="center">
                    <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                </td>
            </tr>
             <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label12" CssClass="blackfnt" Text="Select Company Type" runat="server"></asp:Label></td>
                            <td align="left" valign="top">
                             
                                 <Company:CMPFT ID="CMPFT1" runat="server" />
                               
                            </td>
                        </tr>
            <tr style="background-color: white">
                <td align="right" valign="center" style="width: 154px; text-align: left;">
                <asp:Label ID="Label5" CssClass="blackfnt" runat="server" Font-Bold="True">State</asp:Label>
                </td>
                <td align="left" colspan="2">
                <asp:TextBox ID="txtVehicleNo" runat="server" MaxLength="2"></asp:TextBox>&nbsp;
                <asp:Label ID="lblnote" runat="server" CssClass="redfnt" Text="Note : Enter State Like MH - Maharashtra, GJ - Gujarat"></asp:Label>
                <%--<input id="Vehno" runat="server"   type="button" value="..." onclick="javascript:nwOpen('Popup-Vehicle.aspx',null,'height=250,width=300,left=350,top=200,status=no,resizable=no,scrollbars=yes,toolbar=no,location=no,menubar=no');" />--%>
                <%--<asp:Label ID="lblPopup" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>'></asp:Label> --%>
                </td>
            </tr>
            
              <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
               </td>
               <td align="left" colspan="2" style="text-align: right">
                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                       <%-- <asp:Button ID="btnShow" runat="server" Text="Submit" OnClientClick="javascript:return Validation()"  OnClick="btnShow_Click" /> --%>
                        <asp:Button ID="btnShow" runat="server" Text="Submit"   OnClientClick="Javascript: return OnSub_DATACHECK();"/> 
                    </ContentTemplate>
                </asp:UpdatePanel>
               </td>
           </tr>

                       </table>
        
      <br/>



</asp:Content>




