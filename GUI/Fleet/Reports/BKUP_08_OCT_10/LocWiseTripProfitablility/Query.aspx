<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_Trip_Profitablility_Report_Query" %>

<%@ Register Src="../../../Common_UserControls/LocationHirarchy.ascx" TagName="LocationHirarchy"
    TagPrefix="uc2" %>
<%@ Register Src="~/GUI/Common_UserControls/RPT_Date.ascx" TagName="RPT_Date" TagPrefix="uc1" %>
<%@ Register TagName="CMPFT" TagPrefix="Company" Src="~/GUI/Common_UserControls/CompayFilter.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript" src="../../../Images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
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
	    function onOk()
        {
            var checkBoxList = document.getElementById("<%=chklstLocation.ClientID %>");
            if(checkBoxList !=null)
            {
                var options = checkBoxList.getElementsByTagName('input');
                var arrayOfCheckBoxLabels= checkBoxList.getElementsByTagName("label");
                document.getElementById("<%=txtLocs.ClientID %>").value="";
                for(i=0;i<options.length;i++)
                {
                    var opt = options[i];
                    if(opt.checked)
                    {
                        document.getElementById("<%=txtLocs.ClientID %>").value = document.getElementById("<%=txtLocs.ClientID %>").value+arrayOfCheckBoxLabels[i].innerText+",";
                    }
                } 
                var str=document.getElementById("<%=txtLocs.ClientID %>").value;
                var len=str.length;
                str=str.substring(0,len-1);
                document.getElementById("<%=txtLocs.ClientID %>").value = str;
            }
            return;
        }
        function onCancel()
        {
            document.getElementById("<%=txtLocs.ClientID %>").value="";
            var checkBoxList = document.getElementById("<%=chklstLocation.ClientID %>");
            if(checkBoxList !=null)
            {
                var options = checkBoxList.getElementsByTagName('input');
                var arrayOfCheckBoxLabels= checkBoxList.getElementsByTagName("label");
                for(i=0;i<options.length;i++)
                {
                    var opt = options[i];
                    opt.checked = false;
                } 
            }
            return;
        }
        function OnSub_DATACHECK()
        {
   
      
        var ddlDocType=document.getElementById("ctl00_MyCPH1_ddlDocType");
         var txtDateFrom=document.getElementById("ctl00_MyCPH1_dtFromTo_txtDateFrom");
         var txtDateTo=document.getElementById("ctl00_MyCPH1_dtFromTo_txtDateTo");
         var ddlProfStatus=document.getElementById("ctl00_MyCPH1_ddlProfStatus");
         var txtMRFrom=document.getElementById("ctl00_MyCPH1_txtMRFrom");
         var txtMRTo=document.getElementById("ctl00_MyCPH1_txtMRTo");
         var TempDocNo="";
      
        if (ddlDocType.value == "1")
            {  
             TempDocNo=document.getElementById("ctl00_MyCPH1_txtDocNo").value;
            }
        else 
            {
             TempDocNo="";
            }
     
        if (ddlDocType.value == "2")
            {
             TempDocNo=document.getElementById("ctl00_MyCPH1_txtDocNo").value;
            }
            else 
            {
             TempDocNo="";
            }
          var RO="ALL";
           var LO="ALL";
           var txtLocs = document.getElementById("ctl00_MyCPH1_txtLocs");
           var ddlCompanyList=document.getElementById("ctl00$MyCPH1$CMPFT1$ddlCompanyList");
           //alert ("Result.aspx?FDT="+txtDateFrom.value+"&TDT="+txtDateTo.value+"&TDT="+txtDateTo.value+"&PSTS="+ddlProfStatus.value+"&MRF="+txtMRFrom.value+"&MRT="+txtMRTo.value+"&TSNo="+ TempDocNo.value +"&RO="+RO.value+"&LO="+LO.value+"&LO_List="+txtLocs.value+"")
           window.open("Result.aspx?FDT="+txtDateFrom.value+"&TDT="+txtDateTo.value+"&TDT="+txtDateTo.value+"&PSTS="+ddlProfStatus.value+"&MRF="+txtMRFrom.value+"&MRT="+txtMRTo.value+"TSNo=&VHNo=&RO="+RO.value+"&LO="+LO.value+"&LO_List="+txtLocs.value+"&Company_Code=" + ddlCompanyList.value + "");
           
            return false;
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
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Reports </strong></font><strong>&gt; </strong><font class="blklnkund">
                        <strong>Finance </strong></font><strong>&gt; </strong><font class="bluefnt"><strong>
                            Location Wise Trip Profitability Report</strong></font>&nbsp;</td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr>
            <td>
                <img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
        <tr>
            <td valign="top">
                <br />
                <br />
                <div align="left">
                    <table cellspacing="1" style="width: 9.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Criteria </asp:Label>
                            </td>
                        </tr>
                          <tr id="Tr6" visible="true" runat="server" style="background-color: white">
                        <td   align="left" colspan="1" style="width: 250px"  >
                            <asp:Label ID="Label9"  Font-Bold="True" CssClass="blackfnt" Text="Select Company Type" runat="server"></asp:Label>
                        </td>
                        <td align="left" valign="top"  colspan="2" >
                           <Company:CMPFT ID="CMPFT1" runat="server" />
                       </td>
                    </tr> 
                        <tr id="Tr1" style="background-color: white;" runat="server" visible="false">
                            <td align="left" valign="top" colspan="2">
                                <uc2:LocationHirarchy ID="lhLoc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" valign="top">
                                <asp:Label ID="Label8" runat="server" CssClass="blackfnt" Text="Select Locations :"
                                    Width="102px"></asp:Label>
                            </td>
                            <td valign="top">
                                <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txtLocs" runat="server" CssClass="input" Width="386px" Style="font-size: 8pt;
                                            font-family: Verdana"></asp:TextBox>                                        
                                        <asp:Button ID="lnkbtnSelect" runat="server" Text="..." ToolTip="Select Locations" />
                                        <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" EnableViewState="False"
                                            TargetControlID="lnkbtnSelect" PopupControlID="Panel1"
                                                BackgroundCssClass="modalBackground" DropShadow="True" OkControlID="btnSubmit"
                                                OnCancelScript="onCancel()" OnOkScript="onOk()" CancelControlID="btnCancle" />
                                        
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <asp:Panel ID="Panel2" runat="server" Height="1px" Width="1px">
                                    <asp:Panel ID="Panel1" runat="server" BackColor="White" >
                                        <table cellspacing="0" cellpadding="3" style="margin:5px 5px 5px 5px;">
                                            <tbody>
                                                <tr>
                                                    <td style="vertical-align: top; text-align: left; ">
                                                        <asp:Panel Style="vertical-align: top; text-align: left" ID="pnlModal" runat="server"
                                                            Font-Size="10pt" BackColor="White" Font-Names="Verdana"
                                                            ScrollBars="Vertical">
                                                            <asp:UpdatePanel ID="UpdatePanel6" runat="server" UpdateMode="Conditional">
                                                                <ContentTemplate>
                                                                    <asp:CheckBoxList ID="chklstLocation" runat="server" Font-Size="8pt" Font-Names="Verdana"
                                                                        RepeatDirection="Horizontal" RepeatColumns="3" CellSpacing="0"
                                                                        CellPadding="3">
                                                                    </asp:CheckBoxList>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100%; height: 24px; text-align: center">
                                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit"></asp:Button>
                                                        <asp:Button ID="btnCancle" runat="server" Text="Cancle"></asp:Button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" valign="top">
                                <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Select Date :" Width="102px"></asp:Label>
                            </td>
                            <td valign="top">
                                <uc1:RPT_Date ID="dtFromTo" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Profitability Status :"></asp:Label>
                            </td>
                            <td align="left">
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
                            <td align="left">
                                <table border="0" cellpadding="2" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Text="From "></asp:Label>
                                        </td>
                                        <td>
                                            <%--onkeypress="Javascript:return validFlot(event,this.getAttribute('id')); "--%>
                                            <asp:TextBox ID="txtMRFrom" runat="server" Columns="3" CssClass="input"></asp:TextBox><label class="blackfnt">%</label>
                                        </td>
                                        <td style="width: 10px;">
                                        </td>
                                        <td>
                                            <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Text="To "></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtMRTo" runat="server" Columns="3" CssClass="input"></asp:TextBox><label class="blackfnt">%</label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="2">
                                <asp:Button ID="btnShow"  runat="server" Text="Show" Width="75px" OnClick="btnShow_Click" />
                            </td>
                        </tr>
                        <tr id="Tr2" class="blackfnt" bgcolor="white" runat="server" visible="false">
                            <td colspan="2" align="center">
                                <b>OR</b></td>
                        </tr>
                        <tr id="Tr3" style="background-color: white" runat="server"  visible="false">
                            <td align="left">
                                <asp:Label ID="Label6" runat="server" CssClass="blackfnt" Text="Select Document :"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlDocType" runat="server">
                                    <asp:ListItem Text="Trip Sheet Number" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Vehicle Number" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="Tr4" style="background-color: white" runat="server"  visible="false">
                            <td align="left">
                                <asp:Label ID="Label7" runat="server" CssClass="blackfnt" Text="Select Document No. :"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtDocNo" runat="server" CssClass="input" Width="200px"></asp:TextBox>&nbsp;<label
                                    class="blackfnt">[ Enter coma (,) separated if multiple]</label>
                            </td>
                        </tr>
                        <tr id="Tr5" align="center" bgcolor="white" runat="server" visible="false">
                            <td colspan="2">
                                <asp:Button ID="btnShow2" runat="server" Text="Show" Width="75px"  OnClientClick="Javascript:return OnSub_DATACHECK()"  />
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
