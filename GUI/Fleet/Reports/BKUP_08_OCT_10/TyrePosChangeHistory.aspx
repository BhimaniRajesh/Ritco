<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"     CodeFile="TyrePosChangeHistory.aspx.cs" Inherits="TyrePosChangeHistory" %>


<%@ Register Assembly="AtlasControlToolkit" Namespace="AtlasControlToolkit" TagPrefix="cc1" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="CMPFT" TagPrefix="Company" Src="~/GUI/Common_UserControls/CompayFilter.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script src="../../images/commonJs.js"  language="javascript" type="text/javascript"></script>

<script src="../../images/CalendarPopup.js"  language="javascript" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
    
<script language="javascript">
    function createXMLHttpRequest()
    {
        // Mozilla, Safari,...
	    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	    // IE
	    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
    }
    function GetTyreDetails(txtTyreNo,txtManufacturer,txtModel,txtTyreSize,txtTyrePattern,txtType,hfTyreId)
    {
        if(txtTyreNo.value=="")
        {
            txtManufacturer.value="";
            txtModel.value="";
            txtTyreSize.value="";
            txtTyrePattern.value="";
            txtType.value="";
            hfTyreId.value="";
            return true;
        }
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N")
                    {
                        txtManufacturer.value="";
                        txtModel.value="";
                        txtTyreSize.value="";
                        txtTyrePattern.value="";
                        txtType.value="";
                        hfTyreId.value="";
                        alert("Invalid Tyre Number!!!");
                    }
                    else
                    {
                        txtManufacturer.value=returnValue[1];
                        txtModel.value=returnValue[2];
                        txtTyreSize.value=returnValue[3];
                        txtTyrePattern.value=returnValue[4];
                        txtType.value=returnValue[5];
                        hfTyreId.value=returnValue[6];
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=GetTyreDetRepoTyrePosChangeHis&datetime="+currentTime+"&TyreNo=" + txtTyreNo.value+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }	
    }  
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
       var txtTyreNo=document.getElementById("ctl00_MyCPH1_hfTyreId");
//       var txtManufacturer=document.getElementById("ctl00_MyCPH1_txtManufacturer");
//       var txtModel=document.getElementById("ctl00_MyCPH1_txtModel");
//       var txtTyreSize=document.getElementById("ctl00_MyCPH1_txtTyreSize");
//       var txtTyrePattern=document.getElementById("ctl00_MyCPH1_txtTyrePattern");
//       var txtType=document.getElementById("ctl00_MyCPH1_txtType");
       var ddlCompanyList=document.getElementById("ctl00$MyCPH1$CMPFT1$ddlCompanyList");
   
     window.open("TyrePosChangeHistoryReport.aspx?TyreNo=" + txtTyreNo.value + "&PosHisDateFrom=" + txtDateFrom.value + "&PosHisDateTo=" + txtDateTo.value + "&Company_Code=" + ddlCompanyList.value + "");

    }
        
</script>
    
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
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports > Tyre Position Change History</asp:Label>
            </td> 
            
             <td align="right">

          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
      <br> 
      <table cellspacing="1" style="width: 700px">
            <tr >
                <td style="height: 290px">  
       <table cellspacing="1" cellpadding="2" style="width: 100%" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="3" align="center">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
                         <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                        <td   align="left" colspan="1" style="width: 154px"  >
                            <asp:Label ID="Label18"  Font-Bold="True" CssClass="blackfnt" Text="Select Company Type" runat="server"></asp:Label>
                        </td>
                        <td align="left" valign="top"  colspan="2" >
                           <Company:CMPFT ID="CMPFT1" runat="server" />
                       </td>
                    </tr> 
                <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
                   <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Font-Bold="True">Enter Tyre No.:</asp:Label></td>
               <td align="left" colspan="2">
                   <asp:TextBox ID="txtTyreNo" runat="server" AutoCompleteType="Office" CssClass="input"
                       Width="103px"></asp:TextBox><asp:Button ID="btnPopupTyre" runat="server" Text="..." />
                   <asp:HiddenField ID="hfTyreId" runat="server" />
                   <%--<ajaxToolkit:Accordion  :AutoCompleteExtender
                           ID="au" runat="server">
                           <atlas:AutoCompleteProperties Enabled="true" MinimumPrefixLength="1" ServiceMethod="GetTyreNumber"
                               ServicePath="../../../GUI/services/TyreWebService.asmx" TargetControlID="txtTyreNo" />
                       </atlas:AutoCompleteExtender>--%>
               </td>
           </tr>
           
                   <tr style="background-color: white">
                        <td align="right" valign="center" style="width: 154px; text-align: left; height: 112px;">
                        <asp:Label ID="Label4" CssClass="blackfnt" runat="server" Font-Bold="True">Bill Date</asp:Label></td>
                        <td align="left" colspan="1" style="height: 112px">
                        <Date:DT ID="DT" EnableTillDate="false" runat="server" />
                        </td>
                    </tr>
           
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
                   <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="True">Tyre Manufacturer:</asp:Label></td>
               <td align="left" colspan="2">
                   <asp:TextBox ID="txtManufacturer" runat="server" CssClass="input"></asp:TextBox></td>
           </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
                   <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="True">Model:</asp:Label></td>
               <td align="left" colspan="2">
                   <asp:TextBox ID="txtModel" runat="server" CssClass="input"></asp:TextBox></td>
           </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
                   <asp:Label ID="Label6" runat="server" CssClass="blackfnt" Font-Bold="True">Size:</asp:Label></td>
               <td align="left" colspan="2">
                   <asp:TextBox ID="txtTyreSize" runat="server" CssClass="input"></asp:TextBox></td>
           </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
                   <asp:Label ID="Label9" runat="server" CssClass="blackfnt" Font-Bold="True">Pattern:</asp:Label></td>
               <td align="left" colspan="2">
                   <asp:TextBox ID="txtTyrePattern" runat="server" CssClass="input"></asp:TextBox></td>
           </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
                   <asp:Label ID="Label10" runat="server" CssClass="blackfnt" Font-Bold="True">Type:</asp:Label></td>
               <td align="left" colspan="2">
                   <asp:TextBox ID="txtType" runat="server" CssClass="input"></asp:TextBox></td>
           </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
               </td>
               <td align="left" colspan="2">
               </td>
           </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
               </td>
               <td align="left" colspan="2" style="text-align: right">
                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="btnShow" runat="server" Text="Submit"   OnClientClick="Javascript: return OnSub_DATACHECK();" /> 
                    </ContentTemplate>
                </asp:UpdatePanel>
               </td>
           </tr>

                       </table>
                    
                   </td>
            </tr>
        </table>
      <br/>
       
     
</asp:Content> 