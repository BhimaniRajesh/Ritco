<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_Trip_Profitablility_Report_Query" %>
<%@ Register TagName="CMPFT" TagPrefix="Company" Src="~/GUI/Common_UserControls/CompayFilter.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

<%@ Register Src="~/GUI/Common_UserControls/RPT_Date.ascx" TagName="RPT_Date" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="JavaScript" type="text/javascript" src="../../../Images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>
    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
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
//            function OnSub_DATACHECK()
//        {
//   
//        
//       
//         var txtDateFrom=document.getElementById("ctl00$MyCPH1$DT$txtDateFrom");
//         var txtDateTo=document.getElementById("ctl00$MyCPH1$DT$txtDateTo");
//         var ddlProfStatus=document.getElementById("ctl00_MyCPH1_ddlProfStatus");
//         var txtMRFrom=document.getElementById("ctl00_MyCPH1_txtMRFrom");
//         var txtMRTo=document.getElementById("ctl00_MyCPH1_txtMRTo");
//         var ddlDocType=document.getElementById("ctl00_MyCPH1_ddlDocType");
//           var ddlCompanyList=document.getElementById("ctl00$MyCPH1$CMPFT1$ddlCompanyList");
//         var TempDocNo="";
//       
//        if (ddlDocType.value == "1")
//            {
//             TempDocNo=document.getElementById("ctl00_MyCPH1_txtDocNo");
//            }
//        else 
//            {
//             TempDocNo="";
//            }
//        
//        if (ddlDocType.value == "2")
//            {
//             TempDocNo=document.getElementById("ctl00_MyCPH1_txtDocNo");
//            }
//            else 
//            {
//             TempDocNo="";
//            }
////            window.open("Result.aspx","");
//      
//           
//           window.open("Result.aspx?FromDate="+txtDateFrom.value+"&ToDate="+txtDateTo.value+"&ProfStatus="+ddlProfStatus.value+"&MarginFrom="+txtMRFrom.value+"&MarginTo="+txtMRTo.value+"&TripSheetNo=&VehicleNo=&Company_Code="+ddlCompanyList.value +"");
//           
//            return false;
//        }
////        
function OnSub_DATACHECK1()
{    
        var txtDateFrom=document.getElementById("ctl00$MyCPH1$DT$txtDateFrom");
         var txtDateTo=document.getElementById("ctl00$MyCPH1$DT$txtDateTo");
        var ddlProfStatus=document.getElementById("ctl00_MyCPH1_ddlProfStatus");
        var txtMRFrom=document.getElementById("ctl00_MyCPH1_txtMRFrom");
        var txtMRTo=document.getElementById("ctl00_MyCPH1_txtMRTo");
        //var TripDocNo="";
        //var VehDocNo="";
        var ddlDocType=document.getElementById("ctl00_MyCPH1_ddlDocType");
        var txtDocNo=document.getElementById("ctl00_MyCPH1_txtDocNo");
         var ddlCompanyList=document.getElementById("ctl00$MyCPH1$CMPFT1$ddlCompanyList");
          ddlDocType

        if (ddlDocType.value =="TS" )
        {
            window.open("Result.aspx?FromDate="+txtDateFrom.value+"&ToDate="+txtDateTo.value+"&ProfStatus="+ddlProfStatus.value+"&MarginFrom="+txtMRFrom.value+"&MarginTo="+txtMRTo.value+"&TripSheetNo="+txtDocNo.value+"&VehicleNo=&Company_Code="+ddlCompanyList.value +"");
        }
        else  if (ddlDocType.value =="VEH" )
        {
            window.open("Result.aspx?FromDate="+txtDateFrom.value+"&ToDate="+txtDateTo.value+"&ProfStatus="+ddlProfStatus.value+"&MarginFrom="+txtMRFrom.value+"&MarginTo="+txtMRTo.value+"&TripSheetNo=&VehicleNo="+txtDocNo1.value+"&Company_Code="+ddlCompanyList.value +"");
        return false;
        }
  }

    </script>
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute;
                z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
            </iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                    Wait...</b></font></div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>Reports </strong></font><strong>&gt; </strong>
                <font class="blklnkund"><strong>Finance </strong></font><strong>&gt; </strong>
                <font class="bluefnt"><strong>Trip Profitability Report</strong></font>&nbsp;</td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr>
            <td>
                <img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>
        <tr>
            <td valign="top">
                <br />
                <br />
                <div align="left">
                    <table cellspacing="1" style="width: 7.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="5" align="center" style="height: 21px" style="width: 112px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Criteria </asp:Label>
                            </td>
                        </tr>
                           <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                        <td   align="left" colspan="0" style="width: 154px"  >
                            <asp:Label ID="Label8"  Font-Bold="True" CssClass="blackfnt" Text="Select Company" runat="server"></asp:Label>
                        </td>
                        <td align="left" valign="top"  colspan="4" >
                           <Company:CMPFT ID="CMPFT1" runat="server" />
                       </td>
                    </tr>                         
                         <tr style="background-color: white">
                        <td align="left" valign="center" style="width: 154px;">
                        <asp:Label ID="Label1" CssClass="blackfnt" runat="server" Font-Bold="True">Transaction Date Range :</asp:Label></td>
                        <td align="left" colspan="4">
                        <Date:DT ID="DT" EnableTillDate="false" runat="server" />
                        </td>
                    </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Profitability Status :"></asp:Label>                               
                            </td>
                            <td align="left" colspan="5">
                                <asp:DropDownList ID="ddlProfStatus" runat="server">
                                    <asp:ListItem Text="ALL" Value="0" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Profitable" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Loss Making" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Text="Margin Range :"></asp:Label>  
                            </td>
                            <td align="left" colspan="5">
                                <table border="0" cellpadding="2" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Text="From "></asp:Label>  
                                        </td>
                                        <td><%--onkeypress="Javascript:return validFlot(event,this.getAttribute('id')); "--%>
                                            <asp:TextBox ID="txtMRFrom" runat="server" Columns="3" ></asp:TextBox><label class="blackfnt">%</label>
                                        </td>
                                        <td style="width:10px;"></td>
                                        <td>
                                            <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Text="To " ></asp:Label>  
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtMRTo" runat="server" Columns="3" ></asp:TextBox><label class="blackfnt">%</label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                       <%-- <tr align="center" bgcolor="white">
                            <td colspan="2">
                                <asp:Button ID="btnShow"  runat="server" Text="Show" Width="75px" OnClientClick="Javascript: return OnSub_DATACHECK();"  />
                            </td>
                        </tr>--%>
                        <%--<tr class="blackfnt" bgcolor="white">
                            <td colspan="2" align="center"><b>OR</b></td>
                        </tr>--%>
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label6" runat="server" CssClass="blackfnt" Text="Select Document :"></asp:Label>                               
                            </td>
                            <td align="left" colspan="5">
                                <asp:DropDownList ID="ddlDocType" runat="server">                                    
                                    <asp:ListItem Text="Trip Sheet Number" Value="TS"></asp:ListItem>
                                    <asp:ListItem Text="Vehicle Number" Value="VEH"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" >
                                <asp:Label ID="Label7" runat="server" CssClass="blackfnt" Text="Select Document No. :"></asp:Label>                               
                            </td>
                            <td align="left" colspan="4">
                                <asp:TextBox ID="txtDocNo" runat="server" Width="200px"></asp:TextBox>&nbsp;<label class="blackfnt">[ Enter coma (,) separated if multiple]</label>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="5">
                                <asp:Button ID="btnShow2"  runat="server" Text="Show" Width="75px"  OnClientClick="Javascript: return OnSub_DATACHECK1();"  />
                            </td>
                        </tr>
                    </table>
                </div>               
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
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>

